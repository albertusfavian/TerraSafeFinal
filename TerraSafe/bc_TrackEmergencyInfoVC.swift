////
////  TrackEmergencyInfoVC.swift
////  TerraSafe
////
////  Created by Rony Fhebrian on 09/06/21.
////
//
//import UIKit
//import MapboxMaps
//import Turf
//
//class TrackEmergencyInfoVC: UIViewController {
//    internal var mapView: MapView!
//    internal var pointAnnotationManager: PointAnnotationManager?
//    @IBOutlet weak var dateView: UIView!
//    @IBOutlet weak var distanceView: UIView!
//    @IBOutlet weak var durationView: UIView!
//    
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var tempLabel: UILabel!
//    @IBOutlet weak var distanceLabel: UILabel!
//    @IBOutlet weak var durationLabel: UILabel!
//    
//    var titleTrack: String = ""
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = titleTrack
//        initAndCenterMap()
//        
//        // Set GeoJSON
//        mapView.mapboxMap.onNext(.mapLoaded) { _ in
//            self.addTerrain()
//            self.setUpGeoJSON()
//        }
//        
//        initView()
//        initLabel()
//    }
//    
//    func initView() {
//        self.view.bringSubviewToFront(dateView)
//        self.view.bringSubviewToFront(distanceView)
//        self.view.bringSubviewToFront(durationView)
//    }
//    
//    func initLabel() {
//        dateLabel.textColor = .white
//        tempLabel.textColor = .white
//        distanceLabel.textColor = .white
//        durationLabel.textColor = .white
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        hideTabBar()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        showTabBar()
//    }
//    
//    func initAndCenterMap() {
//        let accessToken = "sk.eyJ1Ijoicm9ueWZoZWJyaWFuIiwiYSI6ImNrcGZpb3lrMDIxbHIycGxsdnV3aWgyMmMifQ.rOTrlXaNZnmayRKptNjlcA"
//        ResourceOptionsManager.default.resourceOptions.accessToken = accessToken
//        let centerCoordinate = CLLocationCoordinate2D(latitude: -7.3193251, longitude: 107.726672)
//        
//        let camera = CameraOptions(center: centerCoordinate,
//                                   zoom: 14,
//                                   bearing: 217,
//                                   pitch: 80)
//        
//        let options = MapInitOptions(
//            cameraOptions: camera,
//            styleURI: StyleURI(rawValue: "mapbox://styles/mapbox-map-design/ckhqrf2tz0dt119ny6azh975y")!)
//        
//        mapView = MapView(frame: view.bounds, mapInitOptions: options)
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.ornaments.options.scaleBar.visibility = .visible
//        view.addSubview(mapView)
//    }
//    
//    func hideTabBar() {
//        self.tabBarController?.tabBar.isHidden = true
//        self.tabBarController?.tabBar.layer.zPosition = -1
//    }
//    
//    func showTabBar() {
//        self.tabBarController?.tabBar.isHidden = false
//        self.tabBarController?.tabBar.layer.zPosition = 0
//    }
//    
//    internal func decodeGeoJSON(from fileName: String) throws -> FeatureCollection? {
//        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
//            preconditionFailure("File not found")
//        }
//        
//        let filePath = URL(fileURLWithPath: path)
//        
//        var featureCollection: FeatureCollection?
//        
//        do {
//            let data = try Data(contentsOf: filePath)
//            featureCollection = try GeoJSON.parse(FeatureCollection.self, from: data)
//        } catch {
//            print(error)
//        }
//        
//        return featureCollection
//    }
//    
//    func setUpGeoJSON() {
//        guard let featureCollection = try? decodeGeoJSON(from: "g1t1") else { return }
//        
//        let geoJSONDataIdentifier = "g1t1"
//        
//        // Create GeoJSON data source
//        var geoJSONSource = GeoJSONSource()
//        geoJSONSource.data = .featureCollection(featureCollection)
//        
//        var lineLayer = LineLayer(id: "line-layer")
//        lineLayer.filter = Exp(.eq) {
//            "$type"
//            "LineString"
//        }
//        lineLayer.source = geoJSONDataIdentifier
//        lineLayer.lineColor = .constant(ColorRepresentable(color: UIColor.yellow))
//        lineLayer.lineWidth = .constant(4)
//        
//        // Add the source and style layers to the map style.
//        try! mapView.mapboxMap.style.addSource(geoJSONSource, id: geoJSONDataIdentifier)
//        try! mapView.mapboxMap.style.addLayer(lineLayer)
//        
//        let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
//        var points: [PointAnnotation] = []
//        
//        for f in featureCollection.features {
//            if (f.geometry.type.rawValue == "Point") {
//                guard let property = f.properties else { return }
//                guard let value = f.geometry.value as? Point else { return }
//                
//                var checkPoint = PointAnnotation(point: .init(.init(latitude: value.coordinates.latitude, longitude: value.coordinates.longitude)))
//                
//                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
//                
//                if (property["kind"] as! String == "park") {
//                    imageView.image = UIImage(named: "ic_park")
//                    checkPoint.image = .custom(image: imageView.image!, name: (property["title"] as? String)!)
//                } else if (property["kind"] as! String == "summit") {
//                    imageView.image = UIImage(named: "ic_summit")
//                    checkPoint.image = .custom(image: imageView.image!, name: (property["title"] as? String)!)
//                } else if (property["kind"] as! String == "checkpoint") {
//                    imageView.image = UIImage(named: "ic_checkpoint")
//                    checkPoint.image = .custom(image: imageView.image!, name: (property["posName"] as? String)!)
//                }
//                
//                points.append(checkPoint)
//            }
//        }
//        
//        pointAnnotationManager.syncAnnotations(points)
//        self.pointAnnotationManager = pointAnnotationManager
//        
//        self.pointAnnotationManager?.delegate = self
//    }
//    
//    func addTerrain() {
//        var demSource = RasterDemSource()
//        demSource.url = "mapbox://mapbox.mapbox-terrain-dem-v1"
//        demSource.tileSize = 512
//        demSource.maxzoom = 14.0
//        try! mapView.mapboxMap.style.addSource(demSource, id: "mapbox-dem")
//
//        var terrain = Terrain(sourceId: "mapbox-dem")
//        terrain.exaggeration = .constant(1.5)
//
//        try! mapView.mapboxMap.style.setTerrain(terrain)
//
//        var skyLayer = SkyLayer(id: "sky-layer")
//        skyLayer.skyType = .constant(.atmosphere)
//        skyLayer.skyAtmosphereSun = .constant([0.0, 0.0])
//        skyLayer.skyAtmosphereSunIntensity = .constant(15.0)
//
//        try! mapView.mapboxMap.style.addLayer(skyLayer)
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension TrackEmergencyInfoVC: AnnotationInteractionDelegate {
//    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
//        let annotation = annotations[0] as? PointAnnotation
//        guard let value = annotations[0].feature.geometry.value as? Point else { return }
//        
//        let alert = UIAlertController(title: annotation?.feature.properties!["icon-image"] as! String, message: "Berada di lokasi latitude \(value.coordinates.latitude) dan longitude \(value.coordinates.longitude)", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    
//}
