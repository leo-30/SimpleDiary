//
//  ViewController.swift
//  SimpleDiary_LiT!
//
//  Created by 原田澪 on 2019/05/22.
//  Copyright © 2019 原田澪. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

class ViewController: UIViewController,FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance {
    
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelView: UIImageView!
    @IBOutlet var lineView: UIImageView!
    @IBOutlet var writeButton: UIButton!
    @IBOutlet var diaryViewButton: UIButton!
    @IBOutlet var icon1ImageView: UIImageView!
    @IBOutlet var icon2ImageView: UIImageView!
    @IBOutlet var icon3ImageView: UIImageView!
    @IBOutlet var icon4ImageView: UIImageView!
    @IBOutlet var icon5ImageView: UIImageView!
    @IBOutlet var icon6ImageView: UIImageView!
    
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
    
    
    var date: String!
    var context: String!
    var savedContext: String!
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        labelDate.text = "\(year)年\(month)月\(day)日"
        self.date = "\(year)年\(month)月\(day)日"
        
        let realm = try! Realm()
        print(date)
        //文字列によるクエリ
        if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {

            icon1 = savedDiary.icon1
            icon2 = savedDiary.icon2
            icon3 = savedDiary.icon3
            icon4 = savedDiary.icon4
            icon5 = savedDiary.icon5
            icon6 = savedDiary.icon6
            context = savedDiary.context
            
            print(context)
            if context == "日記がありません" {
                print("日付タップでcontextはないから非表示")
                labelView.isHidden = true
                lineView.isHidden = true
                diaryViewButton.isHidden = true
            } else {
                print("日付タップでcontextは空白以外だから表示")
                labelView.isHidden = false
                lineView.isHidden = false
                diaryViewButton.isHidden = false
            }
        }
        else {
            print("データがありません")
            icon1 = 0
            icon2 = 0
            icon3 = 0
            icon4 = 0
            icon5 = 0
            icon6 = 0
            print("日付タップでデータがないから非表示")
            labelView.isHidden = true
            lineView.isHidden = true
            diaryViewButton.isHidden = true
        }
        
        icon1ImageView.image = iconImage1[icon1]
        icon2ImageView.image = iconImage2[icon2]
        icon3ImageView.image = iconImage3[icon3]
        icon4ImageView.image = iconImage4[icon4]
        icon5ImageView.image = iconImage5[icon5]
        icon6ImageView.image = iconImage6[icon6]
        
