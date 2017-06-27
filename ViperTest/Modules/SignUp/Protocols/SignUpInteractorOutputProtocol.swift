//
//  SignUpInteractorOutputProtocol.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

protocol SignUpInteractorInputProtocol {
    
    func signUpRequest(email: String, password: String, image: UIImage)
    
}

protocol SignUpInteractorOutputProtocol {
    
    func signUpSuccessRequest()
    func signUpFailRequest(error: String)
    
}
