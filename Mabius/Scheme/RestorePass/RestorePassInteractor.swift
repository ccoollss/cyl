//
//  RestorePassInteractor.swift
//  Mabius
//
//  Created by Work on 2/20/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

protocol RestorePassInteractorInput {
    
    func checkInput(_ input: RestorePassModels.Input)
    func restore(with input:RestorePassModels.Input)
}

class RestorePassInteractor: RestorePassInteractorInput, RestorePassWorkerOutput {
    
    private let output: RestorePassPresenterInput
    private let worker: RestorePassWorker

    init(output: RestorePassPresenterInput) {
        
        self.output = output
        worker = RestorePassWorker()
        worker.output = self
    }

    // MARK: - Business logic

    func checkInput(_ input: RestorePassModels.Input) {
        output.handleInput(input.isValid)
    }

    func restore(with input: RestorePassModels.Input) {
        output.beginRestore()
        worker.restore(with: input)
    }
    
    // MARK: - Worker Output
    
    func didRestore() {
        output.didRestore()
    }
    
    func gotError(_ error: Error) {
        output.gotError(error)
    }
}
