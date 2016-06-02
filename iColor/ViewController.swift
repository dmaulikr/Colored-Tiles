//
//  ViewController.swift
//  iColor
//
//  Created by Tran Le Phu on 5/25/16.
//  Copyright © 2016 LePhuTran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tilesView: UIView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var cirularIndicatorVIew: ProgressView!
    @IBOutlet weak var soundBtn: UIButton!
    
    
    var timer:NSTimer!
    
    var numOfTilesPerRow:Int!
    var numOfTiles:Int!
    var correctTileIndex:Int!
    var score:Int = 0
    var red:Int!
    var green:Int!
    var blue:Int!
    var adjust:Int = 15
    var seconds:Int = 60
    
    var didTunrOffSound:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        createTimer()
        randomNumOfTilesPerRow()
        createTiles()
        setCorrectTile()
        
        let menu = MenuView(frame: CGRectMake(0,0,250,250))
        menu.center = self.view.center
        menu.contentMode = .ScaleAspectFit
        self.view.addSubview(menu)
    }
    
    func createTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.setCounter), userInfo: nil, repeats: true)
    }
    
    func setCounter() {
        if seconds > 0 {
            seconds -= 1
            let progress = Float(60 - seconds)/60
            cirularIndicatorVIew.animateProgressViewToProgress(progress)
            cirularIndicatorVIew.updateProgressViewLabelWithProgress(seconds)
        } else {
            timer.invalidate()
            cirularIndicatorVIew.hideProgressView()
        }
    }
    
    func randomNumOfTilesPerRow() {
        switch score {
        case 0:
            numOfTilesPerRow = 2
        case 1:
            numOfTilesPerRow = 3
        case 2:
            numOfTilesPerRow = 4
        case 3...5:
            numOfTilesPerRow = 5
        case 6...9:
            numOfTilesPerRow = 6
        case 10...13:
            numOfTilesPerRow = 7
        case 14...17:
            numOfTilesPerRow = 8
        default:
            numOfTilesPerRow = 9
        }
        setAdjustValue(score)
        numOfTiles = numOfTilesPerRow * numOfTilesPerRow
        correctTileIndex = Int(arc4random_uniform(UInt32(numOfTiles-1)) + 1)
    }
    
    func createColor() {
        red = Int(arc4random_uniform(255))
        blue = Int(arc4random_uniform(255))
        green = Int(arc4random_uniform(255))
        if red < 100 && blue < 100 && green > 100 {
            createColor()
        }
        if red > 180 && green > 180 && blue > 180 {
            createColor()
        }
        print(red)
        print(green)
        print(blue)
    }
    
    func createTiles() {
        tilesView.layoutIfNeeded()
        tilesView.backgroundColor = UIColor.whiteColor()
        let widthTile = tilesView.frame.size.width / CGFloat(numOfTilesPerRow)
        createColor()
        var currentTile = -1
        for y in 0..<numOfTilesPerRow {
            let yOriginTile = widthTile * CGFloat(y)
            for i in 0..<numOfTilesPerRow {
                currentTile += 1
                let xOriginTile = widthTile * CGFloat(i)
                let button = UIButton(type: .Custom)
                button.frame = CGRectMake(xOriginTile, yOriginTile, widthTile, widthTile)
                let color = UIColor(red: red, green: green, blue: blue)
                button.backgroundColor = color
                button.tag = currentTile
                button.layer.borderWidth = 0.5
                button.layer.borderColor = UIColor.whiteColor().CGColor
                if currentTile != correctTileIndex {
                    button.addTarget(self, action: #selector(ViewController.buttonTapped(_:)), forControlEvents: .TouchUpInside)
                }
                self.tilesView.addSubview(button)
            }
        }
    }
    
    func setAdjustValue(aScore:Int) {
        switch aScore {
        case 0:
            adjust = 45
        case 1:
            adjust = 40
        case 2:
            adjust = 35
        case 3...5:
            adjust = 30
        case 6...9:
            adjust = 25
        case 10...13:
            adjust = 20
        case 14...17:
            adjust = 15
        default:
            adjust = 10
        }

    }
    
    func setCorrectTile() {
        if let button = self.tilesView.viewWithTag(correctTileIndex) as! UIButton? {
            red! += adjust
            if red > 255 {
                red = 255
            }
            green! += adjust
            if green > 255 {
                green = 255
            }
            blue! += adjust
            if blue > 255 {
                blue = 255
            }
            
            let color = UIColor(red: red, green: green, blue: blue)
            button.backgroundColor = color
            button.addTarget(self, action: #selector(ViewController.correctButtonTapped(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    @IBAction func soundBtnDidTapped(sender: AnyObject) {
        if didTunrOffSound == false {
            let image = UIImage(named: "soundoffwhite.png")
            soundBtn.setImage(image, forState: .Normal)
            didTunrOffSound = true
        } else {
            let image = UIImage(named: "soundonwhite.png")
            soundBtn.setImage(image, forState: .Normal)
            didTunrOffSound = false
        }
    }
    func buttonTapped(sender:UIButton) {
        print("Button tapped")
    }
    
    func correctButtonTapped(sender:UIButton) {
        print("Correct Button Tapped")
        score += 1
        let scoreStr = String(score)
        scoreLbl.text = scoreStr
        self.tilesView.subviews.forEach({ $0.removeFromSuperview() })
        self.randomNumOfTilesPerRow()
        self.createTiles()
        self.setCorrectTile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

