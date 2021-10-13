//
//  FinishGoalVC.swift
//  Motivationapp
//
//  Created by David Taddese on 12/10/2021.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalButtn.bindToKeyBoard()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismissdetail() // call animation to override current view controller
    }
    
    @IBOutlet weak var createGoalButtn: UIButton!
    @IBOutlet weak var PointsTextField: UITextField!
    
    // everything saved when button pressed
    @IBAction func CreateGoalButtonPressed(_ sender: UIButton) {
        if PointsTextField.text != "" {
            self.save {(complete) in if complete {
                dismiss(animated: true, completion: nil)
            }
            }}}
    var goalDescriptioin : String!
    var goalType : GoalType!
    
    func initdata(description : String , type : GoalType){
        self.goalDescriptioin = description
        self.goalType = type
    }
    
    
    
    ////////////////
    //save to core data
    
    func save(completion : (_ finished : Bool ) ->()){
        guard let managedContext = appdelegate?.persistentContainer.viewContext else { return }
        
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescriptioin
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(PointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        
        
        do {
            try  managedContext.save()
            print("successfully saved data")
            completion(true)
        }catch {
            debugPrint("Could not save : \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
}

