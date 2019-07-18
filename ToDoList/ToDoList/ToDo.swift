//
//  ToDo.swift
//  ToDoList
//
//  Created by henry on 06/07/2019.
//  Copyright © 2019 HenryNguyen. All rights reserved.
//

import UIKit

struct ToDo : Codable {
    var title: String
    var dueDate: Date
    var note: String
    var isComplete: Bool
    
    //TODO: load data from disk
    static func loadToDos() -> [ToDo]? {
        guard let codedTodos = try? Data(contentsOf: ArchiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedTodos)
    }
    
    static func loadSampleToDos() -> [ToDo]{
        let todo1 = ToDo(title: "HomeWork", dueDate: Date(), note: "Math", isComplete: false)
        let todo2 = ToDo(title: "Exercise", dueDate: Date(), note: "Play tennis", isComplete: false)
        return [todo1, todo2]
    }
    
    // keyword static
    //create a DateFormatter object
    static let dueDateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    //TODO: Save the data to disk
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    static func saveToDos(_ todos: [ToDo]){
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try?  propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    }
}
