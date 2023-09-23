//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Damitha Raveendra on 2023-09-13.
//

import SwiftUI

@main
struct UberCloneApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
