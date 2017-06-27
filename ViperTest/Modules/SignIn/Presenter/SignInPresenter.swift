//
//  SignInPresenter.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class SignInPresenter: NSObject {
    
    var signInWireFrame: SignInWireFrame? //WireFrame
    var signInInteractionInputProtocol: SignInInteractorInputProtocol? //Iteractor
    var signInPresenterProtocol: SignInPresenterProtocol? //View
    
    // MARK: - Presentator func
    
    func signIn(email: String, password: String) {
        signInInteractionInputProtocol?.signInRequest(email: email, password: password)
    }
    
    func sighUp() {
        signInWireFrame?.presentSignUpViewController()
    }
}

// MARK: - SignInInteractorOutputProtocol

extension SignInPresenter: SignInInteractorOutputProtocol {
    
    func signInSuccessRequest() {
        signInWireFrame?.presentPicturesListViewController()
    }
    
    func signInFailRequest(error: String) {
        signInPresenterProtocol?.showErrorMessage(error)
    }

}
