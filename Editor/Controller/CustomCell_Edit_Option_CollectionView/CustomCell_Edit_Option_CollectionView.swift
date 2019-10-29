//
//  CustomCell_Edit_Option_CollectionView.swift
//  Editor
//
//  Created by Meharab Pigeon on 26/8/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit

class CustomCell_Edit_Option_CollectionView: UICollectionViewCell {
    
    
    //MARK: Properties
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let title: UILabel = {
        let t = UILabel()
        t.textColor = text_Color_White
        t.textAlignment = .center
        t.numberOfLines = 0
        t.font = UIFont(name: font_Regular, size: CGFloat(font_Size_Photo_Edit_View_Option))
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    }()
    
    
    //MARK: Methods
    override init(frame: CGRect)
    {
        super.init(frame: .zero)
        
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate(
            [
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                imageView.heightAnchor.constraint(equalToConstant: 30),
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                title.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                title.heightAnchor.constraint(equalToConstant: 15),
            ]
        )
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
