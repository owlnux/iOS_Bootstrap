//
//  ToDoListEntity.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 12/21/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import RealmSwift

class ToDoListEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var name: String = ""
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var isDone: Bool = false
    // List<T> is a generic data type, that’s why i didn’t add dynamic before declaring tasks property as generic properties can’t be represented in Objective-C runtime.
    let tasks = List<TaskEntity>()
    
    override static func primaryKey() -> String? { return "id" }
    
}
