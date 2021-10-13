//
//  GoalCell.swift
//  Motivationapp
//
//  Created by David Taddese on 12/10/2021.
//

import UIKit

//tableview cell

class GoalCell: UITableViewCell {
    

    @IBOutlet weak var goalProgresslbl: UILabel!
    @IBOutlet weak var goalTypelbl: UILabel!
    @IBOutlet weak var goalDescriptionlbl: UILabel!
    
    @IBOutlet weak var completionView: UIView!
    func configurecell(goal : Goal){
        self.goalDescriptionlbl.text = goal.goalDescription
        self.goalTypelbl.text = goal.goalType
        self.goalProgresslbl.text = String(goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        }else{
            self.completionView.isHidden = true
        }
    
    }
}


