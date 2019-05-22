//
//  DiaryViewController.swift
//  SimpleDiary_LiT!
//
//  Created by 原田澪 on 2019/05/22.
//  Copyright © 2019 原田澪. All rights reserved.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contextLabel: UILabel!
    @IBOutlet var icon1ImageView: UIImageView!
    @IBOutlet var icon2ImageView: UIImageView!
    @IBOutlet var icon3ImageView: UIImageView!
    @IBOutlet var icon4ImageView: UIImageView!
    @IBOutlet var icon5ImageView: UIImageView!
    @IBOutlet var icon6ImageView: UIImageView!
    
    var date: String!
    var icon1 = 0
    var icon2 = 0
    var icon3 = 0
    var icon4 = 0
    var icon5 = 0
    var icon6 = 0
    
    var iconImage1: [UIImage]!
    var iconImage2: [UIImage]!
    var iconImage3: [UIImage]!
    var iconImage4: [UIImage]!
    var iconImage5: [UIImage]!
    var iconImage6: [UIImage]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateLabel.text = date
        
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            
            if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
                let context = savedDiary.context
                DispatchQueue.main.async {
                    self.contextLabel.text = context
                }
            }
        }
        
    }
    
    @IBAction func modoru() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconImage1 = [UIImage(named: "flower1.png")!, UIImage(named: "flower2.png")!]
        iconImage2 = [UIImage(named: "music1.png")!, UIImage(named: "music2.png")!]
        iconImage3 = [UIImage(named: "good1.png")!, UIImage(named: "good2.png")!]
        iconImage4 = [UIImage(named: "study1.png")!, UIImage(named: "study2.png")!]
        iconImage5 = [UIImage(named: "book1.png")!, UIImage(named: "book2.png")!]
        iconImage6 = [UIImage(named: "exercise1.png")!, UIImage(named: "exercise2.png")!]
        
        let realm = try! Realm()
        //文字列によるクエリ
        if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
            
            print("Realmの保存内容")
            print(savedDiary)
            
            icon1 = savedDiary.icon1
            icon2 = savedDiary.icon2
            icon3 = savedDiary.icon3
            icon4 = savedDiary.icon4
            icon5 = savedDiary.icon5
            icon6 = savedDiary.icon6
        }
        else {
            print("データがありません")
            icon1 = 0
            icon2 = 0
            icon3 = 0
            icon4 = 0
            icon5 = 0
            icon6 = 0
        }
        
        icon1ImageView.image = iconImage1[icon1]
        icon2ImageView.image = iconImage2[icon2]
        icon3ImageView.image = iconImage3[icon3]
        icon4ImageView.image = iconImage4[icon4]
        icon5ImageView.image = iconImage5[icon5]
        icon6ImageView.image = iconImage6[icon6]
    }
}
