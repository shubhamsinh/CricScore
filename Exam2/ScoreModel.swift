//
//  ScoreModel.swift
//  Exam1
//
//  Created by Shubhamsinh Rahevar on 22/02/23.
//

import Foundation

struct ScoreModel: Codable{
    var apikey: String
    var data: [Score]
}

struct Score: Codable{
    var id: String
    var date: Date = Date()
    var dateTimeGMT: String{
        willSet(newDate){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
            let formattedDate = formatter.date(from: newDate)
            date = formattedDate!
        }
    }
    var matchType: String
    var status: String
    var ms: String
    var t1: String
    var t2: String
    var t1s: String
    var t2s: String
    var t1img: String?
    var t2img: String?
}
