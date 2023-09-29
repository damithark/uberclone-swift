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
        
//        if let coordinate = locationViewModel.selectedLocationCoordinate {
//            print("DEBUG: Selected location in map view \(coordinate)")
//            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
//        }
        var coordinate = locationViewModel.selectedLocationCoordinate {
            didSet {
                print("DEBUG: Selected location in map view \(String(describing: coordinate))")
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                context.coordinator.configurePolyline(withDestination: coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
            }
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
        var userCurrentLocationCoordinate: CLLocationCoordinate2D?
        
        // MARK: - Lifecycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userCurrentLocationCoordinate = userLocation.coordinate
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
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configurePolyline(withDestination coordinate: CLLocationCoordinate2D) {
            guard let userLocationCordinate = self.userCurrentLocationCoordinate else { return }
            getDestinationRoute(from: userLocationCordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                
            }
        }
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destinationCoordinate)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            let directions = MKDirections(request: request)
            
            directions.calculate { response, error in
                if let error = error {
                    print("DEBUG: Failed to get directions with error")
                    return
                }
                guard let  route = response?.routes.first else { return }
                completion(route)
            }
        }
    }
}
