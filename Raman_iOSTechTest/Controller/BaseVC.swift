//
//  BaseVC.swift
//  Raman_iOSTechTest
//
//  Created by Genie Talk on 13/10/23.
//

import UIKit
import SystemConfiguration


class BaseVC: UIViewController {
    
    // activity indicator obj
    var activityView: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // chek  reachebility
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
    
    // function add show activity indicator
    func showActivityIndicator() {
        activityView?.isHidden = false
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = UIColor(named: "ThemeCLR")
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    // function add remove activity indicator
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.isHidden = true
            activityView?.stopAnimating()
        }
    }
    
    // function  show toast
    func showToast(message: String, deleayTime:Double) {
        let toastView = ToastView(message: message)
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toastView)
        
        // Customize the positioning of the toast view
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        // Animate the toast view
        UIView.animate(withDuration: 0.3, animations: {
            toastView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: deleayTime, animations: {
                toastView.alpha = 0.0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
    }
    
  
}

//manage to call api and parsh data
extension BaseVC {
    
    func getDataList(url:String,dataListGetin: @escaping (_ dataList: [DataListStruct],_ status:Bool) -> Void) {
        var dataListStruct = [DataListStruct]()
       
        AlamofireManager.callAPiGetDataListJson(url: url, OnResultBlock: { (response, status) in
            if status {
                let data = response as? Data
                do {
                    let decoder = JSONDecoder()
                    dataListStruct = try decoder.decode([DataListStruct].self, from: data!)
                   // print(dataListStruct)
                    dataListGetin(dataListStruct, true)
                } catch {
                    print("Error")
                    dataListGetin(dataListStruct, false)
                }
            }
            else{
                
                dataListGetin(dataListStruct, false)
            }
           
            
        })
    }
    
    func getDataDetails(url:String,detailsGetin: @escaping (_ dataList: DetailsDataStruct,_ status:Bool) -> Void) {
        var detailsStruct = DetailsDataStruct()
        AlamofireManager.callAPiGetDataListJson(url: url, OnResultBlock: { (response, status) in
            if status {
                let data = response as? Data
                do {
                    let decoder = JSONDecoder()
                    detailsStruct = try decoder.decode(DetailsDataStruct.self, from: data!)
                   // print(dataListStruct)
                    detailsGetin(detailsStruct, true)
                } catch {
                    print("Error")
                    detailsGetin(detailsStruct, false)
                }
            }
            else{
                
                detailsGetin(detailsStruct, false)
            }
           
            
        })
    }
}
