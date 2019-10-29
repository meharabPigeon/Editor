//
//  BottomView_AlbumListView.swift
//  Editor
//
//  Created by Meharab Pigeon on 20/8/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit
import Foundation

class BottomView_AlbumListView: UIView {
    
    
    //MARK: Properties
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var downArrowButton: UIButton!
    
    
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
        Bundle.main.loadNibNamed("BottomView_AlbumListView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
