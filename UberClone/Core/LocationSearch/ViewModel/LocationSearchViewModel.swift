//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Damitha Raveendra on 2023-09-19.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    // MARK: Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = ""
    
    override init() {
        
    }
    
}
