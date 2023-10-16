//
//  DetailsVC.swift
//  Raman_iOSTechTest
//
//  Created by Genie Talk on 13/10/23.
//

import UIKit
import SDWebImage

class DetailsVC: BaseVC {
    
    //outlets
    @IBOutlet var lblAltName:UILabel!
    @IBOutlet var lblOrigin:UILabel!
    @IBOutlet var lblTemperament:UILabel!
    @IBOutlet var lblWeight:UILabel!
    @IBOutlet var lblCountryCode:UILabel!
    @IBOutlet var lblLifeSpan:UILabel!
    @IBOutlet var lblDescription:UILabel!
    @IBOutlet var lblHeading:UILabel!
    @IBOutlet var imgView:UIImageView!
    @IBOutlet var lblMoreInfo:UILabel!
    
    // variable
    var detailsStruct = DataListStruct()
    var wikiURL = String()
    var idBread = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isInternetAvailable() {
            // Show a toast message
            self.showToast(message: "No internet connection", deleayTime: 1.5)
        } else {
            // Internet is available, proceed with your actions
            self.getDetails()
        }
       
    }
    
    
    // Add label property
    func addPropertyLbl(){
        let attributedText = NSMutableAttributedString(string: "Click Wikipedia link to get more information")
        attributedText.addAttribute(.link, value: self.wikiURL, range: NSRange(location: 6, length: 14))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 6, length: 14))
        self.lblMoreInfo.isUserInteractionEnabled = true
        self.lblMoreInfo.attributedText = attributedText
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(linkTapped(_:)))
        self.lblMoreInfo.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func linkTapped(_ sender: UITapGestureRecognizer) {
         if let url = URL(string: self.wikiURL) {
             UIApplication.shared.open(url)
         }
     }
  

    // call api for get info
    func getDetails(){
        self.getDataDetails(url: "\(baseDetailsURL)\(idBread)", detailsGetin: { details, ststus in
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                if ststus{
                    if details.breeds?.first?.altNames != ""{
                        self.lblAltName.text = details.breeds?.first?.altNames
                    }
                    else{
                        self.lblAltName.text = details.breeds?.first?.name
                    }
                    self.lblOrigin.text = details.breeds?.first?.origin
                    self.lblTemperament.text = details.breeds?.first?.temperament
                    self.lblWeight.text = "Imperial \(details.breeds?.first?.weight?.imperial ?? "") kg, Metric \(details.breeds?.first?.weight?.metric ?? "") kg"
                    self.lblCountryCode.text = details.breeds?.first?.countryCode
                    self.lblLifeSpan.text = "\(details.breeds?.first?.lifeSpan ?? "") year"
                    self.lblDescription.text = details.breeds?.first?.description
                    self.lblHeading.text = "Name of Bread - \(details.breeds?.first?.name ?? "")"
                    self.wikiURL = details.breeds?.first?.wikipediaURL ?? ""
                    self.addPropertyLbl()
                    if let url = URL(string: details.url ?? ""){
                        self.imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholdr"))
                    }
                }
                else{
                }
            }
            })
        
    }
   
    // btn action
    @IBAction func btnActionBack(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }

 
}
