//
//  PicturesListInteractor.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class PicturesListInteractor: NSObject {
    
    var picturesListInteractorOutputProtocol: PicturesListInteractorOutputProtocol?
    
}

// MARK: - PicturesListInteractorInputProtocol

extension PicturesListInteractor: PicturesListInteractorInputProtocol {
    
    func getPicturesListRequest() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let users = try context.fetch(User.fetchRequest())
            if users.count > 0 {
                let user = users[0] as! User
                
                let url = Urls.urlServer + Urls.urlPictureList
                    
                let parameters = ["token": user.token ?? ""]
                print(parameters)
                
                Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: parameters).responseJSON { (response) in
                    if let error = response.result.error {
                        self.picturesListInteractorOutputProtocol?.getPicturesListFailRequest(error: error.localizedDescription)
                    } else {
                        if let data = response.data {
                            let json = JSON(data: data).dictionary
                            print(json)
                            
                            var picturesArray = [Picture]()
                            
                            if let error = json?["error"] {
                                self.picturesListInteractorOutputProtocol?.getPicturesListFailRequest(error: error.string!)
                            } else {
                                for image in (json?["images"]?.arrayObject)! {
                                    let picture = Picture.init(json: image as! [String : Any])
                                    picturesArray.append(picture)
                                }
                                self.picturesListInteractorOutputProtocol?.getPicturesListSuccessRequest(pictures:picturesArray)
                            }
                        }
                    }
                }
            } else {
                
            }
            
        } catch {
            print("Fetching Failed")
        }
    }
    
}
