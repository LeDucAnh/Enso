//
//  Copyright © 2014 Yalantis
//  Licensed under the MIT license: http://opensource.org/licenses/MIT
//  Latest version can be found at http://github.com/yalantis/Side-Menu.iOS
//

import UIKit
import SideMenu

class MenuContentViewController: UIViewController {
    
    
    
    fileprivate var selectedIndex = 0
    fileprivate var transitionPoint: CGPoint!
    fileprivate var contentType: ContentType = .Music
    fileprivate var navigator: UINavigationController!
    
    lazy fileprivate var menuAnimator : MenuTransitionAnimator! = MenuTransitionAnimator(mode: .presentation, shouldPassEventsOutsideMenu: false) { [unowned self] in
        self.dismiss(animated: true, completion: nil)
    }
    func showMenu()
    {
        performSegue(withIdentifier: "presentMenu", sender: nil)

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        AppNavigatorHandler.shared.rootMenuVC = self
        switch (segue.identifier, segue.destination) {
            
            
        case (.some("presentMenu"), let menu as MenuViewController):
            menu.selectedItem = selectedIndex
            menu.delegate = self
            menu.transitioningDelegate = self
            menu.modalPresentationStyle = .custom
        case (.some("embedNavigator"), let navigator as UINavigationController):
            self.navigator = navigator
            self.navigator.delegate = self
        default:
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension MenuContentViewController: MenuViewControllerDelegate {
    
    func menu(_: MenuViewController, didSelectItemAt index: Int, at point: CGPoint) {
        contentType = !contentType
        transitionPoint = point
        selectedIndex = index

        
        //AppNavigatorHandler.shared.rootMenuVC
        
      //  let content = storyboard!.instantiateViewController(withIdentifier: "Content") as! ContentViewController
       // content.type = contentType
       
        var content : UIViewController!
        switch (selectedIndex) {
        case (0):
            
            
            
           if let _ = AppNavigatorHandler.shared.newsVC
           {
            
           }
           else
           {
            AppNavigatorHandler.shared.newsVC =     UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            AppNavigatorHandler.shared.newsVC.VCType = GoogleTopicViewControllerType.googlenews
           }
           
           content = AppNavigatorHandler.shared.newsVC

            break
        case (1):
            
            
            if let _ = AppNavigatorHandler.shared.searchVC
            {
                
            }

            else
            {
                
                AppNavigatorHandler.shared.searchVC =     UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                AppNavigatorHandler.shared.searchVC.VCType = GoogleTopicViewControllerType.googlesearch
            }
            
            
            content = AppNavigatorHandler.shared.searchVC

            
            break
        case (3):
            break
        default:
            print("Buzz")
        }

        
        if content != nil
        {
        navigator.setViewControllers([content], animated: true)
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func menuDidCancel(_: MenuViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension MenuContentViewController: UINavigationControllerDelegate {
    
    func navigationController(_: UINavigationController, animationControllerFor _: UINavigationControllerOperation,
        from _: UIViewController, to _: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if let transitionPoint = transitionPoint {
            return CircularRevealTransitionAnimator(center: transitionPoint)
        }
        return nil
    }
}

extension MenuContentViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting _: UIViewController,
        source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return menuAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MenuTransitionAnimator(mode: .dismissal)
    }
}
