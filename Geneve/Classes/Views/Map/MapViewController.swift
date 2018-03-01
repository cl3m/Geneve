//
//  MapViewController.swift
//  Geneve
//
//  Created by Clem on 28.02.18.
//

import UIKit
import MapKit

class MapViewController: GAIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MKMapViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var mapView: MKMapView!
    var kml: KMLDocument?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: 100, height: collectionView.frame.size.height)
        }
        mapView.delegate = self
        mapView.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
        mapView.showsScale = true
        let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(46.2044, 6.1432), 5000, 5000)
        mapView.setRegion(region, animated: false)
        loadKML()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    //MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !annotation.isKind(of: MKUserLocation.self) {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            view.pinTintColor = UIColor(red:0.85, green:0.23, blue:0.12, alpha:1.0)
            return view
        }
        return nil
    }
    
    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kml?.folders.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! MapCell
        cell.nameLabel.text = kml!.folders[indexPath.row].description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.showsUserLocation = true
        mapView.addAnnotations(kml!.folders[indexPath.row].annotations)
    }
    
    fileprivate func loadKML() {
        if let url = Bundle.main.url(forResource: "Genève", withExtension: "kml") {
            KMLDocument.parse(url: url, callback: { [unowned self] kml in
                self.kml = kml
                let firstItem = IndexPath(item: 0, section: 0)
                self.collectionView.reloadData()
                self.collectionView.selectItem(at: firstItem, animated: false, scrollPosition: .centeredHorizontally)
                self.collectionView(self.collectionView, didSelectItemAt: firstItem)
            })
        }
        
    }
}
