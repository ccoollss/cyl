//
//  PlaceInteractor.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/27/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import MapKit

protocol PlaceInteractorInput {
    func checkInput(_ input: Place.Input) -> Bool
    func loadLocation(with input: Place.Input, on mapView: MKMapView)
}

class PlaceInteractor: PlaceInteractorInput, PlaceWorkerOutput {
    
    private let output: PlacePresenterInput
    private let worker: PlaceWorker

    init(output: PlacePresenterInput) {
        self.output = output
        worker = PlaceWorker()
        worker.output = self
    }

    // MARK: - Business logic
    
    func checkInput(_ input: Place.Input) -> Bool {
        return input.isValid
    }

    func loadLocation(with input: Place.Input, on mapView: MKMapView) {
        if checkInput(input) {
            output.beginLoad()
            worker.loadLocation(with: input, on: mapView)
        } 
    }

    // MARK: - Worker Output
    
    func didLoadLocation(_ response: Place.Output) {
        output.didLoadLocation(response)
    }
    
    func gotError(_ error: Error) {
        output.gotError(error)
    }
}
