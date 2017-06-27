//
//  GifIteractor.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GifInteractor: NSObject {
    
    var gifInteractorOutputProtocol: GifInteractorOutputProtocol?
    
}

// MARK: - GifInteractorInputProtocol

extension GifInteractor: GifInteractorInputProtocol {
    
    func gifRequest() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let users = try context.fetch(User.fetchRequest())
            if users.count > 0 {
                let user = users[0] as! User
                
                let url = Urls.urlServer + Urls.urlGif
                
                let parameters = ["token": user.token ?? ""]
                print(parameters)
                
                Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: parameters).responseJSON { (response) in
                    if let error = response.result.error {
                        self.gifInteractorOutputProtocol?.gifFailRequest(error: error.localizedDescription)
                    } else {
                        if let data = response.data {
                            let json = JSON(data: data).dictionary
                            
                            if let error = json?["error"] {
                                self.gifInteractorOutputProtocol?.gifFailRequest(error: error.string!)
                            } else {
                                
                                let urlStr = json?["gif"]?.string ?? ""
                                
                                Alamofire.request(urlStr).responseData { response in
                                    guard let data = response.result.value else {
                                        self.gifInteractorOutputProtocol?.gifFailRequest(error: "Error")
                                        return
                                    }
                                    self.gifInteractorOutputProtocol?.gifSuccessRequest(picture: data)
                                }
                                
                            }
                        }else{
                            self.gifInteractorOutputProtocol?.gifFailRequest(error: "Error")
                        }
                    }
                }
            } else {
                self.gifInteractorOutputProtocol?.gifFailRequest(error: "Error")
            }
            
        } catch {
            print("Fetching Failed")
        }
    }
    
}
