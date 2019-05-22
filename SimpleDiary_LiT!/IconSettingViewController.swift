//
//  IconSettingViewController.swift
//  SimpleDiary_LiT!
//
//  Created by 原田澪 on 2019/05/22.
//  Copyright © 2019 原田澪. All rights reserved.
//

import UIKit
import RealmSwift

class IconSettingViewController: UIViewController {
    
    @IBOutlet var contextTextView: UITextView!
    @IBOutlet var icon1ImageView: UIImageView!
    @IBOutlet var icon2ImageView: UIImageView!
    @IBOutlet var icon3ImageView: UIImageView!
    @IBOutlet var icon4ImageView: UIImageView!
    @IBOutlet var icon5ImageView: UIImageView!
    @IBOutlet var icon6ImageView: UIImageView!
    
    var iconImage1: [UIImage]!
    var iconImage2: [UIImage]!
    var iconImage3: [UIImage]!
    var iconImage4: [UIImage]!
    var iconImage5: [UIImage]!
    var iconImage6: [UIImage]!
    
    var iconNumber = 0
    
    //textField以外の部分をタップするとキーボードをしまう
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapIcon1() {
        iconNumber = 1
        icon1ImageView.image = iconImage1[1]
    }
    @IBAction func tapIcon2() {
        iconNumber = 2
        icon2ImageView.image = iconImage2[1]
    }
    @IBAction func tapIcon3() {
        iconNumber = 3
        icon3ImageView.image = iconImage3[1]
    }
    @IBAction func tapIcon4() {
        iconNumber = 4
        icon4ImageView.image = iconImage4[1]
    }
    @IBAction func tapIcon5() {
        iconNumber = 5
        icon5ImageView.image = iconImage5[1]
    }
    @IBAction func tapIcon6() {
        iconNumber = 6
        icon6ImageView.image = iconImage6[1]
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("アイコンの登録")
        
        //STEP.2 保存する要素を書く
        let icon = Icon()
        if iconNumber == 1 {
            icon.iconInfo1 = contextTextView.text
        }
        if iconNumber == 2 {
            icon.iconInfo2 = contextTextView.text
        }
        if iconNumber == 3 {
            icon.iconInfo3 = contextTextView.text
        }
        if iconNumber == 4 {
            icon.iconInfo4 = contextTextView.text
        }
        if iconNumber == 5 {
            icon.iconInfo5 = contextTextView.text
        }
        if iconNumber == 6 {
            icon.iconInfo6 = contextTextView.text
        }
        
        //STEP.3 Realmに書き込み
        try! realm.write {
            realm.add(icon)
        }
        
        //画面遷移して前の画面に戻る
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
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        DispatchQueue(label: "background").async {
//            let realm = try! Realm()
//
//            if let savedIcon = realm.objects(Icon.self).last {
//                let iconInfo1 = savedIcon.iconInfo1
//                let iconInfo2 = savedIcon.iconInfo2
//                let iconInfo3 = savedIcon.iconInfo3
//                let iconInfo4 = savedIcon.iconInfo4
//                let iconInfo5 = savedIcon.iconInfo5
//                let iconInfo6 = savedIcon.iconInfo6
//
//                DispatchQueue.main.async {
//                    self.contextTextView1.text = iconInfo1
//                    self.contextTextView2.text = iconInfo2
//                    self.contextTextView3.text = iconInfo3
//                    self.contextTextView4.text = iconInfo4
//                    self.contextTextView5.text = iconInfo5
//                    self.contextTextView6.text = iconInfo6
//                }
//            }
//        }
//    }
}
