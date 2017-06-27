//
//  SignUpWireFrame.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class SignUpWireFrame: NSObject, SignUpWireFrameProtocol {
    
    var rootWireFrame: RootWireFrame? // WireFrame
    var signUpPresenter: SignUpPresenter? //Presenter
    var signUpViewController: SignUpViewController? //View
    
    func presentSignUpViewController() {
        //init
        signUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        
        //connect
        signUpViewController?.signUpPresenter = signUpPresenter
        signUpPresenter?.signUpPresenterProtocol = signUpViewController
        
        //show
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = signUpViewController
        (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
    }
    
    func presentPicturesListViewController() {
        //show list
        self.rootWireFrame?.checkIfAnyUserPersistedOrNot()
    }
    
    func presentSignInViewController() {
        //show sign in
        rootWireFrame?.signIn()
    }
}
