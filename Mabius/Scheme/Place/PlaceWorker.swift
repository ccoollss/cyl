//
//  PlaceWorker.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/27/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import MapKit

protocol PlaceWorkerInput {
    func loadLocation(with input: Place.Input, on mapView: MKMapView)
}

protocol PlaceWorkerOutput: class {
    func didLoadLocation(_ response: Place.Output)
    func gotError(_ error: Error)
}

class PlaceWorker: PlaceWorkerInput {
    
    weak var output: PlaceWorkerOutput?

    // MARK: - Business Logic

    func loadLocation(with input: Place.Input, on mapView: MKMapView) {
        
        DispatchQueue.global(qos: .background).async(execute: {
            let request = MKLocalSearchRequest()
            let address = "\(input.selectedCountry!), \(input.selectedCity!), \(input.address!)"
            request.naturalLanguageQuery = address
            request.region = mapView.region
            let search = MKLocalSearch(request: request)
            search.start { response, _ in
                if response != nil {
                    
                    let location = Location()
                    location.lat = response?.boundingRegion.center.latitude
                    location.lon = response?.boundingRegion.center.longitude

                    DispatchQueue.main.async(execute: {
                        guard let boundingRegion = response?.boundingRegion else {
                            self.output?.gotError(NetworkError.badResponse)
                            return
                        }
                        mapView.setRegion(boundingRegion, animated: true)
                        mapView.removeAnnotations(mapView.annotations)
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = boundingRegion.center
                        mapView.showAnnotations([annotation], animated: true)
                        self.output?.didLoadLocation(Place.Output(location: location, address: address))
                        
                    })
                } else {
                    self.output?.gotError(NetworkError.badResponse)
                }
            }
        })
    }
}