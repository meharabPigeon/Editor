//
//  ViewController.swift
//  Editor
//
//  Created by Meharab Pigeon on 6/8/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit
import Photos
import LTMorphingLabel
import JTMaterialTransition

class ViewController: UIViewController {
    
    
    //MARK: Properties
    @IBOutlet weak var appTitle_Label: LTMorphingLabel!
    @IBOutlet weak var appSubTitle_Label: LTMorphingLabel!
    
    weak var photoButton_presentControllerButton: UIButton?
    var photoButton_transition: JTMaterialTransition?
    
    
    //MARK: Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.set_App_Title_And_Subtitle()
        
        self.create_Option_View()
        
        //MARK: Observer
        NotificationCenter.default.addObserver(self, selector: #selector(open_Photo_Edit_View_Controller), name: NSNotification.Name(rawValue: "Single_Photo_Edit"), object: nil)
    }

    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func set_App_Title_And_Subtitle()
    {
        appTitle_Label.delegate = self
        appSubTitle_Label.delegate = self
        
        
        appTitle_Label.text = app_Title
        appSubTitle_Label.text = app_Sub_Title
        
        
        appTitle_Label.morphingDuration = 1.0
        appSubTitle_Label.morphingDuration = 1.0
        
        
        appTitle_Label.morphingEffect = .scale
        appSubTitle_Label.morphingEffect = .scale
        
        
        appTitle_Label.textColor = text_Color_dark
        appSubTitle_Label.textColor = text_Color_dark
        
        
        appTitle_Label.font = UIFont(name: font_Bold, size: CGFloat(font_Size_App_Title))
        appSubTitle_Label.font = UIFont(name: font_Light, size: CGFloat(font_Size_App_Sub_Title))
    }
    
    
    func create_Option_View()
    {
        let customView = OptionView_ViewController()
        customView.frame = CGRect(x: 15, y: 0, width: self.view.frame.width - 30, height: 180)
        customView.center = self.view.center
    
        
        customView.createNewLabel.text = create_New_Label
        customView.createNewLabel.textColor = text_Color_dark
        customView.createNewLabel.font = UIFont(name: font_Regular, size: CGFloat(font_Size_Create_New_Label))
        
        
        customView.subView.layer.cornerRadius = 20
        customView.subView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        customView.subView.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black, radius: 2.0, opacity: 1.0)
        
        
        //video
        customView.video_OptionTitle.text = video_Option_Title
        customView.video_OptionTitle.textColor = text_Color_dark
        customView.video_OptionTitle.font = UIFont(name: font_Light, size: CGFloat(font_Size_Option_Title))
        
        
        //photo
        customView.photo_OptionTitle.text = photo_Option_Title
        customView.photo_OptionTitle.textColor = text_Color_dark
        customView.photo_OptionTitle.font = UIFont(name: font_Light, size: CGFloat(font_Size_Option_Title))
        
        customView.photo_Option_Button.addTarget(self, action: #selector(photo_Option_Button_Action), for: .touchDown)
        
        photoButton_presentControllerButton = customView.photo_Option_Button
        
        
        //collage
        customView.collage_OptionTitle.text = collage_Option_Title
        customView.collage_OptionTitle.textColor = text_Color_dark
        customView.collage_OptionTitle.font = UIFont(name: font_Light, size: CGFloat(font_Size_Option_Title))
        
        self.view.addSubview(customView)
    }
    
    
    @objc func photo_Option_Button_Action()
    {
        switch PHPhotoLibrary.authorizationStatus() {
            
        case .authorized:
            self.open_Photo_View_Controller()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized
                {
                    self.open_Photo_View_Controller()
                }
                else
                {
                    //FIXME: Show alert
                }
            })
        case .restricted:
            //FIXME: Show alert
            print("")
        case .denied:
            //FIXME: Show alert
            print("")
            
        @unknown default:
            //FIXME: Show alert
            print("")
        }
    }
    
    
    func open_Photo_View_Controller()
    {
        self.photoButton_transition = JTMaterialTransition(animatedView: self.photoButton_presentControllerButton!)
        
        let controller = PhotoViewController()
        
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self.photoButton_transition
        
        self.present(controller, animated: true, completion: nil)
    }
    
    
    @objc func open_Photo_Edit_View_Controller()
    {
        DispatchQueue.main.async
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoEditVC") as? PhotoEditViewController
            {
                if let navigator = self.navigationController
                {
                    navigator.pushViewController(vc, animated: true)
                }
            }
        }
    }

}


extension ViewController: LTMorphingLabelDelegate
{
    
    func morphingDidStart(_ label: LTMorphingLabel)
    {
        
    }
    
    
    func morphingDidComplete(_ label: LTMorphingLabel)
    {
        
    }
    
    
    func morphingOnProgress(_ label: LTMorphingLabel, progress: Float)
    {
        
    }
    
}
