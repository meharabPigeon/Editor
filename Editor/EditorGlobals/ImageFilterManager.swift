//
//  ImageFilterManager.swift
//  Editor
//
//  Created by Meharab Pigeon on 8/9/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit
import Foundation


class ImageFilterManager {
    
    static let shared = ImageFilterManager()
    
    let filterList = [
        [
            "Original"
        ],
        [
            "CIPhotoEffectChrome",
            "CIPhotoEffectFade",
            "CIPhotoEffectTransfer",
            "CIVignetteEffect",
            "CISRGBToneCurveToLinear",
            "CILinearToSRGBToneCurve",
            "CICrystallize",
            "CIPointillize",
            "CIColorPosterize",
            "CIColorInvert",
            "CILineOverlay"
        ],
        [
            "CIPhotoEffectInstant",
            "CIPhotoEffectProcess",
            "CISepiaTone",
            "CIFalseColor",
            "CIColorMonochrome"
        ],
        [
            "CIPhotoEffectNoir",
            "CIPhotoEffectMono",
            "CIPhotoEffectTonal",
            "CIMaskToAlpha",
            "CIMaximumComponent",
            "CIMinimumComponent"
        ],
        [
            "CIBoxBlur",
            "CIDiscBlur",
            "CIMotionBlur",
            "CIZoomBlur",
            "CIGaussianBlur"
        ]
    ]
    
    let filterTitle = [
        [
            filter_Original
        ],
        [
            filter_Chrome,
            filter_Fade,
            filter_Transfer,
            filter_Vignette,
            filter_CurveLinear,
            filter_ToneCurve,
            filter_Crystallize,
            filter_Pointillize,
            filter_Posterize,
            filter_Invert,
            filter_Overlay
        ],
        [
            filter_Instant,
            filter_Process,
            filter_Tone,
            filter_Color,
            filter_MonoChrome
        ],
        [
            filter_Noir,
            filter_Mono,
            filter_Tonal,
            filter_Alpha,
            filter_Maxima,
            filter_Minima
        ],
        [
            filter_BoxBlur,
            filter_DiscBlur,
            filter_MotionBlur,
            filter_ZoomBlur,
            filter_GaussianBlur
        ]
    ]
    
    let filterTitleColor = [
        [
            text_Color_White
        ],
        [
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects,
            text_Color_Filter_Normal_Effects
        ],
        [
            text_Color_Orange,
            text_Color_Orange,
            text_Color_Orange,
            text_Color_Orange,
            text_Color_Orange
        ],
        [
            text_Color_Gray,
            text_Color_Gray,
            text_Color_Gray,
            text_Color_Gray,
            text_Color_Gray,
            text_Color_Gray
        ],
        [
            text_Color_Over_Blur_View,
            text_Color_Over_Blur_View,
            text_Color_Over_Blur_View,
            text_Color_Over_Blur_View,
            text_Color_Over_Blur_View
        ]
    ]
    
}
