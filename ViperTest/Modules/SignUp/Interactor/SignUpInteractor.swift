//
//  SignUpInteractor.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class SignUpInteractor: NSObject {
    
    var signUpInteractorOutputProtocol: SignUpInteractorOutputProtocol? //Presenter
    
}

// MARK: - SignUpInteractorInputProtocol

extension SignUpInteractor: SignUpInteractorInputProtocol {
    
    func signUpRequest(email: String, password: String, image: UIImage) {
        if email != "" && password != "" && image != nil{
            let url = Urls.urlServer + Urls.urlSignUp
            
            let parameters = ["email": email,
                              "password": password]
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                multipartFormData.append(UIImageJPEGRepresentation(image, 0.5)!, withName: "avatar", fileName: "image", mimeType: "jpeg")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to: URL.init(string: url)!, encodingCompletion:{ (result) in
                
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        let json = JSON.init(response.result.value ?? "")
                        
                        if let error = json["error"].string {
                            self.signUpInteractorOutputProtocol?.signUpFailRequest(error: error)
                        } else {
                            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                            
                            let user = User(context: context)
                            user.token = json["token"].stringValue
                            user.avatarUrl = json["avatar"].stringValue
                            
                            (UIApplication.shared.delegate as! AppDelegate).saveContext()
                            
                            self.signUpInteractorOutputProtocol?.signUpSuccessRequest()
                        }
                        
                    }
                    
                    
                case .failure(let encodingError):
                    self.signUpInteractorOutputProtocol?.signUpFailRequest(error: encodingError.localizedDescription)
                }
                
            })
        } else {
            self.signUpInteractorOutputProtocol?.signUpFailRequest(error: "Please, input email, password and image!")
        }
    }
    
}
