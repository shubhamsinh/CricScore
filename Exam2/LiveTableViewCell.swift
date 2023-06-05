//
//  LiveTableViewCell.swift
//  Exam2
//
//  Created by Shubhamsinh Rahevar on 22/02/23.
//

import UIKit

class LiveTableViewCell: UITableViewCell {
    
    var score: ScoreModel?
    var recentArr = [Score]()
    var liveArr = [Score]()
    var upcomingArr = [Score]()
    var ResultArr = [Score]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension LiveTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return score?.data.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveCollectionViewCell", for: indexPath) as! LiveCollectionViewCell
        cell.team1Name.text = score?.data[indexPath.row].t1
        cell.team2Name.text = score?.data[indexPath.row].t2
        
//        cell.team1Score.text = score?.data[indexPath.row].t1s
//        cell.team2Score.text = score?.data[indexPath.row].t2s
        
        let url1 = URL(string: score?.data[indexPath.row].t1img ?? "https://g.cricapi.com/img/teams/6-637877070670541994.webp")
        cell.team1Image.downloadImage(from: url1!)
        let url2 = URL(string: score?.data[indexPath.row].t2img ?? "https://g.cricapi.com/img/teams/6-637877070670541994.webp")
        cell.team2Image.downloadImage(from: url2!)
        return cell
    }
    
    
}
