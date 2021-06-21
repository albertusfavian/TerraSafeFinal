//
//  TrackEmergencyInfoVC.swift
//  TerraSafe
//
//  Created by Rony Fhebrian on 09/06/21.
//

import UIKit
import MapboxMaps
import Turf

class TrackEmergencyInfoViewController: UIViewController {
    internal var mapView: MapView!
    internal var pointAnnotationManager: PointAnnotationManager?
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    private var tileStore: TileStore?
    private var logger: OfflineManagerLogWriter!
    
    @IBOutlet weak var logView: UITextView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var stylePackProgressView: UIProgressView!
    @IBOutlet weak var tileRegionProgressView: UIProgressView!
    @IBOutlet weak var downloadMapButton: UIButton!
    
    internal var bearing: CLLocationDirection = 217
    internal var pitch: CGFloat = 80
    
    private lazy var mapInitOptions: MapInitOptions = {
        let accessToken = "sk.eyJ1Ijoicm9ueWZoZWJyaWFuIiwiYSI6ImNrcGZpb3lrMDIxbHIycGxsdnV3aWgyMmMifQ.rOTrlXaNZnmayRKptNjlcA"
        ResourceOptionsManager.default.resourceOptions.accessToken = accessToken

        let camera = CameraOptions(center: centerCoordinate,
                                   zoom: zoom,
                                   bearing: bearing,
                                   pitch: pitch)

        let options = MapInitOptions(
            cameraOptions: camera,
            styleURI: StyleURI(rawValue: "mapbox://styles/mapbox-map-design/ckhqrf2tz0dt119ny6azh975y")!)
        return options
    }()

    private lazy var offlineManager: OfflineManager = {
        return OfflineManager(resourceOptions: mapInitOptions.resourceOptions)
    }()

    
    var date: String = ""
    var temp: String = ""
    var distance: String = ""
    var duration: String = ""
    var titleTrack: String = ""
    
    private var downloads: [Cancelable] = []
    private let tileRegionId = "myTileRegion"
    private let centerCoordinate = CLLocationCoordinate2D(latitude: -7.3193251, longitude: 107.726672)
    private let zoom: CGFloat = 14
    
    private enum DownloadState {
        case unknown
        case initial
        case downloading
        case downloaded
        case mapViewDisplayed
        case finished
    }
    
