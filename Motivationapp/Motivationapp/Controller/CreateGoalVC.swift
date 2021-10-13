//
//  CreateGoalVC.swift
//  Motivationapp
//
//  Created by David Taddese on 12/10/2021.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var createGoalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    
    var goaltype : GoalType = .shortTerm
    
    @IBAction func backButtonWasPressed(_ sender: UIButton) {
        
        dismissdetail()
        
    }
    @IBAction func shortTermButtonWasPressed(_ sender: UIButton) {
        goaltype = .shortTerm
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    
    @IBAction func nextButtonWasPressed(_ sender: UIButton) {
        if createGoalTextView.text != "" && createGoalTextView.text != " What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(identifier: "finishGoalVC") as? FinishGoalVC else {
                return}
            finishGoalVC.initdata(description: createGoalTextView.text! , type: goaltype)
            presentingViewController?.presentSecondDetail(finishGoalVC) // present to first screen
        }
        
    }
    
    @IBAction func longTermButtonPressed(_ sender: UIButton) {
        goaltype = .longterm
        shortTermButton.setDeselectedColor()
        longTermButton.setSelectedColor()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.bindToKeyBoard()
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        createGoalTextView.delegate = self
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        createGoalTextView.text = ""
        createGoalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
}
