//
//  MapInteractor.swift
//  Mabius
//
//  Created by Timafei Harhun on 07/03/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import MapKit

protocol MapInteractorInput {
    
    func loadPoints(with input: MapModels.Input)
    func like(for point: Point)
    func removeLike(for point: Point)
}

class MapInteractor: MapInteractorInput, MapWorkerOutput {
    
    private let output: MapPresenterInput
    private let worker: MapWorker
    private var loadPointsTask: DelayedTask?

    init(output: MapPresenterInput) {
        self.output = output
        worker = MapWorker()
        worker.output = self
    }

    // MARK: - Business logic
    
    func loadPoints(with input: MapModels.Input) {
        output.beganLoadPoints()
        loadPointsTask?.cancel()
        loadPointsTask = DelayedTask(seconds: 0.75) { self.worker.loadPoints(with: input) }
    }
    
    func like(for point: Point) {
        output.beganLike()
        worker.like(for: point)
    }
    
    func removeLike(for point: Point) {
        output.beganRemoveLike()
        worker.removeLike(for: point)
    }
    
    // MARK: - Worker Output
    
    func didLoadPoints(_ response: MapModels.Output) {
        output.didLoadPoints(response)
    }
    
    func didLike(for point: Point) {
        output.didLike(for: point)
    }
    
    func didRemoveLike(for point: Point) {
        output.didRemoveLike(for: point)
    }
    
    func gotError(_ error: Error) {
        output.gotError(error)
    }
}