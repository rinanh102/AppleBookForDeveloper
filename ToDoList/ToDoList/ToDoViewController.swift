//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by henry on 06/07/2019.
//  Copyright © 2019 HenryNguyen. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    @IBOutlet weak var titleTexField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var isPickerHidden = true
    var todo : ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        if let todo = todo {
            navigationItem.title = todo.title
            titleTexField.text = todo.title
            dueDatePickerView.date = todo.dueDate
            isCompleteButton.isSelected = todo.isComplete
            notesTextView.text = todo.note
        } else {
            //TODO: set starting value: 24hours from now
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        updateDueDateLabel(date: dueDatePickerView.date)
    }

    func updateSaveButtonState() {
        if let text = titleTexField.text {
            // unwrap text . if there no value -> set empty string for default value
            print("empty: \(text.isEmpty)")
            saveButton.isEnabled = !text.isEmpty
        }
    }
    
    //TODO: prevent user create Note without title
    // the updateSaveButton method should be calles whenever each keyboard tapped to ensure the Save button  is always up to date
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTexField.resignFirstResponder()
    }
    //TODO: Change the image when the button is tapped
    @IBAction func isCompletedButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }

    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    //TODO: response to the user tapping the Due Date Cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]:
            isPickerHidden = !isPickerHidden
            
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    
    //TODO: Expand and Collaspse the Date Picker View
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch indexPath {
        case [1,0]: // Due Date Cell
            return isPickerHidden ? normalCellHeight : largeCellHeight
        case [2,0]: // Notes Cell
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    //TODO: prepare before segue is performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTexField.text! // it is sale to force-unwrap here. Because we set just enable Save button when there is text in text field
        let dueDate = dueDatePickerView.date
        let note = notesTextView.text ?? ""
        let isComplete = isCompleteButton.isSelected
        // the model is stored in property
        todo = ToDo(title: title, dueDate: dueDate, note: note, isComplete: isComplete)
    }
    
  
}
