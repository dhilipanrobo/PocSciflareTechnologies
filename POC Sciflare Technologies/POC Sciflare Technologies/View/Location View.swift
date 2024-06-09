//
//  Location View.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 09/06/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                locationManager.checkIfLocationServicesIsEnabled()
            }
    }
}



