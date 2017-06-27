//
//  RootWireFrame.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import CoreData

class RootWireFrame: NSObject {
    
    let signInWireFrame = SignInWireFrame()
    let signUpWireFrame = SignUpWireFrame()
    let picturesListWireFrame = PicturesListWireFrame()
    let newPictureWireFrame = NewPictureWireFrame()
    let gifWireFrame = GifWireFrame()
    
    override init() {
        super.init()
        
        let signInPresenter = SignInPresenter()
        let signInInteractor = SignInInteractor()
        
        signInPresenter.signInWireFrame = signInWireFrame
        signInPresenter.signInInteractionInputProtocol = signInInteractor
        signInInteractor.signInInteractorOutputProtocol = signInPresenter
        signInWireFrame.signInPresenter = signInPresenter
        signInWireFrame.rootWireFrame = self
        
        let picturesListPresenter = PicturesListPresenter()
        let picturesListInteractor = PicturesListInteractor()
        
        picturesListPresenter.picturesListWireFrame = picturesListWireFrame
        picturesListPresenter.picturesListInteractionInputProtocol = picturesListInteractor
        picturesListInteractor.picturesListInteractorOutputProtocol = picturesListPresenter
        picturesListWireFrame.picturesListPresenter = picturesListPresenter
        picturesListWireFrame.rootWireFrame = self
        
        let signUpPresenter = SignUpPresenter()
        let signUpInteractor = SignUpInteractor()
        
        signUpPresenter.signUpWireFrame = signUpWireFrame
        signUpPresenter.signUpInteractionInputProtocol = signUpInteractor
        signUpInteractor.signUpInteractorOutputProtocol = signUpPresenter
        signUpWireFrame.signUpPresenter = signUpPresenter
        signUpWireFrame.rootWireFrame = self
        
        let newPicturePresenter = NewPicturePresenter()
        let newPictureInteractor = NewPictureInteractor()
        
        newPicturePresenter.newPictureWireFrame = newPictureWireFrame
        newPicturePresenter.newPictureInteractionInputProtocol = newPictureInteractor
        newPictureInteractor.newPictureInteractorOutputProtocol = newPicturePresenter
        newPictureWireFrame.newPicturePresenter = newPicturePresenter
        newPictureWireFrame.rootWireFrame = self
        
        let gifPresenter = GifPresenter()
        let gifInteractor = GifInteractor()
        
        gifPresenter.gifWireFrame = gifWireFrame
        gifPresenter.gifInteractionInputProtocol = gifInteractor
        gifInteractor.gifInteractorOutputProtocol = gifPresenter
        gifWireFrame.gifPresenter = gifPresenter
        gifWireFrame.rootWireFrame = self
    }
    
    func application() -> Bool {
//        self.deleteUserRecords()
        checkIfAnyUserPersistedOrNot()
        return true
    }
    
    func signIn() {
        signInWireFrame.presentSignInViewController()
    }
    
    func signUp() {
        signUpWireFrame.presentSignUpViewController()
    }
    
    func picturesList() {
        picturesListWireFrame.presentPicturesListViewController()
    }
    
    func newPicture() {
        newPictureWireFrame.presentNewPictureViewController(navController: picturesListWireFrame.navigationController!)
    }
    
    func gif() {
        gifWireFrame.presentGif(navController: picturesListWireFrame.navigationController!)
    }
    
    func checkIfAnyUserPersistedOrNot() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let usersCount = try context.count(for: User.fetchRequest())
            if usersCount > 0 {
                // PicturesList Screen
                self.picturesList()
            } else {
                // SignIn Screen
                self.signIn()
            }
            
        } catch {
            print("Fetching Failed")
            signInWireFrame.presentSignInViewController()
        }
    }
    
    func deleteUserRecords() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let items = try context.fetch(User.fetchRequest())
            
            for item in items {
                context.delete(item as! NSManagedObject)
            }
            
            // Save Changes
            try context.save()
            
        } catch {
            // Error Handling
            // ...
        }
    }
    
}
