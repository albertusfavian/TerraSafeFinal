//
//  MapsViewController.swift
//  TerraSafe
//
//  Created by Gede Wicaksana on 11/06/21.
//

import UIKit
import CoreData
import MapboxMaps
import Turf

class MapsViewController: UIViewController{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Array Test
    var arrayPos = [Pos]()
    
    
    
    // MARK: -Special pake telor buat bang rony, dah ada isinya dari controller sebelah
    var trackName: String = ""
    var bearing: Double?
    var latitude: Double?
    var longtitude: Double?
    var maxNorthEastLat: Double?
    var maxNorthEastLong: Double?
    var maxSouthWestLat: Double?
    var maxSouthWestLong: Double?
    
    internal var mapView: MapView!
    internal var pointAnnotationManager: PointAnnotationManager?
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    private var tileStore: TileStore?
    private var logger: OfflineManagerLogWriter!
    
    
    
    // MARK -Initiate IBOutlet
    @IBOutlet weak var dragview: UIView!
    @IBOutlet weak var posDrawerView: UIView!
    @IBOutlet weak var wisataDrawerView: UIView!
    
    @IBOutlet weak var posImages: UICollectionView!
    @IBOutlet weak var posFacilities: UICollectionView!
    @IBOutlet weak var posDangers: UICollectionView!
    
    @IBOutlet weak var wisataImages: UICollectionView!
    @IBOutlet weak var wisataFacilities: UICollectionView!
    @IBOutlet weak var wisataDangers: UICollectionView!
    
    @IBOutlet weak var stylePackProgressView: UIProgressView!
    @IBOutlet weak var posTitle: UILabel!
    @IBOutlet weak var posDesc: UILabel!
    @IBOutlet weak var downloadMapButton: UIBarButtonItem!
    @IBOutlet weak var tileRegionProgressView: UIProgressView!
    @IBOutlet weak var logViewerTextView: UITextView!
    
    @IBOutlet weak var loggerView: UIView!
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
    
//    internal var bearing: CLLocationDirection = 217
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
                // Alert Cancel
                downloadMapButton.isEnabled = false

            case (.downloading, .downloaded):
                logger?.log(message: "Disabling HTTP stack network connection", category: "Example", color: .orange)
                OfflineSwitch.shared.isMapboxStackConnected = false
                showMapView()
                

            case (.downloaded, .mapViewDisplayed):
                showMapView()
                downloadMapButton.isEnabled = false

            case (.mapViewDisplayed, .finished), (.downloading, .finished):
                downloadMapButton.isEnabled = false

            default:
                fatalError("Invalid transition from \(oldValue) to \(state)")
            }
        }
    }
    
//    private func enableShowMapView() {
        // MARK
