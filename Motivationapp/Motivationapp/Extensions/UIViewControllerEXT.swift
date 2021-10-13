//
//

import UIKit

//override default animation when viewcontroller is presented

extension UIViewController{
    
    func presentDetail(_ viewcontrollertoPresent : UIViewController){
        let transition = CATransition() //
        transition.duration = 0.3
        transition.type = CATransitionType.push  // pushes exisiting view controller and present this view controller which is (present view controller)
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition) //key is a identifier which represents a transition animation
        present(viewcontrollertoPresent, animated: false, completion: nil)
        
    }
    func dismissdetail(){
        let transistion = CATransition()
        transistion.duration = 0.3
        transistion.type = CATransitionType.push
        transistion.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transistion, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
        
    }
    
    // dismiss to first screen
    
    func presentSecondDetail(_ viewcontrollertopresent: UIViewController){
        let transition = CATransition() //
        transition.duration = 0.3
        transition.type = CATransitionType.push  // pushes exisiting view controller and present this view controller which is (present view controller)
        transition.subtype = CATransitionSubtype.fromRight
        
        guard let apresentedviewController = presentedViewController else { return }
        
        apresentedviewController.dismiss(animated: false){
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewcontrollertopresent, animated: false, completion: nil)
        }
    }
}
