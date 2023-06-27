//
//  ViewController.swift
//  BasicUIAutoLayout
//
//  Created by Ornthita.Eae on 15/6/2566 BE.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var numberShow: UILabel!
    @IBOutlet weak var acShow: UIButton!
    var workings: String = ""
    var hasDot: Bool = false
    var isNum: Bool = true

    
   
    
    var sym: Symbol? = nil
    
//    override func loadView() {
//        print("a")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("b")
        // Do any additional setup after loading the view.
    }
    
    
    
 
    func allClear() {
        numberShow.text = "0"
        workings = ""
        hasDot = false
    }
    
    func setWorkings(_ s: String){
        workings = workings + s
        print(workings)
        numberShow.text = workings
        sym = nil
        
        
    }
    
    @IBAction func equalTap(_ sender: Any) {
        workings =  workings.replacingOccurrences(of: "%", with: "*0.01")
        print(workings)
        let expression = NSExpression(format: workings)
        
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        let resultString = formatResult(result: result)
        numberShow.text = resultString
        isNum = true
    }
    
    func formatResult(result: Double) -> String {
        if (result.truncatingRemainder(dividingBy: 1) == 0 ) {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }

    @IBAction func percentTap(_ sender: Any) {
        if isNum {
            setWorkings("%")
        }
    }
    
    @IBAction func acTap(_ sender: Any) {
        allClear()
    }
    
    @IBAction func del(_ sender: Any) {
        if !workings.isEmpty {
            workings.removeLast()
            setWorkings("")
        }
    }
    
    @IBAction func divideTap(_ sender: Any) {
        sym = .divide
        if isNum {
            setWorkings(sym!.rawValue)
            isNum = false
        } else {
            workings.removeLast()
            setWorkings(sym!.rawValue)
            isNum = false
        }
    }
    
    @IBAction func multiplyTap(_ sender: Any) {
        sym = .multi
        if isNum {
            setWorkings(sym!.rawValue)
            isNum = false
        } else {
            workings.removeLast()
            setWorkings(sym!.rawValue)
            isNum = false
        }
    }
    
    @IBAction func minusTap(_ sender: Any) {
        sym = .minus
        if isNum {
            setWorkings(sym!.rawValue)
            isNum = false
        } else {
            workings.removeLast()
            setWorkings(sym!.rawValue)
            isNum = false
        }
    }
    
    @IBAction func plusTap(_ sender: Any) {
        sym = .plus
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
        
        let tag = sender.tag
        
    }
    
    
    
//    @IBAction func zeroTap(_ sender: UIButton) {
//        setWorkings("0")
//        print(sender.titleLabel?.text)
//        isNum = true
//    }
    
    @IBAction func oneTap(_ sender: Any) {
        setWorkings("1")
        isNum = true
    }
    @IBAction func twoTap(_ sender: Any) {
        setWorkings("2")
        isNum = true
    }
    @IBAction func threeTap(_ sender: Any) {
        setWorkings("3")
        isNum = true
    }
    @IBAction func fourTap(_ sender: Any) {
        setWorkings("4")
        isNum = true
    }
    
    @IBAction func fiveTap(_ sender: Any) {
        setWorkings("5")
        isNum = true
    }
    @IBAction func sixTap(_ sender: Any) {
        setWorkings("6")
        isNum = true
    }
    @IBAction func sevenTap(_ sender: Any) {
        setWorkings("7")
        isNum = true
    }
    @IBAction func eightTap(_ sender: Any) {
        setWorkings("8")
        isNum = true
    }
    @IBAction func nineTap(_ sender: Any) {
        setWorkings("9")
        isNum = true
    }
    
    @IBAction func dotTap(_ sender: Any) {
        if !hasDot && isNum {
            setWorkings(".")
            hasDot = true
            isNum = false
        }
    }
    
}

extension ViewController {
    enum Symbol: String {
        case plus = "+"
        case minus = "-"
        case divide = "/"
        case multi = "*"
    }
}