//        downloadMapButton.setTitle("Show Map", for: .normal)
//    }
    
    override func viewDidLoad() {
        self.title = trackName
        registerPostXib()
        
        manageUserLocation()
        
        initAndCenterMap()

        initView()
//        initLabel()

//        logger = OfflineManagerLogWriter(textView: logView)
        state = .initial
        
        // Set GeoJSON
        mapView.mapboxMap.onNext(.mapLoaded) { _ in
            // MARK
//            self.dateLabel.text = self.date
//            self.tempLabel.text = "\(self.temp)°C"
//            self.distanceLabel.text = self.distance
//            self.durationLabel.text = self.duration
            self.addTerrain()
            self.setUpGeoJSON()
            
            self.setUpUserLocation()
        }
    }
    
    func registerPostXib() {
        let nib11 = UINib(nibName: "\(PosImageCollectionViewCell.self)", bundle: nil)
        posImages.register(nib11, forCellWithReuseIdentifier: "posImageCell")
        
        let nib12 = UINib(nibName: "\(PosFacilitiesCollectionViewCell.self)", bundle: nil)
        posFacilities.register(nib12, forCellWithReuseIdentifier: "posFacilitiesCell")
        
        let nib13 = UINib(nibName: "\(PosDangerCollectionViewCell.self)", bundle: nil)
        posDangers.register(nib13, forCellWithReuseIdentifier: "posDangerCell")
        
        let nib21 = UINib(nibName: "\(WisataImageCollectionViewCell.self)", bundle: nil)
        wisataImages.register(nib21, forCellWithReuseIdentifier: "wisataImageCell")
        
        let nib22 = UINib(nibName: "\(WisataFacilitiesCollectionViewCell.self)", bundle: nil)
        wisataFacilities.register(nib22, forCellWithReuseIdentifier: "wisataFacilitiesCell")
        
        let nib23 = UINib(nibName: "\(WisataDangerCollectionViewCell.self)", bundle: nil)
        wisataDangers.register(nib23, forCellWithReuseIdentifier: "wisataDangerCell")
    }
    
    // MARK: Mapbox Mapping and Offline Maps
    func manageUserLocation() {
        locationManager.delegate = self
        locationManager.requestLocation()
        
        locationManager.requestAlwaysAuthorization()
    }
    
    func setUpUserLocation() {
        let configuration = Puck2DConfiguration(topImage: UIImage(named: "ic_hiker"))
        mapView.location.options.puckType = .puck2D(configuration)
    }
    
    func initAndCenterMap() {
        mapView = MapView(frame: view.bounds, mapInitOptions: mapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.ornaments.options.scaleBar.visibility = .visible

        view.addSubview(mapView)
    }
    
    
    func initView() {
//        self.view.bringSubviewToFront(dateView)
//        self.view.bringSubviewToFront(distanceView)
//        self.view.bringSubviewToFront(durationView)
        self.view.bringSubviewToFront(logViewerTextView)
        self.view.bringSubviewToFront(stylePackProgressView)
        self.view.bringSubviewToFront(tileRegionProgressView)
        self.view.bringSubviewToFront(dragview)
        self.view.bringSubviewToFront(loggerView)
    }
     
    /*
    func initLabel() {
        dateLabel.textColor = .white
        tempLabel.textColor = .white
        distanceLabel.textColor = .white
        durationLabel.textColor = .white
    }
    */
    
    private func resetUI() {
        logger?.reset()
        // MARK
//        logView.textContainerInset.bottom = view.safeAreaInsets.bottom
//        logView.scrollIndicatorInsets.bottom = view.safeAreaInsets.bottom
//
////        progressContainer.isHidden = false
//        stylePackProgressView.progress = 0.0
//        tileRegionProgressView.progress = 0.0
//
//        downloadMapButton.setTitle("Start Downloads", for: .normal)

//        mapView?.removeFromSuperview()
//        mapView = nil
    }
    
    private func showMapView() {
        // MARK

        // It's important that the MapView use the same ResourceOptions as the
        // OfflineManager
        let mapView = MapView(frame: view.bounds, mapInitOptions: mapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        // Add a point annotation that shows the point geometry that were passed
        // to the tile region API.
        mapView.mapboxMap.onNext(.styleLoaded) { [weak self] _ in
            self?.setUpGeoJSON()
        }
        
        mapView.mapboxMap.setCamera(to: CameraOptions(pitch: CGFloat(0)))

        self.mapView = mapView
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
//                    checkPoint.feature.properties
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

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        DispatchQueue.main.async {
            self.dragview.center = CGPoint(x: self.dragview.center.x, y: 2000)
            self.wisataDrawerView.isHidden = true
            self.posDrawerView.isHidden = true
        }
    
    }
    
    @IBAction func didTabDownloadBarButton(_ sender: UIBarButtonItem) {
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
    
//     MARK: -Data Manipulation
    var PosImages = [
        posImagesData(posImage: UIImage(named: "img_pondok_saladah_1")!),
        posImagesData(posImage: UIImage(named: "img_pondok_saladah_2")!),
        posImagesData(posImage: UIImage(named: "img_pondok_saladah_3")!)
    ]

    var PosFacilities = [
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Water drop icon")!, posFacilitiesTitle: "Water Source"),
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Registration icon")!, posFacilitiesTitle: "Registration"),
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Parking slot icon")!, posFacilitiesTitle: "Parking Slot"),
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Waroeng icon")!, posFacilitiesTitle: "Waroeng"),
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Camp icon")!, posFacilitiesTitle: "Camp")

    ]

    var PosDangers = [
        posDangersData(posDangerImage: UIImage(named: "Boar icon")!, posDangerTitle: "Boar")
    ]

    var WisataImages = [
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "img_tegal_alun_1")),
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "SignForLost.4")),
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "TerrainCondition.5"))
    ]

    var WisataFacilities = [
        wisataFacilitiesData(wisataFacilitiesImage: #imageLiteral(resourceName: "Water drop icon"), wisataFacilitiesTitle: "Water Source"),
        wisataFacilitiesData(wisataFacilitiesImage: UIImage(named: "Photo icon")!, wisataFacilitiesTitle: "Photo Spot")
    ]

    var WisataDangers = [
        wisataDangersData(wisataDangerImage: UIImage(named: "Sulphuric icon")!, wisataDangerTitle: "Sulphuric Atmosphere"),
        wisataDangersData(wisataDangerImage: UIImage(named: "Fog icon")!, wisataDangerTitle: "Occasional Thick Fog"),
        wisataDangersData(wisataDangerImage: UIImage(named: "Eruption icon")!, wisataDangerTitle: "Occasional Eruption")
    ]
    
    
//    func loadPos(posName: String){
//        let request : NSFetchRequest<Pos> = Pos.fetchRequest()
//        print(trackName)
//        let trackPredicate = NSPredicate(format: "track.trackName MATCHES %@", trackName)
//        let posPredicate = NSPredicate(format: "posName MATCHES %@", posName)
//        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [posPredicate, trackPredicate])
//        do {
//            arrayPos = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }

    
    
//
//    func loadPos(){
//        let request : NSFetchRequest<Pos> = Pos.fetchRequest()
//        let predicate = NSPredicate(format: "Track.trackName MATCHES %@", trackName!)
//        request.predicate = predicate
//        do {
//            arrayPos = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
    
    
    
    
    // MARK: - bar bar mode
    func removeAll(){
        PosImages.removeAll()
        PosFacilities.removeAll()
        PosDangers.removeAll()
    }
    func loadPos1(){
        posTitle.text = "Pos 1 (Camp David)"
        posDesc.text = "Wide and not precitipous. No significant dangers along track conditions."
        PosImages = [
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_1")!),
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_2")!),
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_3")!)
        ]

        PosFacilities = [
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Water drop icon")!, posFacilitiesTitle: "Water Source"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Registration icon")!, posFacilitiesTitle: "Registration"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Parking slot icon")!, posFacilitiesTitle: "Parking Slot"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Waroeng icon")!, posFacilitiesTitle: "Waroeng"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Camp icon")!, posFacilitiesTitle: "Camp")

        ]

        PosDangers = [
            posDangersData(posDangerImage: UIImage(named: "Boar icon")!, posDangerTitle: "Boar")
        ]
    }
    func loadPos2(){
        posTitle.text = "Pos 2 (Camp Pondok Salada)"
        posDesc.text = "Steep and slippery on some track location, with reports about possible landslide. Be cautious along the track."
        PosImages = [
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_1")!),
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_2")!),
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_3")!)
        ]
        PosFacilities = [
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Water drop icon")!, posFacilitiesTitle: "Water Source"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Waroeng icon")!, posFacilitiesTitle: "Waroeng"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Camp icon")!, posFacilitiesTitle: "Camp")

        ]

        PosDangers = [
            posDangersData(posDangerImage: UIImage(named: "Boar icon")!, posDangerTitle: "Boar"),
            posDangersData(posDangerImage: UIImage(named: "Black panther icon")!, posDangerTitle: "Black Panther")
        ]
        posImages.reloadData()
        posDangers.reloadData()
        posFacilities.reloadData()
    }
    
    func loadPos3(){
        posTitle.text = "Pos 3 (Tegal Alun)"
        posDesc.text = "Slippery on some location, with sulphur aroma dominating the atmosphere. Be cautious along the track and use face mask to protect respiratory systems. This is the last post before reaching the summit, prepare in advance."
        PosImages = [
            posImagesData(posImage: UIImage(named: "img_tegal_alun_1")!),
            posImagesData(posImage: UIImage(named: "img_tegal_alun_2")!),
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_3")!)
        ]
        PosFacilities = [
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Water drop icon")!, posFacilitiesTitle: "Water Source"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Edelweiss icon")!, posFacilitiesTitle: "Edelweiss")

        ]

        PosDangers = [
            posDangersData(posDangerImage: UIImage(named: "Sulphuric icon")!, posDangerTitle: "Sulphur"),
            posDangersData(posDangerImage: UIImage(named: "Fog icon")!, posDangerTitle: "Fog")
        ]
        posImages.reloadData()
        posDangers.reloadData()
        posFacilities.reloadData()
    }
    
    
    
    // MARK: -Drawer Setup buat merge ni bang
    @IBAction func popup(_ sender: UIButton) {
        if  sender.titleLabel?.text == "Pos1"{
            posDrawerView.isHidden = false
            wisataDrawerView.isHidden = true
            removeAll()
            loadPos1()
        }else if sender.titleLabel?.text == "Pos2"{
            posDrawerView.isHidden = false
            wisataDrawerView.isHidden = true
            removeAll()
            loadPos2()
        }else if sender.titleLabel?.text == "Pos3"{
            posDrawerView.isHidden = false
            wisataDrawerView.isHidden = true
            removeAll()
            loadPos3()
        }else if sender.titleLabel?.text == "Wisata"{
            posDrawerView.isHidden = true
            wisataDrawerView.isHidden = false
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) { [self] in
                dragview.center = CGPoint(x: dragview.center.x, y: 950)
            }
        }
    }

    
    
    
    @IBAction func emergencyCall(_ sender: UIButton){
        let alertController = UIAlertController(title: "Emergency Call", message: "Mountain Papandayan", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Call Nearest Police ", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Call Nearest Hospital", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteDrawer(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) { [self] in
            dragview.center = CGPoint(x: dragview.center.x, y: 2000)
        }
    }
    @IBAction func slide(_ sender: UIPanGestureRecognizer) {
        guard let targetView = sender.view else {return}
        var translation = sender.translation(in: dragview)
        let dragVelocity = sender.velocity(in: dragview)
        
        
        if targetView.center.y <= 500 && translation.y < 0{
            translation.y = 0
        }
        
        
       
        
        if dragVelocity.y >= 1000{
            translation.y = 0
            if targetView.center.y <= 800{
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 950)
                }
            } else if targetView.center.y >= 951 {
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 2000)
                }
            }
        
        }else if dragVelocity.y <= -1000 {
            translation.y = 0
            if targetView.center.y <= 949{
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 500)
                }
            }
            
            
        }
        if sender.state == .ended {
            translation.y = 0
            if (targetView.center.y <= 749 && targetView.center.y >= 500) {
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 500)
                }
                
            }else if (targetView.center.y >= 750 && targetView.center.y <= 1000) {
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 950)
                }
                
            }else if targetView.center.y >= 1001{
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 2000)
                }
            }
        }
        
        targetView.center = CGPoint(x: targetView.center.x, y: targetView.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: view)
    }
    


}



