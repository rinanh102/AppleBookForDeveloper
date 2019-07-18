//
//  TableViewController.swift
//  ToDoList
//
//  Created by henry on 06/07/2019.
//  Copyright © 2019 HenryNguyen. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, ToDoCellDelegate {
    var todos = [ToDo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: try to load data from disk
        if let savedTodos = ToDo.loadToDos() {
            todos = savedTodos
        } else {
            todos = ToDo.loadSampleToDos()
        }
       
        //TODO: Add Edit button
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as? ToDoCell else { fatalError("Could not dequeue a cell")}
        
        let todo = todos[indexPath.row]
        //TODO: set the cell delegate
        cell.delegate = self
        cell.titleLabel?.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        return cell
    }
    //TODO: choose which cells are editable
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //TODO: remove the cell in the array & TableView
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //TODO: save the data when user delete the item
            ToDo.saveToDos(todos)
        }
    }
    //TODO: allow future button taps to unwind this viewController
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind" else { return }
        //TODO: check if a model object exist in the segue's source
        let sourceVC = segue.source as! ToDoViewController
        
        if let todo = sourceVC.todo {
            //TODO: unwrap the table view's selected index path
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //TODO: if the model if not nil, update model and cell
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                //TODO: calculate the indexPath
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
          
        }
        //TODO: save the data when user tap the Save Button
        ToDo.saveToDos(todos)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let todoVC = segue.destination as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoVC.todo = selectedTodo
        }
    }
    
    //TODO: conform the condition of the ToDoCellDelegate protocol
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender){
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            //TODO: save the data when user tap the Checkmark button
            ToDo.saveToDos(todos)
        }
    }
    
    
   

}
