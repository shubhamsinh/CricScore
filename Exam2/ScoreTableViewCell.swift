//
//  ScoreTableViewCell.swift
//  Exam2
//
//  Created by Shubhamsinh Rahevar on 22/02/23.
//

import UIKit

typealias seeAllCloaure = ((_ index: Int?) -> Void)

class ScoreTableViewCell: UITableViewCell {
    
    var scoreSaveArr: [Score] = []
    var onClickClosure: seeAllCloaure?
    var index: Int?

    @IBOutlet weak var tourLabel: UILabel!
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var matchTypeLabel: UILabel!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var team1Overs: UILabel!
    @IBOutlet weak var team2Overs: UILabel!
    @IBOutlet weak var matchSituationLabel: UILabel!
    @IBAction func savePressed(_ sender: UIButton) {
        onClickClosure?(index)
        print("Save pressed")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
