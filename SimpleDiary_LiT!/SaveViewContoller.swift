//
//  SaveViewContoller.swift
//  SimpleDiary_LiT!
//
//  Created by 原田澪 on 2019/05/22.
//  Copyright © 2019 原田澪. All rights reserved.
//

import UIKit
import RealmSwift

class SaveViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var contextTextView: UITextView!
    
    var date: String! //ここに前の画面からの変数の値が入る
    
    var icon1 = 0
    var icon2 = 0
    var icon3 = 0
    var icon4 = 0
    var icon5 = 0
    var icon6 = 0
    
    //textField以外の部分をタップするとキーボードをしまう
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateLabel.text = date
        
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            
            if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
                let context = savedDiary.context
                DispatchQueue.main.async {
                    self.contextTextView.text = context
                }
            }
        }
    }
    
    @IBAction func tapToCalendar(_ sender: UIButton) {
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //STEP.2 保存する要素を書く
        let diary = Diary()
        diary.date = date
        diary.context = contextTextView.text
        diary.icon1 = icon1
        diary.icon2 = icon2
        diary.icon3 = icon3
        diary.icon4 = icon4
        diary.icon5 = icon5
        diary.icon6 = icon6
        
        //STEP.3 Realmに書き込み
        try! realm.write {
            realm.add(diary)
        }
        
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
