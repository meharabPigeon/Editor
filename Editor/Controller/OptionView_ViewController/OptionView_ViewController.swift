//
//  OptionView_ViewController.swift
//  Editor
//
//  Created by Meharab Pigeon on 7/8/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit

class OptionView_ViewController: UIView {
    
    
    //MARK: Properties
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var createNewLabel: UILabel!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var video_OptionTitle: UILabel!
    @IBOutlet weak var photo_OptionTitle: UILabel!
    @IBOutlet weak var collage_OptionTitle: UILabel!
    
    @IBOutlet weak var video_Option_Button: UIButton!
    @IBOutlet weak var photo_Option_Button: UIButton!
    @IBOutlet weak var collage_Option_Button: UIButton!
    
    
    //MARK: Methods
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit()
    {
        Bundle.main.loadNibNamed("OptionView_ViewController", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
