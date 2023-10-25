//
//  HomeView.swift
//  UberClone
//
//  Created by Damitha Raveendra on 2023-09-15.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showLocationSearchView = false
    @State private var mapState = MapViewState.noInput
    
    var body: some View {
        ZStack (alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            if mapState == .noInput {
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
            } else  {
                LocationSearchActivationView()
                    .padding(.top, 70)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showLocationSearchView.toggle()
                        }
                    }
            }
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading, 10)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
