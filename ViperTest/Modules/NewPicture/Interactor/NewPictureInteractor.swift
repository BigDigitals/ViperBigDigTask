//
//  NewPictureInteractor.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation
import Photos

class NewPictureInteractor: NSObject {
    
    var newPictureInteractorOutputProtocol: NewPictureInteractorOutputProtocol?
    
}

// MARK: - NewPictureInteractorInputProtocol

extension NewPictureInteractor: NewPictureInteractorInputProtocol {
    
    func newPictureRequest(image: UIImage, description: String, hashtag: String, imageInfo:[String:Any]) {
        
        if image != nil{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do {
                let users = try context.fetch(User.fetchRequest())
                if users.count > 0 {
                    let user = users[0] as! User
                    
                    let url = Urls.urlServer + Urls.urlAddPicture
                    
                    var parameters = ["description": description,
                                      "hashtag": hashtag]
                    
                    parameters.updateValue("\((UIApplication.shared.delegate as! AppDelegate).latitude ?? 0)", forKey: "latitude")
                    parameters.updateValue("\((UIApplication.shared.delegate as! AppDelegate).longitude ?? 0)", forKey: "longitude")
                    
                    if let imageURL = imageInfo[UIImagePickerControllerReferenceURL] {
                        let asset = PHAsset.fetchAssets(withALAssetURLs: [imageURL as! URL], options: nil).firstObject!
                        let location = asset.location
                        
                        parameters.updateValue("\(location?.coordinate.latitude ?? 0)", forKey: "latitude")
                        parameters.updateValue("\(location?.coordinate.longitude ?? 0)", forKey: "longitude")
                    }
                    
                    Alamofire.upload(multipartFormData:{(multipartFormData) in
                        
                        multipartFormData.append(UIImageJPEGRepresentation(image, 0.5)!, withName: "image", fileName: "image", mimeType: "jpeg")
                        for (key, value) in parameters {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }, usingThreshold:UInt64.init(),
                       to:url,
                       method:.post,
                       headers:["token": user.token!],
                       encodingCompletion: { encodingResult in
                        switch encodingResult {
                        case .success(let upload, _, _):
                            upload.responseJSON { response in
                                
                                let json = JSON.init(response.result.value ?? "")
                                
                                if let error = json["error"].string {
                                    self.newPictureInteractorOutputProtocol?.newPictureFailRequest(error: error)
                                } else {
                                    self.newPictureInteractorOutputProtocol?.newPictureSuccessRequest()
                                }
                                
                            }
                            
                        case .failure(let encodingError):
                            self.newPictureInteractorOutputProtocol?.newPictureFailRequest(error: encodingError.localizedDescription)
                        }
                    })
                } else {
                    self.newPictureInteractorOutputProtocol?.newPictureFailRequest(error: "No user")
                }
                
            } catch {
                print("Fetching Failed")
            }
        }else{
            self.newPictureInteractorOutputProtocol?.newPictureFailRequest(error: "Choose image")
        }
    }
    
}
