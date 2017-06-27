//
//  NewPictureWireFrame.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class NewPictureWireFrame: NSObject, NewPictureWireFrameProtocol {
    
    var rootWireFrame: RootWireFrame?
    var newPicturePresenter: NewPicturePresenter?
    var newPictureViewController: NewPictureViewController?
    
    func presentNewPictureViewController(navController:UINavigationController) {
        newPictureViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPictureViewController") as? NewPictureViewController
        
        newPictureViewController?.newPicturePresenter = newPicturePresenter
        newPicturePresenter?.newPicturePresenterProtocol = newPictureViewController
        
        navController.pushViewController(newPictureViewController!, animated: true)
    }
    
    func backToPicturesListViewController() {
        newPictureViewController?.navigationController?.popViewController(animated: true)
    }
}
