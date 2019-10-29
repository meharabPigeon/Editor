//
//  PhotoViewController.swift
//  Editor
//
//  Created by Meharab Pigeon on 8/8/19.
//  Copyright © 2019 OBHAI Solutions Ltd. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {

    
    //MARK: Properties
    var photoLibraryImages = [UIImage]()
    var photoLibraryAssets = [PHAsset]()
    var photoLibraryAlbums = [String]()
    var photoLibraryAlbumCount = [Int]()
    
    weak var collectionViewGallery: UICollectionView!
    weak var tableViewAlbumList: UITableView!
    
    
    //MARK: Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.setUp_View()
        
        self.get_All_Photos()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
    }
    
    
    func setUp_View()
    {
        self.create_CollectionView_To_Show_Gallery()
        
        DispatchQueue.main.async
        {
            self.create_Top_View()
            self.create_Bottom_View()
        }
    }
    
    
    func create_CollectionView_To_Show_Gallery()
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [
                collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ]
        )
        
        self.collectionViewGallery = collectionView
        self.collectionViewGallery.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Gallery_Cell")
        
        self.collectionViewGallery.delegate = self
        self.collectionViewGallery.dataSource = self
        
        self.collectionViewGallery.allowsMultipleSelection = false
        self.collectionViewGallery.backgroundColor = UIColor.clear
        self.collectionViewGallery.showsVerticalScrollIndicator = false
    }
    
    
    func create_Top_View()
    {
        let customView = TopView_PhotoViewController()
        customView.frame = CGRect(x: 0, y: (UIApplication.shared.keyWindow?.safeAreaInsets.top)! + 10, width: self.view.frame.width, height: 60)
        self.view.addSubview(customView)
        
        
        customView.photoLabel.layer.cornerRadius = 20
        customView.photoLabel.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black, radius: 2.0, opacity: 1.0)
        customView.photoLabel.text = photo_Title_Top_View
        customView.photoLabel.textColor = text_Color_dark
        customView.photoLabel.font = UIFont(name: font_Regular, size: CGFloat(font_Size_Photo_Title_Top_View))
    }
    
    
    func create_Bottom_View()
    {
        let customView = BottomView_PhotoViewController()
        customView.frame = CGRect(x: 0, y: self.view.frame.height - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! - 60, width: self.view.frame.width, height: 60)
        self.view.addSubview(customView)
        
        
        customView.cancel_Button.layer.cornerRadius = 20
        customView.cancel_Button.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black, radius: 2.0, opacity: 1.0)
        customView.cancel_Button.addTarget(self, action: #selector(cancel_Button_Action), for: .touchDown)
        
        
        customView.multiple_Selection_Button.layer.cornerRadius = 20
        customView.multiple_Selection_Button.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black, radius: 2.0, opacity: 1.0)
        
        
        customView.albumTitleButton.layer.cornerRadius = 20
        customView.albumTitleButton.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black, radius: 2.0, opacity: 1.0)
        customView.albumTitleButton.setTitle(album_Title_Bottom_View, for: .normal)
        customView.albumTitleButton.setTitleColor(text_Color_dark, for: .normal)
        customView.albumTitleButton.titleLabel?.font = UIFont(name: font_Regular, size: CGFloat(font_Size_Album_Title_Bottom_View))
        customView.albumTitleButton.addTarget(self, action: #selector(create_View_To_Show_Album_List), for: .touchDown)
    }
    
    
    @objc func cancel_Button_Action()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func create_View_To_Show_Album_List()
    {
        
        DispatchQueue.main.async
        {
            let customView = UIView()
            customView.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.width, height: self.view.frame.height)
            customView.tag = 111
            self.view.addSubview(customView)
            
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black, radius: 2.0, opacity: 1.0)
            customView.addSubview(blurEffectView)
            
            
            self.create_TableView_To_Show_AlbumList(containerView: blurEffectView.contentView)
            
            self.get_All_Albums()
            
            
            UIView.animate(withDuration: 0.15, animations: {
                
                customView.frame = self.view.bounds
                
            }, completion: { (finished: Bool) in
                
                let customView_Bottom = BottomView_AlbumListView()
                customView_Bottom.frame = CGRect(x: 0, y: blurEffectView.frame.height - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! - 60, width: self.view.frame.width, height: 60)
                blurEffectView.contentView.addSubview(customView_Bottom)
                
                
                customView_Bottom.downArrowButton.layer.cornerRadius = 20
                customView_Bottom.downArrowButton.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black, radius: 2.0, opacity: 1.0)
                customView_Bottom.downArrowButton.setTitle("⥥", for: .normal)
                customView_Bottom.downArrowButton.setTitleColor(text_Color_dark, for: .normal)
                customView_Bottom.downArrowButton.titleLabel?.font = UIFont(name: font_Regular, size: CGFloat(font_Size_Album_Title_Bottom_View))
                customView_Bottom.downArrowButton.addTarget(self, action: #selector(self.remove_Blur_View), for: .touchDown)
            })
        }
    }
    
    
    func create_TableView_To_Show_AlbumList(containerView: UIView)
    {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(tableView)
        
        NSLayoutConstraint.activate(
            [
                tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
                tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
                tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -100),
            ]
        )
        
        self.tableViewAlbumList = tableView
        
        let nib = UINib.init(nibName: "CustomCell_Album_TableView", bundle: nil)
        self.tableViewAlbumList.register(nib, forCellReuseIdentifier: "Album_Cell")
        
        self.tableViewAlbumList.dataSource = self
        self.tableViewAlbumList.delegate = self
        
        self.tableViewAlbumList.backgroundColor = UIColor.clear
        self.tableViewAlbumList.tableFooterView = UIView()
    }
    
    
    @objc func remove_Blur_View()
    {
        DispatchQueue.main.async
        {
            for view in self.view.subviews
            {
                if view.tag == 111
                {
                    UIView.animate(withDuration: 0.15, animations: {
                        
                        view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.width, height: self.view.frame.height)
                        
                    }, completion: { (finished: Bool) in
                        
                        view.removeFromSuperview()
                    })
                }
            }
        }
    }
    
    
    func get_All_Photos()
    {
        DispatchQueue.global(qos: .userInteractive).async
        {
            let imgManager = PHImageManager.default()
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            
            if fetchResult.count > 0
            {
                for i in 0..<fetchResult.count
                {
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset , targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: requestOptions, resultHandler:
                        {
                            image, error in
                            
                            if image != nil
                            {
                                self.photoLibraryImages.append(image!)
                                self.photoLibraryAssets.append(fetchResult.object(at: i))
                            }
                    })
                }
            }
            else
            {
                //FIXME: Show alert
            }
            
            DispatchQueue.main.async
            {
                self.collectionViewGallery.reloadData()
            }
        }
    }
    
    
    func get_All_Albums()
    {
        self.photoLibraryAlbums.removeAll()
        self.photoLibraryAlbumCount.removeAll()
        
        
        DispatchQueue.global(qos: .userInteractive).async
        {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
            let customAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            
            [smartAlbums, customAlbums].forEach {
                $0.enumerateObjects { collection, index, stop in
                    
                    let requestOptions = PHImageRequestOptions()
                    requestOptions.isSynchronous = true
                    requestOptions.deliveryMode = .highQualityFormat
                    
                    let photoInAlbum = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                    
                    if let title = collection.localizedTitle
                    {
                        if photoInAlbum.count > 0
                        {
                            print("\n\n \(title) --- count = \(photoInAlbum.count) \n\n")
                            
                            self.photoLibraryAlbums.append(title)
                            self.photoLibraryAlbumCount.append(photoInAlbum.count)
                        }
                    }
                }
            }
            
            DispatchQueue.main.async
            {
                self.tableViewAlbumList.reloadData()
            }
        }
    }
    
    
    func get_Photos_From_Album(albumName: String)
    {
        self.photoLibraryImages.removeAll()
        self.photoLibraryAssets.removeAll()
        
        DispatchQueue.global(qos: .userInteractive).async
        {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
            let customAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            
            [smartAlbums, customAlbums].forEach {
                $0.enumerateObjects { collection, index, stop in
                    
                    let imgManager = PHImageManager.default()
                    
                    let requestOptions = PHImageRequestOptions()
                    requestOptions.isSynchronous = true
                    requestOptions.deliveryMode = .highQualityFormat
                    
                    let photoInAlbum = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                    
                    if let title = collection.localizedTitle
                    {
                        if photoInAlbum.count > 0
                        {
                            print("\n\n \(title) --- count = \(photoInAlbum.count) \n\n")
                        }
                        
                        if title == albumName
                        {
                            if photoInAlbum.count > 0
                            {
                                for i in (0..<photoInAlbum.count).reversed()
                                {
                                    imgManager.requestImage(for: photoInAlbum.object(at: i) as PHAsset , targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: requestOptions, resultHandler: {
                                        image, error in
                                        if image != nil
                                        {
                                            self.photoLibraryImages.append(image!)
                                            self.photoLibraryAssets.append(photoInAlbum.object(at: i))
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            }
            
            DispatchQueue.main.async
            {
                self.collectionViewGallery.reloadData()
                self.collectionViewGallery.setContentOffset(.zero, animated: true)
            }
        }
    }
    
    func requestImageForAsset(asset: PHAsset) -> UIImage?
    {
        var img: UIImage?
        
        let imageManager = PHImageManager.default()
        
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat
        
        imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: requestOption, resultHandler:
            {
                image, error in
                
                if image != nil
                {
                    img = image
                    
                    print("\n size = \(String(describing: image?.size))")
                    
                    if (img?.size.width)! > CGFloat(10000) || (img?.size.height)! > CGFloat(10000)
                    {
                        imageManager.requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFit, options: requestOption, resultHandler:
                            {
                                image, error in
                                if image != nil
                                {
                                    img = image
                                }
                        })
                    }
                }
        })
        
        return img
    }
}


extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.photoLibraryImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Gallery_Cell", for: indexPath)
        
        //imageView
        let imageView = UIImageView()
        imageView.image = self.photoLibraryImages[indexPath.row]
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.addSubview(imageView)
        
        NSLayoutConstraint.activate(
            [
                imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: cell.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            ]
        )
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async
        {
            MediaManager.shared.imageToEdit = self.requestImageForAsset(asset: self.photoLibraryAssets[indexPath.row])
            
            group.leave()
        }
        
        group.notify(queue: .main)
        {
            print("\n done \n")
            
            self.cancel_Button_Action()
            
            NotificationCenter.default.post(name: NSNotification.Name.init("Single_Photo_Edit"), object: nil)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (collectionViewGallery?.frame.width)! / 4 - 5
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 200, left: 5, bottom: 70, right: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 3.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 3.0
    }
    
}


extension PhotoViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.photoLibraryAlbums.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Album_Cell", for: indexPath) as! CustomCell_Album_TableView
        cell.backgroundColor = UIColor.clear
        
        //set the full width of separator
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.albumTitle.text = self.photoLibraryAlbums[indexPath.row]
        cell.albumCount.text = String(self.photoLibraryAlbumCount[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        DispatchQueue.main.async {
            
            cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
            
            UIView.animate(withDuration: 0.30, animations: {
                
                cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
            },completion: { finished in
                
                UIView.animate(withDuration: 0.15, animations: {
                    
                    cell.layer.transform = CATransform3DMakeScale(1,1,1)
                })
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = self.tableViewAlbumList.cellForRow(at: indexPath as IndexPath)
        
        let cellBackgroundView = UIView()
        cellBackgroundView.backgroundColor = UIColor.clear
        cell?.selectedBackgroundView = cellBackgroundView
        
        self.tableViewAlbumList.reloadData()
        
        self.get_Photos_From_Album(albumName: self.photoLibraryAlbums[indexPath.row])
        
        self.remove_Blur_View()
    }
    
}
