//
//  PicturesListWireFrame.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class PicturesListWireFrame: NSObject, PicturesListWireFrameProtocol {
    
    var rootWireFrame: RootWireFrame?
    var navigationController: UINavigationController?
    var picturesListPresenter: PicturesListPresenter?
    var picturesListCollectionViewController: PicturesListCollectionViewController?
    
    func presentPicturesListViewController() {
        picturesListCollectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PicturesListCollectionViewController") as? PicturesListCollectionViewController
        navigationController = UINavigationController(rootViewController: picturesListCollectionViewController!)
        
        picturesListCollectionViewController?.picturesListPresenter = picturesListPresenter
        picturesListPresenter?.picturesListPresenterProtocol = picturesListCollectionViewController
        
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = navigationController
        (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
    }
    
    func presentAddPictureViewController() {
        rootWireFrame?.newPicture()
    }
    
    func presentGifPictureViewController() {
        rootWireFrame?.gif()
    }
}
