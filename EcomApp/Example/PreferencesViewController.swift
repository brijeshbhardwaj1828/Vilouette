//
//  ViewController.swift
//  SideMenuExample
//
//  Created by kukushi on 11/02/2018.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit
import SideMenu

extension UIColor {
    static var mirage: UIColor {
        return UIColor(red: 0.08, green: 0.11, blue: 0.19, alpha: 1.00)
    }

    static var lobolly: UIColor {
        return UIColor(red: 0.75, green: 0.78, blue: 0.81, alpha: 1.00)
    }
}

class PreferencesViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{


    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var isDarkModeEnabled = false
    var themeColor = UIColor.white
    let statusBarBehaviors: [SideMenuController.Preferences.StatusBarBehavior] = [.none, .slide, .fade, .hideOnMenu]
    let menuPosition: [SideMenuController.Preferences.MenuPosition] = [.above, .under, .sideBySide]
    let menuDirections: [SideMenuController.Preferences.MenuDirection] = [.left, .right]
    @IBOutlet weak var btnCart: UIButton!
    let menuOrientation: [UIInterfaceOrientationMask] = [.portrait, .allButUpsideDown]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

       // title = "Preferences"
        isDarkModeEnabled = SideMenuController.preferences.basic.position == .under
        configureUI()
        setNeedsStatusBarAppearanceUpdate()
    }

    private func configureUI() {

        if isDarkModeEnabled {
            themeColor = .mirage
        //    statusBarBehaviorSegment.tintColor = .lobolly
        //    menuPositionSegment.tintColor = .lobolly
           // menuDirectionSegment.tintColor = .lobolly
            //orientationSegment.tintColor = .lobolly
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .lobolly
            navigationController?.navigationBar.barTintColor = .mirage
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        } else {
            themeColor = .white
        }

        view.backgroundColor = themeColor
        containerView.backgroundColor = themeColor

        let preferences = SideMenuController.preferences.basic
        guard let behaviorIndex = statusBarBehaviors.firstIndex(of: preferences.statusBarBehavior) else {
            fatalError("Configuration is messed up")
        }

        guard let menuPositionIndex = menuPosition.firstIndex(of: preferences.position) else {
            fatalError("Configuration is messed up")
        }

        guard let menuDirectionIndex = menuDirections.firstIndex(of: preferences.direction) else {
            fatalError("Configuration is messed up")
        }

        guard let menuOrientationIndex = menuOrientation.firstIndex(of: preferences.supportedOrientations)else {
            fatalError("Configuration is messed up")
        }
    }

    @IBAction func menuButtonDidClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }

 

    func presentAlert() {
        let alert = UIAlertController(title: "Reload Side Menu",
                                      message: "Side Menu need to be reloaded after modifying key properties.",
                                      preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "Yeah", style: .default) { (_) in
            let sideMenuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenu")
            UIApplication.shared.keyWindow?.rootViewController = sideMenuController
        }
        alert.addAction(confirmButton)
        present(alert, animated: true, completion: nil)
    }


    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        print("[SideMenu] View Will Transition")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDarkModeEnabled ? .lightContent : .default
    }
    
    
    
    
    //MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1     //return number of sections in collection view
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10    //return number of rows in section
    }

//    private func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath as IndexPath)
//        configureCell(cell: cell, forItemAtIndexPath: indexPath)
//        return cell      //return your cell
//    }
//
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath as IndexPath)
        configureCell(cell: cell, forItemAtIndexPath: indexPath as NSIndexPath)
                return cell      //return your cell
    }

    func configureCell(cell: UICollectionViewCell, forItemAtIndexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clear


        //Customise your cell

    }

    
    
    
    
    

}
