//
//  FeedInteractor.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/2/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

protocol FeedInteractorInput {
    
    func loadCategories()
    func loadPoints(with input: Feed.Input)
    func loadDebouncedPoints(with input: Feed.Input)
    func like(for point: Point)
    func removeLike(for point: Point)
}

class FeedInteractor: FeedInteractorInput, FeedWorkerOutput {
    
    private let output: FeedPresenterInput
    private let worker: FeedWorker
    private var loadPointsTask: DelayedTask?

    init(output: FeedPresenterInput) {
        self.output = output
        worker = FeedWorker()
        worker.output = self
    }

    // MARK: - Business logic
    
    func loadCategories() {
        output.beginLoad()
        
        // Ask permissions for push notifications
        subscribePushes()
        
        worker.loadCategories()
    }

    func loadPoints(with input: Feed.Input) {
        output.beginLoad()
        worker.loadPoints(with: input)
    }
    
    func loadDebouncedPoints(with input: Feed.Input) {
        output.beginLoad()
        loadPointsTask?.cancel()
        loadPointsTask = DelayedTask(seconds: 0.75) { self.worker.loadPoints(with: input) }
    }
    
    func like(for point: Point) {
        output.beginLoad()
        worker.like(for: point)
    }
    
    func removeLike(for point: Point) {
        output.beginLoad()
        worker.removeLike(for: point)
    }
    
    fileprivate func subscribePushes() {
        PushNotificationManager().registerForRemoteNotification()
    }
    
    // MARK: - Worker Output
    
    func didLoadCategories() {
        output.didLoadCategories()
    }
    
    func didLoadPoints(_ response: Feed.Output) {
        output.didLoadPoints(response)
    }
    
    func didLoadMorePoints(_ response: Feed.Output) {
        output.didLoadMorePoints(response)
    }
    
    func didLike(for point: Point) {
        output.didLikeFor(point: point)
    }

    func didRemoveLike(for point: Point) {
        output.didRemoveLikeFor(point: point)
    }
    
    func gotError(_ error: Error) {
        output.gotError(error)
    }
}
