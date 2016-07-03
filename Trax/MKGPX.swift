//
//  MKGPX.swift
//  Trax
//
//  Created by Tom Yu on 7/3/16.
//  Copyright © 2016 kangleyu. All rights reserved.
//

import MapKit

class EditableWaypoint: GPX.Waypoint {
    
    override var coordinate: CLLocationCoordinate2D {
        get {
            return super.coordinate
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
}

extension GPX.Waypoint : MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        return self.name
    }
    
    var subtitle: String? {
        return self.info
    }
    
    var thumbnailURL: NSURL? {
        return getImageURLofType("thumbnail")
    }
    
    var imageURL: NSURL? {
        return getImageURLofType("large")
    }
    
    private func getImageURLofType(type: String?) -> NSURL? {
        for link in links {
            if link.type == type {
                return link.url
            }
        }
        return nil
    }
}
