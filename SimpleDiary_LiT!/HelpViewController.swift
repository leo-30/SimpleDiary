//
//  HelpViewController.swift
//  SimpleDiary_LiT!
//
//  Created by 原田澪 on 2019/05/22.
//  Copyright © 2019 原田澪. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    var number: Int = 0
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var buttonRight: UIButton!
    @IBOutlet var buttonLeft: UIButton!
    
    @IBOutlet var imageView: UIImageView!
    
    var imageArray: [String] = ["help1", "help2", "help3"]
    
    @IBAction func tapButton1() {
        number = 0
        imageView.image = UIImage(named: imageArray[number])
    }
    
    @IBAction func tapButton2() {
        number = 1
        imageView.image = UIImage(named: imageArray[number])
    }
    
    @IBAction func tapButton3() {
        number = 2
        imageView.image = UIImage(named: imageArray[number])
    }
    
    @IBAction func tapRight() {
        number += 1
        if number >= 3 {
            number = 0
        }
        imageView.image = UIImage(named: imageArray[number])
    }
    
    @IBAction func tapLeft() {
        number -= 1
        if number < 0 {
            number = 2
        }
        imageView.image = UIImage(named: imageArray[number])
    }
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        number += 1
        if number >= 3 {
            number = 0
        }
        imageView.image = UIImage(named: imageArray[number])
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        number -= 1
        if number < 0 {
            number = 2
        }
        imageView.image = UIImage(named: imageArray[number])
    }
    
    @IBAction func tapToCalendar(_ sender: UIButton) {
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
}
