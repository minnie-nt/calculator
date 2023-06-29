//
//  ViewController.swift
//  BasicUIAutoLayout
//
//  Created by Ornthita.Eae on 15/6/2566 BE.
//

import UIKit

class ViewController: UIViewController {

  
    
    // MARK: - Special tap
    @IBOutlet weak var numberShow: UILabel!
    @IBOutlet weak var acShow: UIButton!
    var workings: String = ""
    var hasDot: Bool = false
    var isNum: Bool = true
    var sym: Symbol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func equalTap(_ sender: Any) {
        formatPercent()
        numberShow.text = calculate()
        isNum = true
    }

    @IBAction func percentTap(_ sender: Any) {
        if isNum && !workings.isEmpty{
            setWorkings("%")
        }
    }
    
    @IBAction func acTap(_ sender: Any) {
        allClear()
    }
    
    @IBAction func delTap(_ sender: Any) {
        if !workings.isEmpty {
            del()
        }
    }
    
    // MARK: Functional code
    
    func setWorkings(_ s: String){
        workings = workings + s
        print(workings)
        numberShow.text = workings
    }
    
    func formatPercent() {
        workings =  workings.replacingOccurrences(of: "%", with: "*0.01")
    }
    
    func calculate() -> String {
        let expression = NSExpression(format: workings)
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        let resultString = formatResult(result: result)
        return resultString
    }
    
    func formatResult(result: Double) -> String {
        if (result.truncatingRemainder(dividingBy: 1) == 0 ) {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    func allClear() {
        numberShow.text = "0"
        workings = ""
        hasDot = false
    }
    
    func del() {
        workings.removeLast()
        setWorkings("")
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
        
        if isNum {
            setWorkings(sym!.rawValue)
            isNum = false
        } else {
            workings.removeLast()
            setWorkings(sym!.rawValue)
            isNum = false
        }
    }

    @IBAction func onTapNumber(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            setWorkings(number)
            isNum = true
        }
    }
  
    @IBAction func dotTap(_ sender: Any) {
        if !hasDot && isNum {
            setWorkings(".")
            hasDot = true
            isNum = false
        }
    }
    
}

// MARK: Model
extension ViewController {
    enum Symbol: String {
        case plus = "+"
        case minus = "-"
        case multi = "*"
        case divide = "/"
    }
}