// MARK: -Collection View Setup
extension MapsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView ==  posImages{
            return PosImages.count
        }else if collectionView == posFacilities{
            return PosFacilities.count
        }else if collectionView == posDangers{
            return PosDangers.count
        }else if collectionView == wisataImages{
            return WisataImages.count
        }else if collectionView == wisataFacilities{
            return WisataFacilities.count
        }else{
            return WisataDangers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == posImages{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posImageCell", for: indexPath) as! PosImageCollectionViewCell
            cell.posImage.image = PosImages[indexPath.row].posImage
            
            return cell
        }else if collectionView == posFacilities{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posFacilitiesCell", for: indexPath) as! PosFacilitiesCollectionViewCell
            cell.facilitiesImage.image = PosFacilities[indexPath.row].posFacilitiesImage
            cell.facilitiesTitle.text = PosFacilities[indexPath.row].posFacilitiesTitle
            
            return cell
        }else if collectionView == posDangers{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posDangerCell", for: indexPath) as! PosDangerCollectionViewCell
            cell.dangerImage.image = PosDangers[indexPath.row].posDangerImage
            cell.dangerTitle.text = PosDangers[indexPath.row].posDangerTitle
            
            return cell
        }else if collectionView == wisataImages{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wisataImageCell", for: indexPath) as! WisataImageCollectionViewCell
            cell.wisataImage.image = WisataImages[indexPath.row].wisataImage
            
            return cell
            
        }else if collectionView == wisataFacilities{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wisataFacilitiesCell", for: indexPath) as! WisataFacilitiesCollectionViewCell
            cell.facilitiesImage.image = WisataFacilities[indexPath.row].wisataFacilitiesImage
            cell.facilitiesTitle.text = WisataFacilities[indexPath.row].wisataFacilitiesTitle
            
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wisataDangerCell", for: indexPath) as! WisataDangerCollectionViewCell
            cell.dangerImage.image = WisataDangers[indexPath.row].wisataDangerImage
            cell.dangerTitle.text = WisataDangers[indexPath.row].wisataDangerTitle
            
            return cell
            
        }
        
    
    }
    
    
}

