//
//  Step2Interactor.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/24/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol Step2InteractorInput {
    func checkInput(_ input: Step2.Input)
    func uploadImage(_ image: UIImage)
}

class Step2Interactor: Step2InteractorInput, Step2WorkerOutput {
    
    private let output: Step2PresenterInput
    private let worker: Step2Worker
    
    init(output: Step2PresenterInput) {
        self.output = output
        worker = Step2Worker()
        worker.output = self
    }

    // MARK: - Business logic

    func checkInput(_ input: Step2.Input) {
        output.handleInput(input.isValid)
    }
    
    func uploadImage(_ image: UIImage) {
        output.beginLoad()
        worker.uploadImage(image)
    }
    
    // MARK: - Worker Output
    
    func didUploadImage(_ response: Step2.Output) {
        output.didUploadImage(response)
    }
    
    func gotError(_ error: Error) {
        output.gotError(error)
    }
}