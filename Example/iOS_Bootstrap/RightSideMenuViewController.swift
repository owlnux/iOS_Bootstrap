//
//  RightSideMenuViewController.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 11/17/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import iOS_Bootstrap

@available(iOS 10.0, *)
class RightSideMenuViewController :
BaseSideMenuViewController <BasePresenter<BaseViewDelegator>, BaseViewDelegator> {
    
    @IBOutlet private var menuItems: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMenuItemsClickAction(views: menuItems)
    }
    
    override func menuItemDidClicked(view: UIView) {
        switch view {
        case menuItems[0]:
            Log.debug("Menu Button clicked")
            let storyboard = UIStoryboard.getStoryboardWithName(Storyboards.sideMenuTabBar)
            if #available(iOS 11.0, *) {
                let countriesListViewController : CountriesViewController = storyboard.instantiateViewController()
                let nc = GradientNavigationController(rootViewController: countriesListViewController)
                replaceVisableMenuViewControllerWith(menuItemViewController: nc, closeMenu: true)
            }
        case menuItems[1]:
            Log.debug("Menu Label clicked")
        default:
            Log.debug("Menu UIView clicked")
            break
        }
    }
    
}
