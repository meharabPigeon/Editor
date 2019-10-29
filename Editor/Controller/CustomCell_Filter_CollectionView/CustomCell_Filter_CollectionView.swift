//
//  CustomCell_Filter_CollectionView.swift
//  Editor
//
//  Created by Meharab Pigeon on 3/9/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit

class CustomCell_Filter_CollectionView: UICollectionViewCell {
    
    
    //MARK: Properties
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let title: UILabel = {
        let t = UILabel()
        t.textAlignment = .center
        t.numberOfLines = 0
        t.font = UIFont(name: font_Light, size: CGFloat(font_Size_Image_Filter_Title))
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    }()
    
    let cellSelectionView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor.clear
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    override var isSelected: Bool {
        willSet{
            super.isSelected = newValue
            if newValue
            {
                self.cellSelectionView.backgroundColor = UIColor.clear
                UIView.animate(withDuration: 0.30)
                {
                    self.cellSelectionView.backgroundColor = UIColor.white
                }
            }
            else
            {
                self.cellSelectionView.backgroundColor = UIColor.white
                UIView.animate(withDuration: 0.30)
                {
                    self.cellSelectionView.backgroundColor = UIColor.clear
                }
            }
        }
    }
    
    
    //MARK: Methods
    override init(frame: CGRect)
    {
        super.init(frame: .zero)
        
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(cellSelectionView)
        
        NSLayoutConstraint.activate(
            [
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 65),
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                title.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                title.heightAnchor.constraint(equalToConstant: 50),
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                cellSelectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                cellSelectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                cellSelectionView.topAnchor.constraint(equalTo: title.bottomAnchor),
                cellSelectionView.heightAnchor.constraint(equalToConstant: 3),
            ]
        )
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
