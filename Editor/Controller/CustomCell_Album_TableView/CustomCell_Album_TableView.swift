//
//  CustomCell_Album_TableView.swift
//  Editor
//
//  Created by Meharab Pigeon on 21/8/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit

class CustomCell_Album_TableView: UITableViewCell {

    
    //MARK: Properties
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumCount: UILabel!
    
    
    //MARK: Methods
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        albumTitle.textColor = text_Color_Over_Blur_View
        albumCount.textColor = text_Color_Over_Blur_View
        
        albumTitle.font = UIFont(name: font_Regular, size: CGFloat(font_Size_album_Title_TableView))
        albumCount.font = UIFont(name: font_Regular, size: CGFloat(font_Size_album_Title_TableView))
    }

    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
