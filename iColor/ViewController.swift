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
    var numOfTilesPerRow:Int!
    var numOfTiles:Int!
    var correctTileIndex:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        randomNumOfTilesPerRow()
        createTiles()
        setCorrectTile()
    }
    
    func randomNumOfTilesPerRow() {
        numOfTilesPerRow = Int(arc4random_uniform(6)) + 4
        numOfTiles = numOfTilesPerRow * numOfTilesPerRow
        correctTileIndex = Int(arc4random_uniform(UInt32(numOfTiles-1)) + 1)
    }
    
    func createTiles() {
        tilesView.layoutIfNeeded()
        tilesView.layer.cornerRadius = 5
        tilesView.backgroundColor = UIColor.whiteColor()
        let widthTile = tilesView.frame.size.width / CGFloat(numOfTilesPerRow)
        var currentTile = -1
        for y in 0..<numOfTilesPerRow {
            let yOriginTile = widthTile * CGFloat(y)
            for i in 0..<numOfTilesPerRow {
                currentTile += 1
                let xOriginTile = widthTile * CGFloat(i)
                let button = UIButton(type: .Custom)
                button.frame = CGRectMake(xOriginTile, yOriginTile, widthTile, widthTile)
                button.backgroundColor = UIColor(netHex: 0xF6416C)
                button.tag = currentTile
                button.layer.cornerRadius = 5
                button.layer.borderWidth = 0.5
                button.layer.borderColor = UIColor.whiteColor().CGColor
                if currentTile != correctTileIndex {
                    button.addTarget(self, action: #selector(ViewController.buttonTapped(_:)), forControlEvents: .TouchUpInside)
                }
                self.tilesView.addSubview(button)
            }
        }
    }
    
    func setCorrectTile() {
        if let button = self.tilesView.viewWithTag(correctTileIndex) as! UIButton? {
            button.backgroundColor = UIColor.redColor()
            button.addTarget(self, action: #selector(ViewController.correctButtonTapped(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func clearOldTiles() {
        
    }
    
    func buttonTapped(sender:UIButton) {
        print("Button tapped")
    }
    
    func correctButtonTapped(sender:UIButton) {
        print("Correct Button Tapped")
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

