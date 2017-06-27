//
//  SignInWireFrame.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class SignInWireFrame: NSObject, SignInWireFrameProtocol {
    
    var rootWireFrame: RootWireFrame? //WireFrame
    var signInPresenter: SignInPresenter? //Presenter
    var signInViewController: SignInViewController? //View

    func presentSignInViewController() {
        //Init view
        signInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
        
        //connect presenter and view
        signInViewController?.signInPresenter = signInPresenter
        signInPresenter?.signInPresenterProtocol = signInViewController
        
        //show view
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = signInViewController
        (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
    }
    
    func presentPicturesListViewController() {
        //Open images list
        rootWireFrame?.checkIfAnyUserPersistedOrNot()
    }
    
    func presentSignUpViewController() {
        //Open sign up
        rootWireFrame?.signUp()
    }
    
}
