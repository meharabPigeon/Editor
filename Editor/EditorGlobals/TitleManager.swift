//
//  TitleManager.swift
//  Editor
//
//  Created by Meharab Pigeon on 1/9/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit
import Foundation


class TitleManager {
    
    static let shared = TitleManager()
    
    let editOptionTitles = [
        edit_Option_Canvas,
        edit_Option_Filter,
        edit_Option_Background,
        edit_Option_Sticker,
        edit_Option_Text,
        edit_Option_Crop,
        edit_Option_Rotate
    ]
    
    let canvasTitles = [
        ratio_No_Frame,
        ratio_1_1,
        ratio_2_3,
        ratio_3_2,
        ratio_3_4,
        ratio_4_3,
        ratio_Facebook_Landscape_Post,
        ratio_Facebook_Portrait_Post,
        ratio_Facebook_Page_Cover_Desktop,
        ratio_Facebook_Page_Cover_Mobile,
        ratio_Facebook_Profile_Cover,
        ratio_Facebook_Event_Cover,
        ratio_Instagram_Portrait_Post,
        ratio_Instagram_Landscape_Post,
        ratio_Twitter_Post_Landscape,
        ratio_Twitter_Header,
        ratio_Pinterest_Pin,
        ratio_LinkedIn_Post,
        ratio_LinkedIn_Background,
        ratio_Youtube_Video_Thumbnail,
        ratio_Youtube_Channel_Cover,
        ratio_Wattpad_Cover,
        ratio_Etsy_Cover,
        ratio_Eventbrite_Cover_Image
    ]
    
    func stringWithIndex(stringArray: [String], index: Int) -> String?
    {
        return stringArray[index]
    }
}
