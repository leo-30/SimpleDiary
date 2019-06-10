//
//  AlarmSettingViewController.swift
//  SimpleDiary_LiT!
//
//  Created by 原田澪 on 2019/06/06.
//  Copyright © 2019 原田澪. All rights reserved.
//

import UIKit

class AlarmSettingViewController: UIViewController {
    
//    //インスタンスを生成
//    let alarm = Alarm()
    
    @IBOutlet var alarmTimePicker: UIDatePicker!
    var hour: Int = 21;
    var minute: Int = 0;
    @IBOutlet var alarmSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIDatePickerを.timeモードにする
        alarmTimePicker.datePickerMode = UIDatePicker.Mode.time
        //現在の時間をDatePickerに表示
        alarmTimePicker.setDate(Date(), animated: false)
    }
    
    @IBAction func testUISwitch(sender: UISwitch) {
        if ( sender.isOn ) {
            print("ONです。")
            alarmTimePicker.isEnabled = false
        } else {
            print("OFFです。")
            alarmTimePicker.isEnabled = true
        }
    }
    
    @IBAction func tapAlarmSetting(_ sender: UIButton) {
        
        // Date Picker → Int
        
        let alarmDate = Calendar(identifier: .gregorian)
        let pickerDate = alarmTimePicker.date
        let dateComponents = alarmDate.dateComponents([.hour, .minute], from: pickerDate )
        
        hour = dateComponents.hour!
        minute = dateComponents.minute!
        
        let title = "完了"
        let message = "アラームを設定しました"
        let okText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        present(alert, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
    }
}
