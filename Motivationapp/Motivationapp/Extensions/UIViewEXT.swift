//
//  UIViewEXT.swift
//  Motivationapp
//
//  Created by David Taddese on 12/10/2021.
//

import UIKit

//
extension UIView {
    
    func bindToKeyBoard(){
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object : nil)
    }
    @objc func keyboardWillChange(_ notification : NSNotification){
        let curve = notification.userInfo! [UIView.keyboardAnimationCurveUserInfoKey] as! UInt
        let startingframe = (notification.userInfo![UIView.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (notification.userInfo! [UIView.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endingFrame.origin.y - startingframe.origin.y
        
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, options: KeyframeAnimationOptions(rawValue: curve), animations: {self.frame.origin.y += deltaY}, completion: nil)
        
    }
    
}
