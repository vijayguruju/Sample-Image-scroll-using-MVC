//
//  ViewController.swift
//  FlickrImage
//
//  Created by Dinesh Sunder on 23/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var photosResponse :PhotoResponse?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var dataList = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getImagesAPI()
        
        searchBar.delegate = self
    }

    
//MARK:- Phots API call
    func getImagesAPI(){
        
        let session = URLSession.shared
        let url = URL(string:"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&%20format=json&nojsoncallback=1&safe_search=1&text=rose&page=1")
        let task = session.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            
            print(response!)
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
                print(json!.keys)
                
                if let photos = json!["photos"] as? [String:Any]{
                    if let photo = photos["photo"] as? [[String:Any]] {
                        print(photo)
                        self.photosResponse = PhotoResponse(photosResponseArray:photo)
                        print(self.photosResponse?.photos.count)
//                        for photo in self.photosResponse!.photos{
//                            self.dataList.append(photo)
//                        }
                        //update tableview using data
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                        }
                    }
                }
            }
            catch{
                print("Error")
            }
        })
        task.resume()
        
    }

}

extension ViewController:UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate{
    
    //MARK:- TableVie methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photosResponse?.photos.count ?? 0
    }
    private func tableView(_ tableView: UITableView, HeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! FlickrImageTableViewCell
        if let photosData = self.photosResponse?.photos{
            let photoDict = photosData[indexPath.row]
            let imgUrl = URL(string:"https://farm\(photoDict.farm).static.flickr.com/\(photoDict.server)/\(photoDict.id)_\(photoDict.secret).jpg")
            
            let data =  try? Data(contentsOf: imgUrl!)
            cell.imageView?.image = UIImage(data: data!)
            cell.textLabel?.numberOfLines = 0
        
            //cell.textLabel?.text = photoDict.title
        }
        return cell
    }
    
    //MARK:- search bar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(searchBar.text)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("end")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         self.view.endEditing(true)
        
            /* let photosArray = self.dataList //photosResponse?.photos{
               
                let requiredAry = photosArray.filter{($0["title"] as! String) == searchBar.text}

                print("Matched array",requiredAry)
                
                if requiredAry.count > 0{
                let reqDict = requiredAry[0]
                
                }
         */
        
        
        }
    
    }
    


