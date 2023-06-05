//
//  HomeViewController.swift
//  Exam2
//
//  Created by Shubhamsinh Rahevar on 22/02/23.
//

import UIKit
import FirebaseAuth
import CoreData

class HomeViewController: UIViewController {

    
    var recentArr = [Score]()
    var liveArr = [Score]()
    var upcomingArr = [Score]()
    var ResultArr = [Score]()
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var tableView: UITableView!
    var scoreData: ScoreModel?
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        UserDefaults.standard.removeObject(forKey: "email")
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        navigationItem.hidesBackButton = true
        
//        liveArr.sorted(by: liveArr)
    }
    
    
    func loadJson() {
        if let path = Bundle.main.path(forResource: "CricketScore", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                print(jsonData)
                let jsonDecoder = JSONDecoder()
                
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                scoreData = try jsonDecoder.decode(ScoreModel?.self, from: jsonData)
                
                
                let singleData = scoreData?.data ?? []
                for i in 0..<singleData.count{
                    if singleData[i].ms == "live"{
                        liveArr.append(singleData[i])
                        recentArr.append((singleData[i]))
                    }
                    else if singleData[i].ms == "fixture"{
                        upcomingArr.append(singleData[i])
                    }
                    else if singleData[i].ms == "result"{
                        recentArr.append(singleData[i])
                    }
                    else{
                        recentArr.append(singleData[i])
                    }
                }
                
              } catch {
                  print(error)
                   // handle error
              }
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 6
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            return 1
        }
        else{
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Recent matches"
        }
        else if section == 1{
            return "Live Matches"
        }
        else if section == 2{
            return "Upcoming matches"
        }
        else{
            return "Result Matches"
        }
    }

    func saveDataTODatabase(index: Int, team1Name: String, team2Name: String){
        print(index)
        print(team1Name)
        print(team2Name)
        let context = delegate.persistentContainer.viewContext
        let matchEntity = NSEntityDescription.entity(forEntityName: "Match", in: context)!
        let newMatch = NSManagedObject(entity: matchEntity, insertInto: context)
        newMatch.setValue(team1Name, forKey: "team1Name")
        newMatch.setValue(team2Name, forKey: "team2Name")
        do {
            try context.save()
            print("Saved successfully")
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = mainStoryBoard.instantiateViewController(withIdentifier: "tableViewController") as! tableViewController
            navigationController?.pushViewController(destinationVC, animated: true)
        } catch let error as NSError {
            print(error)
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if indexPath.row < 6 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableViewCell", for: indexPath) as! ScoreTableViewCell
                
                let url1 = URL(string: liveArr[indexPath.row].t1img ?? "https://g.cricapi.com/img/teams/6-637877070670541994.webp")
                cell.team1Image.downloadImage(from: url1!)
                cell.team1Image.layer.cornerRadius = 50
                
                let url2 = URL(string: liveArr[indexPath.row].t2img ?? "https://g.cricapi.com/img/teams/6-637877070670541994.webp")
                cell.team2Image.downloadImage(from: url2!)
                cell.team2Image.layer.cornerRadius = 50
                
                cell.team1Name.text = liveArr[indexPath.row].t1
                cell.team2Name.text = liveArr[indexPath.row].t2
//                cell.team1Name.text = scoreData?.data[indexPath.row].t1
//                cell.team2Name.text = scoreData?.data[indexPath.row].t2
                
                cell.team1Score.text = liveArr[indexPath.row].t1s
                cell.team2Score.text = liveArr[indexPath.row].t2s
//                cell.team1Score.text = scoreData?.data[indexPath.row].t1s
//                cell.team2Score.text = scoreData?.data[indexPath.row].t2s
                
                cell.index = indexPath.row
                cell.onClickClosure = {index in
                    if let indexp = index{
                        self.saveDataTODatabase(index: indexp, team1Name: (self.scoreData?.data[indexPath.row].t1)!, team2Name: (self.scoreData?.data[indexPath.row].t2)!)
                    }
                }
                
                
                
                
                return cell
            }
        }
        
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LiveTableViewCell", for: indexPath) as! LiveTableViewCell
            cell.liveArr = liveArr
            cell.score = scoreData
            cell.collectionView.reloadData()
            return cell
            
        }
        if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LiveTableViewCell", for: indexPath) as! LiveTableViewCell
            cell.upcomingArr = upcomingArr
            cell.score = scoreData
            cell.collectionView.reloadData()
            return cell
        }
        if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LiveTableViewCell", for: indexPath) as! LiveTableViewCell
            cell.ResultArr = ResultArr
            cell.score = scoreData
            cell.collectionView.reloadData()
            return cell
        }

        return UITableViewCell()
    }
}

extension UIImageView{
    func downloadImage(from url: URL){
        contentMode = .scaleToFill
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil{
                let image = UIImage(data: data)
                DispatchQueue.main.async{
                    self.image = image
                }
            }else{
                return
            }
        }
        task.resume()
    }
}


//MARK: - trying date




//                let recentMatches = scoreData?.data.filter({ match in
//                    let dateFormatter = ISO8601DateFormatter()
//                    if let date = dateFormatter.date(from: match.dateTimeGMT){
//                        return sortedArr.append(date)
//
//                    }
//                    return false
//                })

//                var newArr: [Score] = []
//                var convertedArray: [Date] = []

//                var dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-mm-ddThh:mm:ss"// yyyy-MM-dd"

//                for dat in 0..<(scoreData?.data.count)!{
//                    newArr.append((scoreData?.data[dat])!)
////                    let date = dateFormatter.date(from: dat)
////                    if let date = date {
////                        convertedArray.append(date)
////                    }
//                }
//                print(newArr)

//                var ready = convertedArray.sorted(by: { $0.compare($1) == .orderedDescending })
////                sortedArr = recentMatches!
//                print(sortedArr)
//                sortedArr.append(recentMatches)












//    var dateFormatter = ISO8601DateFormatter()
//    if let date = dateFormatter.date(from: recentArr[0].dateTimeGMT){
//        return date?.timeIntervalSinceNow > -24 * 60 * 60
//    }
//        func getDate(){
//            for i in 0..<recentArr.count{
//                var dateFormatter = ISO8601DateFormatter()
//                if let date = dateFormatter.date(from: recentArr[i].dateTimeGMT){
//                    sortedArr.append(date)
//                }
//                recentArr[i].dateTimeGMT
//                if let date = date {
//                    convertedArray.append(date)
//                }
//            }
//        }














//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let myLabel = UILabel()
//            myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 30)
//            myLabel.font = UIFont.boldSystemFont(ofSize: 30)
//            myLabel.text = "Recent Mathches"
//            let headerView = UIView()
//            headerView.addSubview(myLabel)
//            return headerView
//    }

