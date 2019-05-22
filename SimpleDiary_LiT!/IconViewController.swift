//
//  IconViewController.swift
//  SimpleDiary_LiT!
//
//  Created by 原田澪 on 2019/05/22.
//  Copyright © 2019 原田澪. All rights reserved.
//

import UIKit
import RealmSwift

class IconViewController: UIViewController {
    
    @IBOutlet var iconLabel1: UILabel!
    @IBOutlet var iconLabel2: UILabel!
    @IBOutlet var iconLabel3: UILabel!
    @IBOutlet var iconLabel4: UILabel!
    @IBOutlet var iconLabel5: UILabel!
    @IBOutlet var iconLabel6: UILabel!
    
    var iconInfo1: String!
    var iconInfo2: String!
    var iconInfo3: String!
    var iconInfo4: String!
    var iconInfo5: String!
    var iconInfo6: String!
    
    @IBAction func tapToCalendar(_ sender: UIButton) {
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        let realm = try! Realm()
        //文字列によるクエリ
        if let savedIcon = realm.objects(Icon.self).last {
            
            print(savedIcon)
            
            iconInfo1 = savedIcon.iconInfo1
            iconInfo2 = savedIcon.iconInfo2
            iconInfo3 = savedIcon.iconInfo3
            iconInfo4 = savedIcon.iconInfo4
            iconInfo5 = savedIcon.iconInfo5
            iconInfo6 = savedIcon.iconInfo6
            
            iconLabel1.text = String(iconInfo1)
            iconLabel2.text = String(iconInfo2)
            iconLabel3.text = String(iconInfo3)
            iconLabel4.text = String(iconInfo4)
            iconLabel5.text = String(iconInfo5)
            iconLabel6.text = String(iconInfo6)
            
        } else {
            
            iconLabel1.text = String("内容１")
            iconLabel2.text = String("内容２")
            iconLabel3.text = String("内容３")
            iconLabel4.text = String("内容４")
            iconLabel5.text = String("内容５")
            iconLabel6.text = String("内容６")
            
        }
        
        super.viewDidLoad()
        
    }
}
