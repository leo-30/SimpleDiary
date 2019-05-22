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
    
    @IBOutlet var contextTextView1: UITextView!
    @IBOutlet var contextTextView2: UITextView!
    @IBOutlet var contextTextView3: UITextView!
    @IBOutlet var contextTextView4: UITextView!
    @IBOutlet var contextTextView5: UITextView!
    @IBOutlet var contextTextView6: UITextView!
    
    //textField以外の部分をタップするとキーボードをしまう
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("アイコンの登録")
        
        //STEP.2 保存する要素を書く
        let icon = Icon()
        icon.iconInfo1 = contextTextView1.text
        icon.iconInfo2 = contextTextView2.text
        icon.iconInfo3 = contextTextView3.text
        icon.iconInfo4 = contextTextView4.text
        icon.iconInfo5 = contextTextView5.text
        icon.iconInfo6 = contextTextView6.text
        
        //STEP.3 Realmに書き込み
        try! realm.write {
            realm.add(icon)
        }
        
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            
            if let savedIcon = realm.objects(Icon.self).last {
                let iconInfo1 = savedIcon.iconInfo1
                let iconInfo2 = savedIcon.iconInfo2
                let iconInfo3 = savedIcon.iconInfo3
                let iconInfo4 = savedIcon.iconInfo4
                let iconInfo5 = savedIcon.iconInfo5
                let iconInfo6 = savedIcon.iconInfo6
                
                DispatchQueue.main.async {
                    self.contextTextView1.text = iconInfo1
                    self.contextTextView2.text = iconInfo2
                    self.contextTextView3.text = iconInfo3
                    self.contextTextView4.text = iconInfo4
                    self.contextTextView5.text = iconInfo5
                    self.contextTextView6.text = iconInfo6
                }
            }
        }
    }
}
