//
//  PhotoEditViewController.swift
//  Editor
//
//  Created by Meharab Pigeon on 22/8/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit

class PhotoEditViewController: UIViewController {
    
    
    //MARK: Properties
    var imageView_Background = UIImageView()
    var imageView_Foreground = UIImageView()
    
    var blurView = UIVisualEffectView(frame: .zero)
    
    var imageView_Foreground_Width = CGFloat()
    var imageView_Foreground_Height = CGFloat()
    
    weak var collectionViewEditOption: UICollectionView!
    var editOptionContainerView = UIView()
    
    var editOptionContainerView_TopAnchor: NSLayoutConstraint?
    var editOptionContainerView_BottomAnchor: NSLayoutConstraint?
    
    weak var collectionViewCanvas: UICollectionView!
    weak var collectionViewFilter: UICollectionView!
    
    var canvasCGSize: NSMutableArray = [
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 43.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 49.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 43.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 52.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 43.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 42.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0),
        CGSize(width: 65.0, height: 105.0)
    ]
    
    typealias Ratio = (x: CGFloat, y: CGFloat)
    
    var ratio: [Ratio] = [
        (x: 0, y: 0),
        (x: 1, y: 1),
        (x: 2, y: 3),
        (x: 3, y: 2),
        (x: 3, y: 4),
        (x: 4, y: 3),
        (x: 4, y: 3),
        (x: 2, y: 3),
        (x: 2.6, y: 1),
        (x: 2, y: 1),
        (x: 2.7, y: 1),
        (x: 1.9, y: 1),
        (x: 4, y: 5),
        (x: 1.91, y: 1),
        (x: 16, y: 9),
        (x: 3, y: 1),
        (x: 2, y: 3),
        (x: 1.4, y: 1),
        (x: 2, y: 1),
        (x: 16, y: 9),
        (x: 1.8, y: 1),
        (x: 16, y: 25),
        (x: 4, y: 1),
        (x: 2, y: 1)
    ]
    
    
    //MARK: Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setUp_View()
        
        //create blur effect for once
        let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
        blurEffect.setValue(5, forKeyPath: "blurRadius")
        self.blurView.effect = blurEffect
        
        self.imageView_Foreground_Width = self.view.frame.width
        self.imageView_Foreground_Height = self.view.frame.width
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }


    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.canvasCGSize.removeAllObjects()
        self.ratio.removeAll()
    }
    
    
    func setUp_View()
    {
        self.view.backgroundColor = background_Color_Edit_View
        
        self.set_Nav_Bar()
        
        guard let image =  MediaManager.shared.imageToEdit  else {
            return
        }
        
        let frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.width)
        
        self.set_Photo_Edit_Container_View(imageToEdit: image, frame: frame, ratioX: 1, ratioY: 1)
        
        self.create_CollectionView_To_Show_Photo_Edit_Option()
    }
    
    
    func set_Nav_Bar()
    {
        self.navigationController!.navigationBar.isTranslucent = false
        
        self.title = nav_Bar_Title_Photo_Edit_VC
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_Bar_Left_Arrow"), style: .plain, target: self, action: #selector(back_Button_Action_Nav_Bar))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_Bar_Share"), style: .plain, target: self, action: #selector(share_Button_Action_Nav_Bar))
    }
    
    
    func set_Photo_Edit_Container_View(imageToEdit: UIImage, frame: CGRect, ratioX: CGFloat, ratioY: CGFloat)
    {
        if ratioX == ratioY
        {
            self.imageView_Background.frame = frame
        }
        else if ratioX > ratioY
        {
            self.imageView_Background.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: (frame.height) * (ratioY/ratioX))
        }
        else
        {
            self.imageView_Background.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: (frame.width) * (ratioX/ratioY), height: frame.height)
        }
        
        
        self.imageView_Background.center.x = self.view.center.x
        self.imageView_Background.image = imageToEdit
        self.imageView_Background.contentMode = .scaleAspectFill
        self.imageView_Background.clipsToBounds = true
        
        self.view.addSubview(self.imageView_Background)
        
        
        self.blurView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: self.imageView_Background.frame.width, height: self.imageView_Background.frame.height))
        
        self.imageView_Background.addSubview(self.blurView)
        
        
        self.imageView_Foreground.frame = CGRect(x: 0, y: 0, width: self.imageView_Background.frame.width, height: self.imageView_Background.frame.height)
        self.imageView_Foreground.image = imageToEdit
        self.imageView_Foreground.contentMode = .scaleAspectFit
        
        self.blurView.contentView.addSubview(self.imageView_Foreground)
        
        
        UIView.animate(withDuration: 0.55, animations: {() -> Void in
            
            self.imageView_Foreground.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.55, animations: {() -> Void in
                
                self.imageView_Foreground.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    
    
    func get_Blur_Image(inputImage: UIImage, filter: String) -> UIImage
    {
        let sourceImage = CIImage(image: inputImage)
        let myFilter = CIFilter(name: filter)
        myFilter?.setDefaults()
        myFilter?.setValue(sourceImage, forKey: kCIInputImageKey)
        let context = CIContext(options: nil)
        let outputCGImage = context.createCGImage(myFilter!.outputImage!, from: myFilter!.outputImage!.extent)
        let blurImage = UIImage(cgImage: outputCGImage!)
        
        return blurImage
    }
    
    
    func show_Nav_Bar()
    {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func hide_Nav_Bar()
    {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @objc func back_Button_Action_Nav_Bar()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func share_Button_Action_Nav_Bar()
    {
        
    }
    

    func create_CollectionView_To_Show_Photo_Edit_Option()
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [
                collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                collectionView.heightAnchor.constraint(equalToConstant: 50),
            ]
        )
        
        self.collectionViewEditOption = collectionView
        self.collectionViewEditOption.register(CustomCell_Edit_Option_CollectionView.self, forCellWithReuseIdentifier: "Edit_Photo_Cell")
        
        self.collectionViewEditOption.delegate = self
        self.collectionViewEditOption.dataSource = self
        
        self.collectionViewEditOption.allowsMultipleSelection = false
        self.collectionViewEditOption.backgroundColor = UIColor.clear
        self.collectionViewEditOption.showsHorizontalScrollIndicator = false
    }
    
    
    func create_Edit_Option_Container_View_For(viewName: String)
    {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async
        {
            //create edit option container
            self.editOptionContainerView.backgroundColor = background_Color_Canvas_View
            self.editOptionContainerView.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(self.editOptionContainerView)
            
            self.editOptionContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            self.editOptionContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            self.editOptionContainerView_TopAnchor = self.editOptionContainerView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
            self.editOptionContainerView_TopAnchor?.isActive = true
            self.editOptionContainerView_BottomAnchor = self.editOptionContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            self.editOptionContainerView_BottomAnchor?.isActive = true
            
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            let frame = CGRect(x: 0, y: (UIApplication.shared.keyWindow?.safeAreaInsets.top)! + 50, width: self.imageView_Foreground_Width, height: self.imageView_Foreground_Height)
            
            self.show_Edit_Option_Container_View_For(viewName: viewName, imageView_Background_Frame: frame)
        }
    }
    
    
    func show_Edit_Option_Container_View_For(viewName: String, imageView_Background_Frame: CGRect)
    {
        UIView.animate(withDuration: 0.30, animations: {
            
            self.imageView_Background.frame = imageView_Background_Frame
            self.imageView_Background.center.x = self.view.center.x
            
            self.editOptionContainerView_TopAnchor?.isActive = false
            self.editOptionContainerView_TopAnchor = self.editOptionContainerView.topAnchor.constraint(equalTo: self.imageView_Background.bottomAnchor, constant: 10)
            self.editOptionContainerView_TopAnchor?.isActive = true
            
            self.view.layoutIfNeeded()
            
        }) { (finished: Bool) in
            
            self.hide_Nav_Bar()
            
            //create check mark in edit option container
            let checkmarkButton = UIButton()
            checkmarkButton.setImage(UIImage(named: "checkmark"), for: .normal)
            checkmarkButton.addTarget(self, action: #selector(self.hide_Edit_Option_Container_View), for: .touchDown)
            checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.editOptionContainerView.addSubview(checkmarkButton)
            
            NSLayoutConstraint.activate(
                [
                    checkmarkButton.topAnchor.constraint(equalTo: self.editOptionContainerView.topAnchor),
                    checkmarkButton.trailingAnchor.constraint(equalTo: self.editOptionContainerView.trailingAnchor),
                    checkmarkButton.widthAnchor.constraint(equalToConstant: 50),
                    checkmarkButton.heightAnchor.constraint(equalToConstant: 50),
                ]
            )
            
            switch viewName {
                
            case edit_Option_Canvas:
                self.create_CollectionView_Canvas()
                
            case edit_Option_Filter:
                self.create_CollectionView_Filter()
                
            default:
                self.create_CollectionView_Canvas()
            }
        }
    }
    
    
    @objc func hide_Edit_Option_Container_View()
    {
        UIView.animate(withDuration: 0.30, animations: {
            
            self.imageView_Background.frame.origin.y = 50
            self.imageView_Background.center.x = self.view.center.x
            
            
            self.editOptionContainerView_TopAnchor?.isActive = false
            self.editOptionContainerView_TopAnchor = self.editOptionContainerView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
            self.editOptionContainerView_TopAnchor?.isActive = true
            
            
            if self.collectionViewCanvas != nil
            {
                self.collectionViewCanvas.alpha = 0
            }
            
            if self.collectionViewFilter != nil
            {
                self.collectionViewFilter.alpha = 0
            }
            
            
            self.view.layoutIfNeeded()
            
        }) { (finished: Bool) in
            
            self.show_Nav_Bar()
            
            DispatchQueue.main.async
                {
                    self.editOptionContainerView.removeFromSuperview()
            }
        }
    }
    
    
    //MARK: Canvas CollectionView
    func create_CollectionView_Canvas()
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.editOptionContainerView.addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [
                collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: 140),
            ]
        )
        
        self.collectionViewCanvas = collectionView
        self.collectionViewCanvas.register(CustomCell_Canvas_CollectionView.self, forCellWithReuseIdentifier: "Canvas_Cell")
        
        self.collectionViewCanvas.delegate = self
        self.collectionViewCanvas.dataSource = self
        
        self.collectionViewCanvas.allowsMultipleSelection = false
        self.collectionViewCanvas.backgroundColor = UIColor.clear
        self.collectionViewCanvas.showsHorizontalScrollIndicator = false
    }
    
    
    //MARK: Filter CollectionView
    func create_CollectionView_Filter()
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.editOptionContainerView.addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [
                collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: 140),
            ]
        )
        
        self.collectionViewFilter = collectionView
        self.collectionViewFilter.register(CustomCell_Filter_CollectionView.self, forCellWithReuseIdentifier: "Filter_Cell")
        
        self.collectionViewFilter.delegate = self
        self.collectionViewFilter.dataSource = self
        
        self.collectionViewFilter.allowsMultipleSelection = false
        self.collectionViewFilter.backgroundColor = UIColor.clear
        self.collectionViewFilter.showsHorizontalScrollIndicator = false
    }
    
}


