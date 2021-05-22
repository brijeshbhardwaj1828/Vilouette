//
//  HomeViewController.swift
//  EcomApp
//
//  Created by MDR SOFTECH on 20/05/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import SideMenu

class HomeViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    var custId = String()
    var itemList = [String]()
    var imgList = [Any]()
    let IMGurl = "http://vilouette.krewtechnologies.com/uploads/product_image/img1.png"

//    let parameters = [
//        "customerID": "1"
//        ]
        let url = "http://vilouette.krewtechnologies.com/account/Api/dashboardInfo"
    override func viewDidLoad() {
        super.viewDidLoad()

        productList()
        
        
        
    }
    
    @IBAction func sideMenuPressed(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenu
    }
    
    
    //MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1     //return number of sections in collection view
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count   //return number of rows in section
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell
            //configureCell(cell: cell, forItemAtIndexPath: indexPath as NSIndexPath) as? CollectionCell
       // cell?.imgProduct.kf.setImage(with: url[indexpath.row])
        //cell?.imgProduct.kf.setImage(with: imgList[indexPath.row]) as? [[String]]
       // let url1 = imgList[indexPath.row]
        
//        let names = imgList
//        for name in names {
//            print("Hello, \(name)!")
//
          // cell!.imgProduct.kf.setImage(with: URL(string: imgList[indexPath.row]))
//
//        }
       //cell!.imgProduct.kf.setImage(with: URL(string: IMGurl))
        
//        if imgList.count > 0 {
//                if let urlString = imgList.last { // I intuit that the url you want is the last one you appended
//
//                    let url = URL(string: urlString as! String)
//                    cell?.imgProduct.kf.setImage(with: url)
//
////                if let image = imageView.image {
////                  imgArray.append(image) // Only append if the image was set conrrectly
////                }
//            }
//        }
        return cell!
    }

//    func configureCell(cell: UICollectionViewCell, forItemAtIndexPath: NSIndexPath) {
//        cell.backgroundColor = UIColor.clear
//        let url = URL(string: "https://example.com/image.png")
//        cell.imgProduct.kf.setImage(with: url)
//
//    }

    func productList(){
        
        let parameters = [
            "customerID": custId
            ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON { [self]
                    response in
                    switch (response.result) {
                    case .success(let value):
                       // print(response)
                        
                        let json = JSON(value)
                      //  print(json)
                        if let itemList = json["suggestion_list"].arrayObject{
                            print("////////")
                            //print(itemList)
                            let arrayNames =  json["suggestion_list"].arrayValue.map {$0["productName"].stringValue}
                            
//                            let imgArray = json["suggestion_list"].arrayValue.map {$0["imagelist"].arrayValue.map {$0["image_name"].string}}
                            
                            let imgArray = json["suggestion_list"].arrayValue.map {$0["imagelist"].arrayValue.map {$0["image_url"].string}}
                            
//                            if let s = imgArray.first["image_name"] as? String {
//                                // When we get here, we know "ID" is a valid key
//                                // and that the value is a String.
//                            }
                       // var list =    imgArray.joined(separator: ", ")
                            print(imgArray)
                            self.itemList = arrayNames
                            self.imgList = imgArray as [Any]
                            self.collectionView.reloadData()
                        }
                    
                       
                        break
                    case .failure:
                        print(Error.self)
                    }
                }
    }
}
