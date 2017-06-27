//
//  SignInInteractor.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SignInInteractor: NSObject {
    
    var signInInteractorOutputProtocol: SignInInteractorOutputProtocol? //Presentator
    
}

// MARK: - SignInInteractorInputProtocol

extension SignInInteractor: SignInInteractorInputProtocol {
    
    func signInRequest(email: String, password: String) {
        if email != "" && password != "" {
            let url = Urls.urlServer + Urls.urlSignIn
            
            let parameters = ["email": email,
                              "password": password]
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if let error = response.result.error {
                    self.signInInteractorOutputProtocol?.signInFailRequest(error: error.localizedDescription)
                } else {
                    if let data = response.data {
                        let json = JSON(data: data)
                        print(json)
                        
                        if let error = json["error"].string {
                            self.signInInteractorOutputProtocol?.signInFailRequest(error: error)
                        } else {
                            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                            
                            let user = User(context: context)
                            user.token = json["token"].stringValue
                            user.avatarUrl = json["avatar"].stringValue
                            
                            (UIApplication.shared.delegate as! AppDelegate).saveContext()
                            
                            self.signInInteractorOutputProtocol?.signInSuccessRequest()
                        }
                    }
                }
            }
        } else {
            self.signInInteractorOutputProtocol?.signInFailRequest(error: "Please, input email and password!")
        }
    }
    
}
