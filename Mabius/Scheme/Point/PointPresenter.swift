//
//  PointPresenter.swift
//  Mabius
//
//  Created by Timafei Harhun on 10/03/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

protocol PointPresenterInput {
    
    func beginLoad()

    func didLoadPoint(_ response: PointDetails.Output.UserPoint)
    
    func didLoadComments(_ response: PointDetails.Output.Comments)
    func didLoadMoreComments(_ response: PointDetails.Output.Comments)
    func didAddComment()
    
    func didLike(for point: Point)
    func didRemoveLike(for  point: Point)
    
    func gotError(_ error: Error)
}

protocol PointPresenterOutput: class {
    
    func didLoadPoint(_ response: PointDetails.Output.UserPoint)
    
    func didLoadComments(_ response: PointDetails.Output.Comments)
    func didLoadMoreComments(_ response: PointDetails.Output.Comments)
    func didAddComment()
    
    func didLike(for point: Point)
    func didRemoveLike(for  point: Point)
    
    func showError(_ error: String)
    
    func toggleView(_ isEnabled: Bool)
}

class PointPresenter: PointPresenterInput {
    
    private weak var output: PointPresenterOutput?

    init(output: PointPresenterOutput) {
        self.output = output
    }

    // MARK: - Presentation logic
    
    func beginLoad() {
        beginActivity()
    }
    
    func didLoadPoint(_ response: PointDetails.Output.UserPoint) {
        endActivity()
        output?.didLoadPoint(response)
    }
    
    func didLoadComments(_ response: PointDetails.Output.Comments) {
        endActivity()
        output?.didLoadComments(response)
    }
    
    func didLoadMoreComments(_ response: PointDetails.Output.Comments) {
        endActivity()
        output?.didLoadMoreComments(response)
    }
    
    func didAddComment() {
        endActivity()
        output?.didAddComment()
    }
    
    func didLike(for point: Point) {
        endActivity()
        output?.didLike(for: point)
    }
    
    func didRemoveLike(for  point: Point) {
        endActivity()
        output?.didRemoveLike(for: point)
    }
    
    func gotError(_ error: Error) {
        endActivity()
        output?.showError(String(describing: error))
    }
    
    // MARK: - Activity
    
    fileprivate func beginActivity() {
        output?.toggleView(false)
    }
    
    fileprivate func endActivity() {
        output?.toggleView(true)
    }
}
