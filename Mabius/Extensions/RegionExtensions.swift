//
//  RegionExtensions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 27.06.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import MapKit

extension Region
{
    class func fromCoordinateRegion(_ region: MKCoordinateRegion) -> Region
    {
        let result = Region()
        result.centerLat = region.center.latitude
        result.centerLon = region.center.longitude
        result.deltaLat = region.span.latitudeDelta
        result.deltaLon = region.span.longitudeDelta
        return result
    }
}
