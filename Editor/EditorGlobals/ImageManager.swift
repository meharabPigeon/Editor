//
//  ImageManager.swift
//  Editor
//
//  Created by Meharab Pigeon on 1/9/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit
import Foundation


class ImageManager {
    
    static let shared = ImageManager()
    
    let editOptionImages = [
        "canvas",
        "filter",
        "background",
        "sticker",
        "text",
        "crop",
        "rotate"
    ]
    
    let canvasImages = [
        "1-1-1",
        "1-1-1",
        "2-2-3",
        "3-3-2",
        "4-3-4",
        "5-4-3",
        "6-Facebook-Landscape-Post-4-3",
        "7-Facebook-Portrait-Post-2-3",
        "8-Facebook-Page-Cover-Desktop-2.6-1",
        "9-Facebook-Page-Cover-Mobile-2-1",
        "10-Facebook-Profile-Cover-2.7-1",
        "11-Facebook-Event-Cover-1.9-1",
        "12-Instagram-Portrait-Post-4-5",
        "13-Instagram-Landscape-Post-1.9-1",
        "14-Twitter-Post-Landscape-16-9",
        "15-Twitter-Header-3-1",
        "16-Pinterest-Pin-2-3",
        "17-LinkedIn-Post-1.4-1",
        "18-LinkedIn-Background-2-1",
        "19-Youtube-Video-Thumbnail-16-9",
        "20-Youtube-Channel-Cover-1.8-1",
        "21-Wattpad-Cover-2-3",
        "22-Etsy-Cover-4-1",
        "23-Eventbrite-Cover-Image-2-1"
    ]
    
    func imageWithIndex(imageArray: [String], index: Int) -> UIImage?
    {
        return UIImage(named: imageArray[index])
    }
    
}
