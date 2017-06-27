//
//  SignInInteractorProtocol.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import Foundation

protocol SignInInteractorInputProtocol {
    
    func signInRequest(email: String, password: String)
    
}

protocol SignInInteractorOutputProtocol {
    
    func signInSuccessRequest()
    func signInFailRequest(error: String)
    
}