    private var state: DownloadState = .unknown {
        didSet {
            logger?.log(message: "Changing state from \(oldValue) -> \(state)", category: "Example", color: .orange)

            switch (oldValue, state) {
            case (_, .initial):
                resetUI()

                let tileStore = TileStore.default
                let accessToken = ResourceOptionsManager.default.resourceOptions.accessToken
                tileStore.setOptionForKey(TileStoreOptions.mapboxAccessToken, value: accessToken as Any)

                self.tileStore = tileStore

                logger?.log(message: "Enabling HTTP stack network connection", category: "Example", color: .orange)
                OfflineSwitch.shared.isMapboxStackConnected = true

            case (.initial, .downloading):
                // Can cancel
                downloadMapButton.setTitle("Cancel Downloads", for: .normal)

            case (.downloading, .downloaded):
                logger?.log(message: "Disabling HTTP stack network connection", category: "Example", color: .orange)
                OfflineSwitch.shared.isMapboxStackConnected = false
                enableShowMapView()

            case (.downloaded, .mapViewDisplayed):
                showMapView()

            case (.mapViewDisplayed, .finished),
                 (.downloading, .finished):
                downloadMapButton.setTitle("Reset", for: .normal)

            default:
                fatalError("Invalid transition from \(oldValue) to \(state)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleTrack
        
        manageUserLocation()
        
        initAndCenterMap()

        initView()
        initLabel()
        
        logger = OfflineManagerLogWriter(textView: logView)
        state = .initial
        
        // Set GeoJSON
        mapView.mapboxMap.onNext(.mapLoaded) { _ in
            self.dateLabel.text = self.date
            self.tempLabel.text = "\(self.temp)°C"
            self.distanceLabel.text = self.distance
            self.durationLabel.text = self.duration
            self.addTerrain()
            self.setUpGeoJSON()
            
            self.setUpUserLocation()
        }
    }
    
    // MARK: - Download Actions
    
    internal func downloadTileRegions() {
        guard let tileStore = tileStore else {
            preconditionFailure()
        }
        
        precondition(downloads.isEmpty)
        
        let dispatchGroup = DispatchGroup()
        var downloadError = false
        
        // - - - - - - - - - -
        
        // 1. Create style package with loadStylePack() call
        let stylePackLoadOptions = StylePackLoadOptions(glyphsRasterizationMode: .ideographsRasterizedLocally, metadata: ["tag": "my-outdoors-style"], acceptExpired: false)!
        
        dispatchGroup.enter()
        let stylePackDownload = offlineManager.loadStylePack(for: .outdoors, loadOptions: stylePackLoadOptions) { [weak self] progress in
            // These closures do not get called from the main thread. In this case
            // we're updating the UI, so it's important to dispatch to the main
            // queue.
            DispatchQueue.main.async {
                guard let stylePackProgressView = self?.stylePackProgressView else {
                    return
                }

                self?.logger?.log(message: "StylePack = \(progress)", category: "Example")
                stylePackProgressView.progress = Float(progress.completedResourceCount) / Float(progress.requiredResourceCount)
            }

        } completion: { [weak self] result in
            DispatchQueue.main.async {
                defer {
                    dispatchGroup.leave()
                }

                switch result {
                case let .success(stylePack):
                    self?.logger?.log(message: "StylePack = \(stylePack)", category: "Example")

                case let .failure(error):
                    self?.logger?.log(message: "stylePack download Error = \(error)", category: "Example", color: .red)
                    downloadError = true
                }
            }
        }
        
        // 2. Create offline tiles with outdoors style
        let satelliteOptions = TilesetDescriptorOptions(styleURI: .satellite, zoomRange: 0...16)
        let satelliteDescriptiors = offlineManager.createTilesetDescriptor(for: satelliteOptions)
        
        // Load the tile region
        let tileRegionLoadOptions = TileRegionLoadOptions(geometry: Geometry(coordinate: centerCoordinate), descriptors: [satelliteDescriptiors], metadata: ["tag": "my-outdoors-style"], acceptExpired: false)!
        
        dispatchGroup.enter()
        let tileRegionDownload = tileStore.loadTileRegion(forId: tileRegionId,
                                                          loadOptions: tileRegionLoadOptions) { [weak self] (progress) in
            // These closures do not get called from the main thread. In this case
            // we're updating the UI, so it's important to dispatch to the main
            // queue.
            DispatchQueue.main.async {
                guard let tileRegionProgressView = self?.tileRegionProgressView else {
                    return
                }

                self?.logger?.log(message: "\(progress)", category: "Example")

                // Update the progress bar
                tileRegionProgressView.progress = Float(progress.completedResourceCount) / Float(progress.requiredResourceCount)
            }
        } completion: { [weak self] result in
            DispatchQueue.main.async {
                defer {
                    dispatchGroup.leave()
                }

                switch result {
                case let .success(tileRegion):
                    self?.logger?.log(message: "tileRegion = \(tileRegion)", category: "Example")

                case let .failure(error):
                    self?.logger?.log(message: "tileRegion download Error = \(error)", category: "Example", color: .red)
                    downloadError = true
                }
            }
        }
        
        // Wait for both downloads before moving to the next state
        dispatchGroup.notify(queue: .main) {
            self.downloads = []
            self.state = downloadError ? .finished : .downloaded
        }

        downloads = [stylePackDownload, tileRegionDownload]
        state = .downloading
    }
    
    internal func cancelDownloads() {
        // Canceling will trigger `.canceled` errors that will then change state
        downloads.forEach({ $0.cancel() })
    }
    
    private func logDownloadResult<T, Error>(message: String, result: Result<[T], Error>){
        switch result {
        case let .success(array):
            logger.log(message: message, category: "Example")
            for element in array {
                logger?.log(message: "\t\(element)", category: "Example")
            }
        case let .failure(error):
            logger?.log(message: "\(message) \(error)", category: "Example", color: .red)
        }
    }
    
    private func showDownloadedRegions() {
        guard let tileStore = tileStore else {
            preconditionFailure()
        }
        
        offlineManager.allStylePacks { result in
            self.logDownloadResult(message: "Style packs:", result: result)
        }
        
        tileStore.allTileRegions { result in
            self.logDownloadResult(message: "Tile regions:", result: result)
        }
        
        logger?.log(message: "\n", category: "Example")
    }
    
    @IBAction func downloadMapButtonDidTap(_ sender: UIButton) {
        switch state {
        case .unknown:
            state = .initial
        case .initial:
            downloadTileRegions()
        case .downloading:
            // Cancel
            cancelDownloads()
        case .downloaded:
            state = .mapViewDisplayed
        case .mapViewDisplayed:
            showDownloadedRegions()
            state = .finished
        case .finished:
            showDownloadedRegions()
            state = .initial
        }
    }
    
    private func resetUI() {
        logger?.reset()
        logView.textContainerInset.bottom = view.safeAreaInsets.bottom
        logView.scrollIndicatorInsets.bottom = view.safeAreaInsets.bottom

//        progressContainer.isHidden = false
        stylePackProgressView.progress = 0.0
        tileRegionProgressView.progress = 0.0

        downloadMapButton.setTitle("Start Downloads", for: .normal)

//        mapView?.removeFromSuperview()
//        mapView = nil
    }
    
    private func enableShowMapView() {
        downloadMapButton.setTitle("Show Map", for: .normal)
    }
    
    private func showMapView() {
        downloadMapButton.setTitle("Show Downloads", for: .normal)
//        progressContainer.isHidden = true

        // It's important that the MapView use the same ResourceOptions as the
        // OfflineManager
        let mapView = MapView(frame: view.bounds, mapInitOptions: mapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        // Add a point annotation that shows the point geometry that were passed
        // to the tile region API.
        mapView.mapboxMap.onNext(.styleLoaded) { [weak self] _ in
//            guard let self = self,
//                  let mapView = self.mapView else {
//                return
//            }

//            var pointAnnotation = PointAnnotation(coordinate: self.centerCoordinate)
//            pointAnnotation.image = .default
//
//            self.pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
//            self.pointAnnotationManager?.syncAnnotations([pointAnnotation])
            self?.setUpGeoJSON()
        }
        mapView.mapboxMap.setCamera(to: CameraOptions(pitch: CGFloat(0)))

        self.mapView = mapView
    }
    
    func setUpUserLocation() {
        let configuration = Puck2DConfiguration(topImage: UIImage(named: "ic_hiker"))
        mapView.location.options.puckType = .puck2D(configuration)
    }
    
    func manageUserLocation() {
        locationManager.delegate = self
        locationManager.requestLocation()
        
        locationManager.requestAlwaysAuthorization()
    }

    func initView() {
        self.view.bringSubviewToFront(dateView)
        self.view.bringSubviewToFront(distanceView)
        self.view.bringSubviewToFront(durationView)
        self.view.bringSubviewToFront(logView)
        self.view.bringSubviewToFront(stylePackProgressView)
        self.view.bringSubviewToFront(tileRegionProgressView)
        self.view.bringSubviewToFront(downloadMapButton)
    }

    func initLabel() {
        dateLabel.textColor = .white
        tempLabel.textColor = .white
        distanceLabel.textColor = .white
        durationLabel.textColor = .white
    }


    override func viewWillAppear(_ animated: Bool) {
        hideTabBar()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        showTabBar()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }

    func initAndCenterMap() {
//        let accessToken = "sk.eyJ1Ijoicm9ueWZoZWJyaWFuIiwiYSI6ImNrcGZpb3lrMDIxbHIycGxsdnV3aWgyMmMifQ.rOTrlXaNZnmayRKptNjlcA"
//        ResourceOptionsManager.default.resourceOptions.accessToken = accessToken
//
//        let camera = CameraOptions(center: centerCoordinate,
//                                   zoom: zoom,
//                                   bearing: 217,
//                                   pitch: 80)
//
//        let options = MapInitOptions(
//            cameraOptions: camera,
//            styleURI: StyleURI(rawValue: "mapbox://styles/mapbox-map-design/ckhqrf2tz0dt119ny6azh975y")!)

        mapView = MapView(frame: view.bounds, mapInitOptions: mapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.ornaments.options.scaleBar.visibility = .visible
        
//        let bounds = CoordinateBounds(southwest: CLLocationCoordinate2D(latitude: -7.2648290061741365, longitude: 107.81201375607087), northeast: CLLocationCoordinate2D(latitude: -7.363248083832096, longitude: 107.6725416749965))
//        mapView.camera.options = CameraBoundsOptions(bounds: bounds, maxZoom: nil, minZoom: nil, maxPitch: nil, minPitch: nil)
//        let c = mapView.mapboxMap.camera(for: bounds, padding: .zero, bearing: bearing, pitch: Double(pitch))
//        mapView.mapboxMap.setCamera(to: c)
        
        view.addSubview(mapView)
    }

    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1
    }

    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
    }

    internal func decodeGeoJSON(from fileName: String) throws -> FeatureCollection? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            preconditionFailure("File not found")
        }

        let filePath = URL(fileURLWithPath: path)

        var featureCollection: FeatureCollection?

        do {
            let data = try Data(contentsOf: filePath)
            featureCollection = try GeoJSON.parse(FeatureCollection.self, from: data)
        } catch {
            print(error)
        }

        return featureCollection
    }

    func setUpGeoJSON() {
        guard let featureCollection = try? decodeGeoJSON(from: "g1t1") else { return }

        let geoJSONDataIdentifier = "g1t1"

        // Create GeoJSON data source
        var geoJSONSource = GeoJSONSource()
        geoJSONSource.data = .featureCollection(featureCollection)

        var lineLayer = LineLayer(id: "line-layer")
        lineLayer.filter = Exp(.eq) {
            "$type"
            "LineString"
        }
        lineLayer.source = geoJSONDataIdentifier
        lineLayer.lineColor = .constant(ColorRepresentable(color: UIColor.yellow))
        lineLayer.lineWidth = .constant(4)

        // Add the source and style layers to the map style.
        try! mapView.mapboxMap.style.addSource(geoJSONSource, id: geoJSONDataIdentifier)
        try! mapView.mapboxMap.style.addLayer(lineLayer)

        let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
        var points: [PointAnnotation] = []

        for f in featureCollection.features {
            if (f.geometry.type.rawValue == "Point") {
                guard let property = f.properties else { return }
                guard let value = f.geometry.value as? Point else { return }

                var checkPoint = PointAnnotation(point: .init(.init(latitude: value.coordinates.latitude, longitude: value.coordinates.longitude)))

                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))

                if (property["kind"] as! String == "park") {
                    imageView.image = UIImage(named: "ic_park")
                    checkPoint.image = .custom(image: imageView.image!, name: (property["title"] as? String)!)
                } else if (property["kind"] as! String == "summit") {
                    imageView.image = UIImage(named: "ic_summit")
                    checkPoint.image = .custom(image: imageView.image!, name: (property["title"] as? String)!)
                } else if (property["kind"] as! String == "checkpoint") {
                    imageView.image = UIImage(named: "ic_checkpoint")
                    checkPoint.image = .custom(image: imageView.image!, name: (property["posName"] as? String)!)
                }

                points.append(checkPoint)
            }
        }

