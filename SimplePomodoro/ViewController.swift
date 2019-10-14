//
//  ViewController.swift
//  SimplePomodoro
//
//  Created by Summer on 14/10/19.
//  Copyright © 2019 Ake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    var workSecondRemain = 1499
    var restSecondRemain = 299
    
    var timer = Timer()
    var percentage: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: UIButton) {
       startButton.isEnabled = false
         timer.invalidate()
         timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        
        if(workSecondRemain>0){
           // percentage = Float(100)-(Float(secondRemain)/Float(1500)*100)
            let (m, s) = secondsToMinutesSeconds(seconds: workSecondRemain)
            timerLabel.text = "🍅 \(m):\(s)"
            workSecondRemain -= 1
            subTitleLabel.text = "It's work time. Never give up!"
        }else{
            let (m, s) = secondsToMinutesSeconds(seconds: restSecondRemain)
            subTitleLabel.text = "You've done it, now rest time"
            timerLabel.text = "😌 \(m):\(s)"
            restSecondRemain -= 1
            if(restSecondRemain<=0){
                workSecondRemain = 1499
                restSecondRemain = 299
                startButton.isEnabled = true
                timer.invalidate()
                self.loadView()
            }
        }
    }
    
    func secondsToMinutesSeconds (seconds : Int) -> (Int, Int) {
      return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
        
            let dialogMessage = UIAlertController(title: "Confirm", message: "😢 Are you sure you want to give up and reset the timer?", preferredStyle: .alert)
               
               // Create OK button with action handler
               let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    self.resetTimer()
               })
               
               // Create Cancel button with action handlder
               let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
               }
            
               dialogMessage.addAction(ok)
               dialogMessage.addAction(cancel)
               
               self.present(dialogMessage, animated: true, completion: nil)
           }
        
           func resetTimer()
           {
               workSecondRemain = 1499
               restSecondRemain = 299
               startButton.isEnabled = true
               timer.invalidate()
               self.loadView()
           }

    }


