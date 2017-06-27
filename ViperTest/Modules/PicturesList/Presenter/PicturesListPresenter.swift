//
//  PicturesListPresenter.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class PicturesListPresenter: NSObject {
    
    var picturesListWireFrame: PicturesListWireFrame?
    var picturesListInteractionInputProtocol: PicturesListInteractorInputProtocol?
    var picturesListPresenterProtocol: PicturesListPresenterProtocol?
    var picturesList:[Picture] = []
    
    override init() {
        super.init()
    }
    
    func getPicturesList() {
        picturesListInteractionInputProtocol?.getPicturesListRequest()
    }
    
    func numberOfImages() -> Int {
        return picturesList.count
    }
    
    func picture(index:Int) -> Picture {
        return picturesList[index]
    }
    
    func addNewImage() {
        picturesListWireFrame?.presentAddPictureViewController()
    }
    
    func playGIFImage() {
        picturesListWireFrame?.presentGifPictureViewController()
    }
}

// MARK: - PicturesListInteractorOutputProtocol

extension PicturesListPresenter: PicturesListInteractorOutputProtocol {
    func getPicturesListSuccessRequest(pictures: [Picture]) {
        picturesList = pictures
        picturesListPresenterProtocol?.reloadData()
    }
    
    func getPicturesListFailRequest(error: String) {
        picturesListPresenterProtocol?.showErrorMessage(error)
    }
    
}
