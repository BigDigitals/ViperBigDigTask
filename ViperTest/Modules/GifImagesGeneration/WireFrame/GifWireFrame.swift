//
//  GifWireFrame.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class GifWireFrame: NSObject, NewPictureWireFrameProtocol {
    
    var rootWireFrame: RootWireFrame?
    var gifPresenter: GifPresenter?
    var gifViewController: GifViewController?
    
    func presentGif(navController:UINavigationController) {
        gifViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GifViewController") as? GifViewController
        
        gifViewController?.gifPresenter = gifPresenter
        gifPresenter?.gifPresenterProtocol = gifViewController
        
        navController.addChildViewController(gifViewController!)
        navController.view.addSubview((gifViewController?.view)!)
        gifViewController?.didMove(toParentViewController: navController)
    }
    
    func backToPicturesListViewController() {
        gifViewController?.willMove(toParentViewController: nil)
        gifViewController?.view.removeFromSuperview()
        gifViewController?.removeFromParentViewController()
    }
}
