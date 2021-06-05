//
//  ViewController.swift
//  MiltonSwift
//
//  Created by Mr. Naveen Kumar on 05/06/21.
//

import UIKit
import SwiftyJSON
import SDWebImage
import SkeletonView


class ViewController: UIViewController {

    @IBOutlet weak var stylistTableView: UITableView!
    
    var objActiveStylist =  ActiveStylist()
    var isSimmer: Bool   = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.apiHandle()
    }

}

 // MARK:- TableView Method
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSimmer {
            return 5
        }else {
            return objActiveStylist.data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StylistCell", for: indexPath) as? StylistTableViewCell
        
        if isSimmer {
            
            cell?.stylistImageView.showAnimatedGradientSkeleton()
            cell?.stylistNameLabel.showAnimatedGradientSkeleton()
            
        }else {
            cell?.stylistImageView.hideSkeleton()
            cell?.stylistNameLabel.hideSkeleton()
            
            let imageURL = objActiveStylist.data[indexPath.row].profile
            let firstName = objActiveStylist.data[indexPath.row].firstname
            let lastName = objActiveStylist.data[indexPath.row].lastname
            
            cell?.stylistNameLabel.text = "\(firstName ) \(lastName)"
            cell?.stylistImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: nil, completed: nil)
        }
               
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}


 // MARK:- API Declared
extension ViewController {
    
    func apiHandle() {
        let url = "https://busk2ztzsh.execute-api.us-east-1.amazonaws.com/api/customer/show-all-active-stylist"
        var parameter: [String: Any] = [String: Any]()
        parameter["page"]            = 1
        parameter["stylist_level"]   = "advanced"
        self.isSimmer = true
        APIManager.shared.fetchData(urlString: url, dict: parameter, requestType: .post) { (result) in
            let json = JSON(result)
            if json["status"].intValue == 200 {
                print(json["data"])
                for i in json["data"].arrayValue{
                    print(i["firstname"].stringValue)
                }
                self.objActiveStylist = ActiveStylist.init(obj: json)
                self.isSimmer = false
                self.stylistTableView.reloadData()
            }else if json["status"].doubleValue == 401 {
                print(json["message"])
            }
            
        } failure: { (error) in
            print(error)
        }

    }
}
