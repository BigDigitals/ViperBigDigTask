//
//  SignUpPresenter.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class SignUpPresenter: NSObject {
    
    var signUpWireFrame: SignUpWireFrame? //WireFrame
    var signUpInteractionInputProtocol: SignUpInteractorInputProtocol? //Interactor
    var signUpPresenterProtocol: SignUpPresenterProtocol? //View
    
    // MARK: - Presentator func
    
    func signUp(email: String, password: String, image: UIImage) {
        signUpInteractionInputProtocol?.signUpRequest(email: email, password: password, image: image)
    }
    
    func signIn() {
        signUpWireFrame?.presentSignInViewController()
    }
}

// MARK: - SignUpInteractorOutputProtocol

extension SignUpPresenter: SignUpInteractorOutputProtocol {
    
    func signUpSuccessRequest() {
        signUpWireFrame?.presentPicturesListViewController()
    }
    
    func signUpFailRequest(error: String) {
        signUpPresenterProtocol?.showErrorMessage(error)
    }
    
}
