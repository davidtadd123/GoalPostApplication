//
//  ViewController.swift
//  Motivationapp
//
//  Created by David Taddese on 11/10/2021.
//

import UIKit
import CoreData

let appdelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addGoalButtonWaspressed(_ sender: UIButton) {
        guard let createGoaLVC = storyboard?.instantiateViewController(identifier: "CreateGoalVC") else { // transition to next page, variable = responsible for transition , idenitifer = page transitioning from, 
            return
        }
        presentDetail(createGoaLVC)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self // tableview is assigned infromation to view otherwise wouldnt know
        tableView.isHidden = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchcoredataobjects()
        ; tableView.reloadData()
    }
    func fetchcoredataobjects(){
        self.fetch { (complete) in if complete{
            if goals.count >= 1{
                tableView.isHidden = false
            } else {
                tableView.isHidden = true
            }
        }
        }
    }
    
    
    
}

// configuration of the tableview data and view

extension GoalsVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    // create a cell using identifier in storyboard
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else{
            return UITableViewCell() } // create cell with all the properties of a cell in another class
        let goal = goals[indexPath.row]
        cell.configurecell(goal: goal)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    //delete action
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteaction = UITableViewRowAction(style: .destructive, title: "DELETE") { Rowaction, indexPath in
            self.removeGoal(atindexpath: indexPath)
            self.fetchcoredataobjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteaction.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return [deleteaction]
    }
}




var goals : [Goal] = []
extension GoalsVC {
    func setProgress( atindexpath indexpath : IndexPath){
        guard let managedconext = appdelegate?.persistentContainer.viewContext else { return }
        let chosengoal = goals[indexpath.row]
        
        if chosengoal.goalProgress < chosengoal.goalCompletionValue{
            chosengoal.goalProgress = chosengoal.goalProgress + 1
        }else{
            return
        }
        do {
            try managedconext.save()
            print("succesfull")
        } catch{
            debugPrint("could not set progress\(error.localizedDescription)")
        }
    }
    func removeGoal(atindexpath indexpath : IndexPath){
        
        guard let managedconext = appdelegate?.persistentContainer.viewContext else { return }
        
        managedconext.delete(goals[indexpath.row])
        
        do {
            try managedconext.save()
            print("succesfully removed goal")
        } catch {
            debugPrint("could not remove \(error.localizedDescription)")
        }
    }
    
    
    func fetch (completion :  (_ complete: Bool) -> ()){
        
        guard let managedcontext = appdelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        
        do {
            goals = try managedcontext.fetch(fetchRequest)
            print("succesful")
            completion(true)
        }   catch {
            debugPrint("could not fetch\(error.localizedDescription)")
            completion(false)
        }
    }
}



