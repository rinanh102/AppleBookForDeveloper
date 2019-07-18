//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by henry on 28/05/2019.
//  Copyright © 2019 HenryNguyen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questionIndex = 0
    var questions : [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answer: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
                ]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answer: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cudding", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
            ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answer: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "I love them", type: .dog)
            ])
    ]
    
    // TODO: store the player's answer
    var answerChoosen : [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateIU()
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswer = questions[questionIndex].answer
        
        switch sender {
        case singleButton1:
            answerChoosen.append(currentAnswer[0])
        case singleButton2:
            answerChoosen.append(currentAnswer[1])
        case singleButton3:
            answerChoosen.append(currentAnswer[2])
        case singleButton4:
            answerChoosen.append(currentAnswer[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multiAnswerButtonPressed() {
        let currentAnswer = questions[questionIndex].answer
        
        if multiSwitch1.isOn {
            answerChoosen.append(currentAnswer[0])
        }
        
        if multiSwitch2.isOn {
            answerChoosen.append(currentAnswer[1])
        }
        
        if multiSwitch3.isOn {
            answerChoosen.append(currentAnswer[2])
        }
        
        if multiSwitch4.isOn {
            answerChoosen.append(currentAnswer[3])
        }
        
        nextQuestion()
    }
    // Argument: None : dont need to determine which button is tapped
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswer = questions[questionIndex].answer
        
        let index = Int(round(rangedSlider.value * Float(currentAnswer.count - 1)))
        print("Range: \(rangedSlider.value)")
        print("Index: \(rangedSlider.value * Float(currentAnswer.count - 1))")
        print("Index rounded: \(round(rangedSlider.value * Float(currentAnswer.count - 1)))")
        
        answerChoosen.append(currentAnswer[index])
        
        nextQuestion()
    }
    func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateIU()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
        
    }
    func updateIU(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswer = currentQuestion.answer
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question \(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswer)
        case .multiple:
            updateMiltiStackView(using: currentAnswer)
        case .ranged:
            rangedStackView.isHidden = false
        }
    }
    
    func updateSingleStack(using answer: [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answer[0].text, for: .normal)
        singleButton2.setTitle(answer[1].text, for: .normal)
        singleButton3.setTitle(answer[2].text, for: .normal)
        singleButton4.setTitle(answer[3].text, for: .normal)
    }
    
    func updateMiltiStackView(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStackView(using answers: [Answer]){
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultVC = segue.destination as! ResultViewController
            resultVC.responses = answerChoosen
        }
    }

}
