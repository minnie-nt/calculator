//
//  ViewController.swift
//  BasicUIAutoLayout
//
//  Created by Ornthita.Eae on 15/6/2566 BE.
//

import UIKit

class ViewController: UIViewController {

  
    
    // MARK: - Special tap
    @IBOutlet weak var calculatorWorkings: UILabel!
    @IBOutlet weak var numberShow: UILabel!
    
    var workings: String = ""
    var sym: Symbol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        allClear()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func equalTap(_ sender: Any) {
        formatPercent()
        calculate()
    }

    @IBAction func percentTap(_ sender: Any) {
        setWorkings("%")
    }
    
    @IBAction func acTap(_ sender: Any) {
        allClear()
    }
    
    @IBAction func delTap(_ sender: Any) {
        if !workings.isEmpty {
            workings.removeLast()
            calculatorWorkings.text = workings
        }
    }
    
    // MARK: Functional code
    
    func setWorkings(_ s: String) {
        workings = workings + s
        calculatorWorkings.text = workings
    }
    
    func formatPercent() {
        workings =  workings.replacingOccurrences(of: "%", with: "*0.01")
    }
    
    func calculate() {
        if isValid() {
            let expression = NSExpression(format: workings)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            numberShow.text = resultString
        } else {
            callAlert()
        }
        
    }
    
    func callAlert() {
        let alert = UIAlertController(
            title: "Invalid input",
            message: "Calculator can not working try again",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "okay", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func formatResult(result: Double) -> String {
        if (result.truncatingRemainder(dividingBy: 1) == 0 ) {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    func isValid() -> Bool {
        var count = 0
        var funcCharIndex = [Int]()
        for char in workings {
            if special(char) {
                funcCharIndex.append(count)
            }
            count += 1
        }
        
        var previous = -1
        for index in funcCharIndex {
            if index == 0 {
                return false
            }
            if index == workings.count - 1 {
                return false
            }
            if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    
    func special(_ ch: Character) -> Bool {
        if let _ = Symbol(rawValue: ch) {
            return true
        }
        if ch == "." {
            return true
        }
        return false
    }
    
    func allClear() {
        workings = ""
        calculatorWorkings.text = ""
        numberShow.text = ""
    }

    // MARK: Action Button Tap
    
    @IBAction func onTapOperator(_ sender: UIButton) {
        switch sender.tag {
            case 0: sym = .plus
            case 1: sym = .minus
            case 2: sym = .multi
            case 3: sym = .divide
            default: break
        }
        setWorkings(String(sym!.rawValue))
    }

    @IBAction func onTapNumber(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            setWorkings(number)
        }
    }
  
    @IBAction func dotTap(_ sender: Any) {
        setWorkings(".")
    }
    
}

// MARK: Model
extension ViewController {
    enum Symbol: Character,CaseIterable {
        case plus = "+"
        case minus = "-"
        case multi = "*"
        case divide = "/"
    }
}



