//
//  DataListVC.swift
//  Raman_iOSTechTest
//
//  Created by Genie Talk on 13/10/23.
//

import UIKit
import SDWebImage

class DataListVC: BaseVC {
    //outlets
    @IBOutlet var dataListCV : UICollectionView!
    // varibles and obj
    var dataListStruct = [DataListStruct]()
    var currentPage = 1
    var isLoading = false
    var baseURL = baseListURL
    let bottomRefreshControl = UIRefreshControl()
    let topRefreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // DefineCell
        self.dataListCV.dataSource = self
        self.dataListCV.delegate = self
        topRefreshControl.addTarget(self, action: #selector(topRefreshControlAction(_:)), for: .valueChanged)
        self.dataListCV.refreshControl = topRefreshControl
        self.dataListCV.register(UINib(nibName: dataCellIdentifires, bundle: nil), forCellWithReuseIdentifier: dataCellIdentifires)
        let url = "\(baseListURL)\(10*currentPage)"
        //check internet availability
        if !isInternetAvailable() {
            // Show a toast message
            self.showToast(message: "No internet connection", deleayTime: 1.5)
        } else {
            // Internet is available, proceed with your actions
            self.showActivityIndicator()
            self.getData(url: url)
        }
       
    }
    

       @objc func topRefreshControlAction(_ sender: UIRefreshControl) {
           let url = "\(baseListURL)\(10*currentPage)"
           if !isInternetAvailable() {
               // Show a toast message
               self.showToast(message: "No internet connection", deleayTime: 1.5)
           } else {
               // Internet is available, proceed with your actions
               //self.showActivityIndicator()
               self.getData(url: url)
           }
           // End the refresh animation.
           sender.endRefreshing()
       }
    
    
    // call api for get data
    func getData(url:String){
        self.getDataList(url: url, dataListGetin: { dataList, ststus in
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                if ststus{
                    self.dataListStruct += dataList
                    self.isLoading = false
                    self.currentPage += 1
                    self.dataListCV.reloadData()
                }
                else{
                }
            }
            })
        
    }
    
   
}

// manage uicollection
extension DataListVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataListStruct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dataCellIdentifires, for: indexPath) as! MainDataListCell
        if let url = URL(string: dataListStruct[indexPath.row].url ?? ""){
              cell.imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholdr"))
        }
        if let id = dataListStruct[indexPath.row].id {
            cell.lblID.text = "Bread ID: \(id)"
        }
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: storyboardIdentifires, bundle: nil) // Use your storyboard name
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: detailVCIdentifires) as? DetailsVC {
            if dataListStruct[indexPath.row].breeds?.count ?? 0 > 0{
                destinationVC.idBread = dataListStruct[indexPath.row].id ?? ""
                navigationController?.pushViewController(destinationVC, animated: true)
            }
            else
            {
                self.showToast(message: "No more details available.", deleayTime: 0.4)

            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if !isLoading && offsetY > contentHeight - height {
            // User is near the end, load more data
            let url = "\(baseListURL)\(10*currentPage)"
            if !isInternetAvailable() {
                // Show a toast message
                self.showToast(message: "No internet connection", deleayTime: 0.4)
            } else {
                // Internet is available, proceed with your actions
                self.getData(url: url)
            }
            
        }
    }
    
}
