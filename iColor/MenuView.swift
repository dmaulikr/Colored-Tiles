//
//  MenuView.swift
//  iColor
//
//  Created by lephu on 6/2/16.
//  Copyright © 2016 LePhuTran. All rights reserved.
//

import UIKit

class MenuView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var menuDetail: UIView!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftBtnImgView: UIImageView!
    @IBOutlet weak var rightBtnImgView: UIImageView!
    
    var view:UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        setupSubViews()
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "MenuView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    private func setupSubViews() {
        self.menuDetail.layer.cornerRadius = 10
        self.menuDetail.layer.borderColor = UIColor.whiteColor().CGColor
        self.menuDetail.layer.borderWidth = 0.2
        
        self.leftView.layer.cornerRadius = 10
        self.leftView.layer.borderColor = UIColor.whiteColor().CGColor
        self.leftView.layer.borderWidth = 0.2
        
        self.rightView.layer.cornerRadius = 10
        self.rightView.layer.borderColor = UIColor.whiteColor().CGColor
        self.rightView.layer.borderWidth = 0.2
        
    }
    
    func setTapGestureToLeftView(tapGesture:UITapGestureRecognizer) {
        self.leftView.addGestureRecognizer(tapGesture)
    }
    
    func setTapGestureToRightView(tapGesture:UITapGestureRecognizer) {
        self.rightView.addGestureRecognizer(tapGesture)
    }
}

protocol MenuViewDelegate:class {
//    func tapForLeftView(sender: UITapGestureRecognizer)
//    func tapForRightView(sender:UITapGestureRecognizer)
    func addTapGestureToLeftView() -> UITapGestureRecognizer
    func addTapGestureToRightView() -> UITapGestureRecognizer
}
