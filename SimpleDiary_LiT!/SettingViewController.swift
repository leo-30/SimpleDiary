//
//  SettingViewController.swift
//  SimpleDiary_LiT!
//
//  Created by 原田澪 on 2019/05/22.
//  Copyright © 2019 原田澪. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet var alarmButton: UIButton!
    
    @IBAction func tapToCalendar(_ sender: UIButton) {
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmButton.isEnabled = false
    }
}