        pointAnnotationManager.syncAnnotations(points)
        self.pointAnnotationManager = pointAnnotationManager

        self.pointAnnotationManager?.delegate = self
    }

    func addTerrain() {
        var demSource = RasterDemSource()
        demSource.url = "mapbox://mapbox.mapbox-terrain-dem-v1"
        demSource.tileSize = 512
        demSource.maxzoom = 14.0
        try! mapView.mapboxMap.style.addSource(demSource, id: "mapbox-dem")

        var terrain = Terrain(sourceId: "mapbox-dem")
        terrain.exaggeration = .constant(1.5)

        try! mapView.mapboxMap.style.setTerrain(terrain)

        var skyLayer = SkyLayer(id: "sky-layer")
        skyLayer.skyType = .constant(.atmosphere)
        skyLayer.skyAtmosphereSun = .constant([0.0, 0.0])
        skyLayer.skyAtmosphereSunIntensity = .constant(15.0)

        try! mapView.mapboxMap.style.addLayer(skyLayer)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TrackEmergencyInfoViewController: AnnotationInteractionDelegate {
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        if (annotations.count > 0) {
            guard let annotation = annotations[0] as? PointAnnotation else { return }
            guard let value = annotation.feature.geometry.value as? Point else { return }

            let alert = UIAlertController(title: annotation.feature.properties!["icon-image"] as? String, message: "Berada di lokasi latitude \(value.coordinates.latitude) dan longitude \(value.coordinates.longitude)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension TrackEmergencyInfoViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - Convenience classes for tile and style classes

extension TileRegionLoadProgress {
    public override var description: String {
        "TileRegionLoadProgress: \(completedResourceCount) / \(requiredResourceCount)"
    }
}

extension StylePackLoadProgress {
    public override var description: String {
        "StylePackLoadProgress: \(completedResourceCount) / \(requiredResourceCount)"
    }
}

extension TileRegion {
    public override var description: String {
        "TileRegion \(id): \(completedResourceCount) / \(requiredResourceCount)"
    }
}

extension StylePack {
    public override var description: String {
        "StylePack \(styleURI): \(completedResourceCount) / \(requiredResourceCount)"
    }
}


public final class OfflineManagerLogWriter {
    weak var textView: UITextView?
    var log: NSMutableAttributedString
    
    internal init(textView: UITextView) {
        self.log
         = NSMutableAttributedString()
        self.textView = textView
    }
    
    public func reset() {
        log = NSMutableAttributedString()
        textView?.attributedText = log
    }
    
    public func log(message: String, category: String?, color: UIColor = .black) {
        print("\(category ?? "") \(message)")
        
        DispatchQueue.main.async { [weak self] in
            guard let textView = self?.textView,
                              let log = self?.log else {
                            return
                        }
            
            let message = NSMutableAttributedString(string: "\(message)\n", attributes: [NSAttributedString.Key.foregroundColor: color])
            log.append(message)
            
            textView.attributedText = log
        }
    }
}
