//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Damitha Raveendra on 2023-09-15.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationViewModel.selectedLocationCoordinate {
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: - Properties
        let parent: UberMapViewRepresentable
        
        // MARK: - Lifecycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        // MARK - Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotation(parent.mapView.annotations as! MKAnnotation)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            self.parent.mapView.addAnnotation(annotation)
            self.parent.mapView.selectAnnotation(annotation, animated: true)
        }
    }
}
