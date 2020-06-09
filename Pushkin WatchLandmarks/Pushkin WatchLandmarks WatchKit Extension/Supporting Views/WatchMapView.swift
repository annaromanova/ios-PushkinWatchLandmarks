//
//  WatchMapView.swift
//  Pushkin WatchLandmarks Extension
//
//  Created by RAS on 04.06.2020.
//  Copyright © 2020 Anna Romanova. All rights reserved.
//

import Foundation
import SwiftUI

struct WatchMapView: WKInterfaceObjectRepresentable {
    
     var item: ItemCD
    
    func makeWKInterfaceObject(context: WKInterfaceObjectRepresentableContext<WatchMapView>) -> WKInterfaceMap {
        return WKInterfaceMap()
    }
    
    func updateWKInterfaceObject(_ map: WKInterfaceMap, context: WKInterfaceObjectRepresentableContext<WatchMapView>) {
        
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(item.latitude), longitude: CLLocationDegrees(item.longitude))
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02,
            longitudeDelta: 0.02)
        
        let region = MKCoordinateRegion(
            center: coordinate,
            span: span)
        
        map.setRegion(region)
        map.addAnnotation(coordinate, withImageNamed: item.name, centerOffset: CGPoint(x: 0, y: 0))
    }
}




