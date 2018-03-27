//
//  MapPresenter.swift
//  Mabius
//
//  Created by Timafei Harhun on 07/03/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

protocol MapPresenterInput {
    
    func beganLoadPoints()
    func didLoadPoints(_ response: MapModels.Output)
    
    func beganLike()
    func didLike(for point: Point)
    
    func beganRemoveLike()
    func didRemoveLike(for point: Point)
    
    func gotError(_ error: Error)
}

protocol MapPresenterOutput: class {
    
    func didLoadPoints(_ response: MapModels.Output)
    func didLike(for point: Point)
    func didRemoveLike(for point: Point)
    func showError(_ error: String)
    
    func toggleView(_ isEnabled: Bool)
}

class MapPresenter: MapPresenterInput {
    
    private weak var output: MapPresenterOutput?

    init(output: MapPresenterOutput) {
        self.output = output
    }

    // MARK: - Presentation logic

    func beganLoadPoints() {
    }

    func didLoadPoints(_ response: MapModels.Output) {
        output?.toggleView(true)
        output?.didLoadPoints(response)
    }
    
    func beganLike() {
        output?.toggleView(false)
    }
    
    func didLike(for point: Point) {
        output?.toggleView(true)
        output?.didLike(for: point)
    }
    
    func beganRemoveLike() {
        output?.toggleView(false)
    }
    
    func didRemoveLike(for point: Point){
        output?.toggleView(true)
        output?.didRemoveLike(for: point)
    }
    
    func gotError(_ error: Error) {
        output?.toggleView(true)
        output?.showError(String(describing: error))
    }
}