extension MapsViewController: AnnotationInteractionDelegate {
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        if (annotations.count > 0) {
            guard let annotation = annotations[0] as? PointAnnotation else { return }
            guard let value = annotation.feature.geometry.value as? Point else { return }

//            let alert = UIAlertController(title: annotation.feature.properties!["icon-image"] as? String, message: "Berada di lokasi latitude \(value.coordinates.latitude) dan longitude \(value.coordinates.longitude)", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
            
            print(annotation.feature.properties!["icon-image"] as? String)
            if (annotation.feature.properties!["icon-image"] as! String == "Pos1") {
                print(1)
                posDrawerView.isHidden = false
                wisataDrawerView.isHidden = true
                removeAll()
                loadPos1()
            }
            else if (annotation.feature.properties!["icon-image"] as! String == "Pos2") {
                posDrawerView.isHidden = false
                wisataDrawerView.isHidden = true
                removeAll()
                loadPos2()
            } else if (annotation.feature.properties!["icon-image"] as! String == "Pos3") {
                posDrawerView.isHidden = false
                wisataDrawerView.isHidden = true
                removeAll()
                loadPos3()
            } else if (annotation.feature.properties!["icon-image"] as! String == "Wisata") {
                posDrawerView.isHidden = true
                wisataDrawerView.isHidden = false
            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) { [self] in
                    dragview.center = CGPoint(x: dragview.center.x, y: 950)
                }
            }
        }
    }
}

extension MapsViewController: CLLocationManagerDelegate {
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
