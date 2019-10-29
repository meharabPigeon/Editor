//
//  MediaManager.swift
//  Editor
//
//  Created by Meharab Pigeon on 22/8/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit
import Foundation


class MediaManager {
    
    static let shared = MediaManager()
    
    var imageToEdit: UIImage?
    
    //Initializer access level change now
    private init(){}
    
}
