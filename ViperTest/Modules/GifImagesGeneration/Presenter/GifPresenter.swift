//
//  GifPresenter.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class GifPresenter: NSObject {
    
    var gifWireFrame: GifWireFrame?
    var gifInteractionInputProtocol: GifInteractorInputProtocol?
    var gifPresenterProtocol: GifPresenterProtocol?
    
    func gif() {
        gifInteractionInputProtocol?.gifRequest()
    }
    
    func backToList() {
        gifWireFrame?.backToPicturesListViewController()
    }
}

// MARK: - GifInteractorOutputProtocol

extension GifPresenter: GifInteractorOutputProtocol {
    
    func gifSuccessRequest(picture:Data) {
        gifPresenterProtocol?.showGif(picture: picture)
    }
    
    func gifFailRequest(error: String) {
        gifPresenterProtocol?.showErrorMessage(error)
    }
}
