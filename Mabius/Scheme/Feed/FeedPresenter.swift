//
//  FeedPresenter.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/2/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

protocol FeedPresenterInput {
    
    func beginLoad()
    
    func didLoadCategories()
    func didLoadMorePoints(_ response: Feed.Output)
    func didLoadPoints(_ response: Feed.Output)
    
    func didLikeFor(point: Point)
    func didRemoveLikeFor(point: Point)
    
    func gotError(_ error: Error)
}

protocol FeedPresenterOutput: class {
    
    func didLoadCategories()
    func didLoadPoints(_ response: Feed.Output)
    func didLoadMorePoints(_ response: Feed.Output)
    func didLike(for point: Point)
    func didRemoveLike(for point: Point)
    func showError(_ error: String)
    func toggleView(_ isEnabled: Bool)
}

class FeedPresenter: FeedPresenterInput {
    
    private weak var output: FeedPresenterOutput?

    init(output: FeedPresenterOutput) {
        self.output = output
    }

    // MARK: - Presentation logic
    
    func beginLoad() {
        beganActivity()
    }
    
    func didLoadCategories() {
        endActivity()
        output?.didLoadCategories()
    }
    
    func didLoadPoints(_ response: Feed.Output) {
        endActivity()
        output?.didLoadPoints(response)
    }
    
    func didLoadMorePoints(_ response: Feed.Output) {
        endActivity()
        output?.didLoadMorePoints(response)
    }

    func didLikeFor(point: Point) {
        endActivity()
        output?.didLike(for: point)
    }
    
    func didRemoveLikeFor(point: Point) {
        endActivity()
        output?.didRemoveLike(for: point)
    }
    
    func gotError(_ error: Error) {
        endActivity()
        output?.showError(String(describing: error))
    }
    
    // MARK: Activity
    
    fileprivate func beganActivity() {
        output?.toggleView(false)
    }
    
    fileprivate func endActivity() {
        output?.toggleView(true)
    }
}