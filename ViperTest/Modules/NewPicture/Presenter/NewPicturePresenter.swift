//
//  File.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class NewPicturePresenter: NSObject {
    
    var newPictureWireFrame: NewPictureWireFrame?
    var newPictureInteractionInputProtocol: NewPictureInteractorInputProtocol?
    var newPicturePresenterProtocol: NewPicturePresenterProtocol?
    
    func newPicture(image: UIImage, description: String, hashtag: String, imageInfo:[String:Any]) {
        newPictureInteractionInputProtocol?.newPictureRequest(image: image, description: description, hashtag: hashtag, imageInfo:imageInfo)
    }
}

// MARK: - NewPictureInteractorOutputProtocol

extension NewPicturePresenter: NewPictureInteractorOutputProtocol {
    
    func newPictureSuccessRequest() {
        newPictureWireFrame?.backToPicturesListViewController()
    }
    
    func newPictureFailRequest(error: String) {
        newPicturePresenterProtocol?.showErrorMessage(error)
    }
    
}
