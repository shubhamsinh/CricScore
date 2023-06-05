//
//  tableViewController.swift
//  Exam2
//
//  Created by Shubhamsinh Rahevar on 23/02/23.
//

import UIKit
import CoreData

class tableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var matchArr: [Match] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let request: NSFetchRequest<Match> = Match.fetchRequest()
        do{
            matchArr = try context.fetch(request)
        }
        catch{
            print("error")
        }

    }
    
}

extension tableViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedDataTableViewCell", for: indexPath) as! SavedDataTableViewCell
        cell.team1Name.text = matchArr[indexPath.row].team1Name
        cell.team2name.text = matchArr[indexPath.row].team2Name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("delete")
            let retriveData = NSFetchRequest<NSFetchRequestResult>(entityName: "Match")
            do {
                let result = try context.fetch(retriveData)
            
                let commit = result[indexPath.row] as! NSManagedObject
                context.delete(commit)
                matchArr.remove(at: indexPath.row)
                print("Deleted Row Successfully...")
                tableView.reloadData()
                do {
                    //Also we need to perform Save operation after Deletion...
                    try context.save()
                } catch {
                    print("Error.... in Saving Data....")
                }

            } catch {
                print("Error in retriving data")
            }
            
            
            
            
//            do {
//                context.delete(matchArr[indexPath.row])
//                try context.save()
//            } catch {
//                print("Error")
//            }
        }
    }
    
    
}