extension PhotoEditViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        if collectionView == self.collectionViewEditOption
        {
            return 1
        }
        else if collectionView == self.collectionViewCanvas
        {
            return 1
        }
        else
        {
            return ImageFilterManager.shared.filterList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == self.collectionViewEditOption
        {
            return ImageManager.shared.editOptionImages.count
        }
        else if collectionView == self.collectionViewCanvas
        {
            return ImageManager.shared.canvasImages.count
        }
        else
        {
            return ImageFilterManager.shared.filterList[section].count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.collectionViewEditOption
        {
            //edit options
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Edit_Photo_Cell", for: indexPath) as! CustomCell_Edit_Option_CollectionView
            
            cell.imageView.image = ImageManager.shared.imageWithIndex(imageArray: ImageManager.shared.editOptionImages, index: indexPath.row)
            cell.title.text = TitleManager.shared.stringWithIndex(stringArray: TitleManager.shared.editOptionTitles, index: indexPath.row)
            
            return cell
        }
        else if collectionView == self.collectionViewCanvas
        {
            //canvas
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Canvas_Cell", for: indexPath) as! CustomCell_Canvas_CollectionView
            
            cell.imageView.image = ImageManager.shared.imageWithIndex(imageArray: ImageManager.shared.canvasImages, index: indexPath.row)
            cell.title.text = TitleManager.shared.stringWithIndex(stringArray: TitleManager.shared.canvasTitles, index: indexPath.row)
            
            return cell
        }
        else
        {
            //filter
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Filter_Cell", for: indexPath) as! CustomCell_Filter_CollectionView
            
            
            let queue = OperationQueue()
            let op1 = BlockOperation { () -> Void in
                
                let resizedImage = MediaManager.shared.imageToEdit?.resizeImage(targetSize: CGSize(width: 200, height: 200))
                let filteredImage = resizedImage?.addFilterToImage(filterName: ImageFilterManager.shared.filterList[indexPath.section][indexPath.row])
                
                OperationQueue.main.addOperation({ () -> Void in
                    cell.imageView.image = filteredImage
                })
            }
            queue.addOperation(op1);
            
            
            cell.title.text = ImageFilterManager.shared.filterTitle[indexPath.section][indexPath.row]
            cell.title.textColor = ImageFilterManager.shared.filterTitleColor[indexPath.section][indexPath.row]
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.collectionViewEditOption
        {
            
            switch indexPath.row {
                
            case 0:
                //canvas
                self.create_Edit_Option_Container_View_For(viewName: edit_Option_Canvas)
                
            case 1:
                //filter
                self.create_Edit_Option_Container_View_For(viewName: edit_Option_Filter)
                
            default:
                self.create_Edit_Option_Container_View_For(viewName: edit_Option_Canvas)
            }
        }
        else if collectionView == self.collectionViewCanvas
        {
            //canvas
            
            let frame = CGRect(x: 0, y: (UIApplication.shared.keyWindow?.safeAreaInsets.top)! + 50, width: self.view.frame.width, height: self.view.frame.width)
            
            self.set_Photo_Edit_Container_View(imageToEdit: MediaManager.shared.imageToEdit!, frame: frame, ratioX: ratio[indexPath.row].x, ratioY: ratio[indexPath.row].y)
            
            if ratio[indexPath.row].x == ratio[indexPath.row].y
            {
                self.imageView_Foreground_Width = self.view.frame.width
                self.imageView_Foreground_Height = self.view.frame.width
            }
            else if ratio[indexPath.row].x > ratio[indexPath.row].y
            {
                self.imageView_Foreground_Width = self.view.frame.width
                self.imageView_Foreground_Height = self.view.frame.width * (ratio[indexPath.row].y/ratio[indexPath.row].x)
            }
            else
            {
                self.imageView_Foreground_Width = self.view.frame.width * (ratio[indexPath.row].x/ratio[indexPath.row].y)
                self.imageView_Foreground_Height = self.view.frame.width
            }
            
            
            if indexPath.row == 0
            {
                //no frame
                self.imageView_Background.image = nil
            }
        }
        else
        {
            //filter
            let group = DispatchGroup()
            group.enter()
            
            var filteredImage = UIImage()
            
            DispatchQueue.main.async
            {
                filteredImage = MediaManager.shared.imageToEdit!.addFilterToImage(filterName: ImageFilterManager.shared.filterList[indexPath.section][indexPath.row])
                
                group.leave()
            }
            
            group.notify(queue: .main)
            {
                DispatchQueue.main.async
                {
                    UIView.transition(with: self.imageView_Foreground,
                                      duration: 1.0,
                                      options: .transitionCrossDissolve,
                                      animations: { self.imageView_Foreground.image = filteredImage },
                                      completion: nil)
                    self.imageView_Background.image = filteredImage
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == self.collectionViewEditOption
        {
            let width = 70
            let height = 50
            
            return CGSize(width: width, height: height)
        }
        else if collectionView == self.collectionViewCanvas
        {
            return self.canvasCGSize.object(at: indexPath.row) as! CGSize
        }
        else
        {
            if Float((MediaManager.shared.imageToEdit?.size.width)!) > Float((MediaManager.shared.imageToEdit?.size.height)!)
            {
                let width = 115
                let height = 105

                return CGSize(width: width, height: height)
            }
            else if Float((MediaManager.shared.imageToEdit?.size.height)!) > Float((MediaManager.shared.imageToEdit?.size.width)!)
            {
                let width = 60
                let height = 105

                return CGSize(width: width, height: height)
            }
            else
            {
                let width = 105
                let height = 105

                return CGSize(width: width, height: height)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if collectionView == self.collectionViewEditOption
        {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        else if collectionView == self.collectionViewCanvas
        {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        else
        {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        if collectionView == self.collectionViewEditOption
        {
            return 0.0
        }
        else if collectionView == self.collectionViewCanvas
        {
            return 10.0
        }
        else
        {
            return 2.0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        if collectionView == self.collectionViewEditOption
        {
            return 0.0
        }
        else if collectionView == self.collectionViewCanvas
        {
            return 10.0
        }
        else
        {
            return 2.0
        }
    }
    
}

