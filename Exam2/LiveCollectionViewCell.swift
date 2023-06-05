//
//  LiveCollectionViewCell.swift
//  Exam2
//
//  Created by Shubhamsinh Rahevar on 22/02/23.
//

import UIKit

class LiveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tourLabel: UILabel!
    @IBOutlet weak var matchTypeLabel: UILabel!
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team1Overs: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var team2Overs: UILabel!
    @IBOutlet weak var matchSituationLabel: UILabel!
}