        writeButton.isEnabled = true
        diaryViewButton.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSave" {
            // segueから遷移先のNavigationControllerを取得
            let nc = segue.destination as! UINavigationController
            // NavigationControllerの一番目のViewControllerが次の画面
            let saveView = nc.topViewController as! SaveViewController
            // 次画面の変数に前の画面での内容を入れる
            saveView.date = self.date
            saveView.date = self.date
            saveView.icon1 = self.icon1
            saveView.icon2 = self.icon2
            saveView.icon3 = self.icon3
            saveView.icon4 = self.icon4
            saveView.icon5 = self.icon5
            saveView.icon6 = self.icon6
        }
        
        if segue.identifier == "diaryView" {
            // segueから遷移先のNavigationControllerを取得
            let nc = segue.destination as! UINavigationController
            // NavigationControllerの一番目のViewControllerが次の画面
            let saveView = nc.topViewController as! DiaryViewController
            // 次画面の変数に前の画面での内容を入れる
            saveView.date = self.date
            saveView.date = self.date
            saveView.icon1 = self.icon1
            saveView.icon2 = self.icon2
            saveView.icon3 = self.icon3
            saveView.icon4 = self.icon4
            saveView.icon5 = self.icon5
            saveView.icon6 = self.icon6
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            
            if let savedDiary1 = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
                self.context = savedDiary1.context
            }
        }
    }
    
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            //return UIColor.red
            return UIColor(red: 230/255, green: 40/255, blue: 70/255, alpha: 1)
            
        }
        
        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            //return UIColor(red: 235/255, green: 120/255, blue: 175/255, alpha: 1)
            return UIColor(red: 230/255, green: 40/255, blue: 70/255, alpha: 1)
        }
        else if weekday == 7 {  //土曜日
            return UIColor(red: 72/255, green: 100/255, blue: 230/255, alpha: 1)
        }
        
        return nil
    }
    
    @IBAction func tapButton1() {
        icon1 += 1
        if icon1 > 1 {
            icon1 = 0
        }
        icon1ImageView.image = iconImage1[icon1]
    }
    
    @IBAction func tapButton2() {
        icon2 += 1
        if icon2 > 1 {
            icon2 = 0
        }
        icon2ImageView.image = iconImage2[icon2]
    }
    
    @IBAction func tapButton3() {
        icon3 += 1
        if icon3 > 1 {
            icon3 = 0
        }
        icon3ImageView.image = iconImage3[icon3]
    }
    
    @IBAction func tapButton4() {
        icon4 += 1
        if icon4 > 1 {
            icon4 = 0
        }
        icon4ImageView.image = iconImage4[icon4]
    }
    
    @IBAction func tapButton5() {
        icon5 += 1
        if icon5 > 1 {
            icon5 = 0
        }
        icon5ImageView.image = iconImage5[icon5]
    }
    
    @IBAction func tapButton6() {
        icon6 += 1
        if icon6 > 1 {
            icon6 = 0
        }
        icon6ImageView.image = iconImage6[icon6]
    }
    
    @IBAction func tapWrite(_ sender: UIButton) {
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        if let savedDiaryWrite = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
            print("contextに前の内容を記入")
            savedContext = savedDiaryWrite.context
        } else {
            print("contextに日記がありませんと記入")
            savedContext = "日記がありません"
        }
        
        //STEP.2 保存する要素を書く
        let diary = Diary()
        diary.date = date
        diary.context = savedContext
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
        
        self.performSegue(withIdentifier: "toSave", sender: nil)
    }
    
    @IBAction func tapDiaryView() {
        self.performSegue(withIdentifier: "diaryView", sender: nil)
    }
    
    @IBAction func tapHelp() {
        self.performSegue(withIdentifier: "toHelp", sender: nil)
    }
    
    @IBAction func tapIconView(_ sender: Any) {
        self.performSegue(withIdentifier: "toIcon", sender: nil)
    }
    
    @IBAction func tapToSetting(_ sender: Any) {
        self.performSegue(withIdentifier: "toSetting", sender: nil)
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        //保存ボタンを押した時にセーブする
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        if let savedDiarySave = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
            print("contextに前の内容を記入")
            savedContext = savedDiarySave.context
        } else {
            print("contextに日記がありませんと記入")
            savedContext = "日記がありません"
        }
        
        //STEP.2 保存する要素を書く
        let diary = Diary()
        diary.date = date
        diary.icon1 = icon1
        diary.icon2 = icon2
        diary.icon3 = icon3
        diary.icon4 = icon4
        diary.icon5 = icon5
        diary.icon6 = icon6
        diary.context = savedContext
        
        //STEP.3 Realmに書き込み
        try! realm.write {
            realm.add(diary)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconImage1 = [UIImage(named: "flower1.png")!, UIImage(named: "flower2.png")!]
        iconImage2 = [UIImage(named: "music1.png")!, UIImage(named: "music2.png")!]
        iconImage3 = [UIImage(named: "good1.png")!, UIImage(named: "good2.png")!]
        iconImage4 = [UIImage(named: "study1.png")!, UIImage(named: "study2.png")!]
        iconImage5 = [UIImage(named: "book1.png")!, UIImage(named: "book2.png")!]
        iconImage6 = [UIImage(named: "exercise1.png")!, UIImage(named: "exercise2.png")!]
        
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateStyle = .long
        let now = dateFormater.string(from: Date())
        date = now
        labelDate.text = date
        if labelDate.text == "日付を選択" {
            writeButton.isEnabled = false
            diaryViewButton.isEnabled = false
            
        }
        
        let realm = try! Realm()
        if let savedDiaryFirst = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
            
            print("最初の画面での保存データ")
            print(savedDiaryFirst)
            context = savedDiaryFirst.context
            icon1 = savedDiaryFirst.icon1
            icon2 = savedDiaryFirst.icon2
            icon3 = savedDiaryFirst.icon3
            icon4 = savedDiaryFirst.icon4
            icon5 = savedDiaryFirst.icon5
            icon6 = savedDiaryFirst.icon6
            
            icon1ImageView.image = iconImage1[icon1]
            icon2ImageView.image = iconImage2[icon2]
            icon3ImageView.image = iconImage3[icon3]
            icon4ImageView.image = iconImage4[icon4]
            icon5ImageView.image = iconImage5[icon5]
            icon6ImageView.image = iconImage6[icon6]
            
            if context == nil {
                labelView.isHidden = true
                lineView.isHidden = true
                diaryViewButton.isHidden = true
            } else {
                labelView.isHidden = false
                lineView.isHidden = false
                diaryViewButton.isHidden = false
            }
        } else {
            labelView.isHidden = true
            lineView.isHidden = true
            diaryViewButton.isHidden = true
        }
    }
}

//extension UIColor {
//    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
//        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
//    }
//}
