//
//  Diary.swift
//  SimpleDiary_LiT!
//
//  Created by 原田澪 on 2019/05/22.
//  Copyright © 2019 原田澪. All rights reserved.
//

import RealmSwift

class Diary: Object {
    
    @objc dynamic var date: String = ""
    @objc dynamic var context: String = ""
    @objc dynamic var icon1: Int = 0
    @objc dynamic var icon2: Int = 0
    @objc dynamic var icon3: Int = 0
    @objc dynamic var icon4: Int = 0
    @objc dynamic var icon5: Int = 0
    @objc dynamic var icon6: Int = 0
    
}
