//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by henry on 28/05/2019.
//  Copyright © 2019 HenryNguyen. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    var responses : [Answer]!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        print(responses!)
        calculatePersonalityResult()
    }
    
    func calculatePersonalityResult(){
        var frequencyOfAnswer: [AnimalType: Int] = [:]
        
        //TODO: create new collection by mapping each Answer to its corresponding type
        let responseTypes = responses.map {$0.type}
        
        for response in responseTypes {
            frequencyOfAnswer[response] = (frequencyOfAnswer[response] ?? 0) + 1
            print("Few \(frequencyOfAnswer[response] ?? 0)")
        }
        
        //        //TODO: place each key/value into an array, sorting the value properties in descending order
//        let frequencyAnswerSorted = frequencyOfAnswer.sorted { (pair1, pair2) -> Bool in
//            return pair1.value > pair2.value
//        }
//        let mostCommonAnswer = frequencyAnswerSorted.first?.key
        
        // trailing closure syntax, using $1 & $2 as argument names
        let mostCommonAnwser = frequencyOfAnswer.sorted{ $0.1 > $1.1 }.first?.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnwser!)"
        resultDefinitionLabel.text = mostCommonAnwser?.definition
    }
    
    

}
