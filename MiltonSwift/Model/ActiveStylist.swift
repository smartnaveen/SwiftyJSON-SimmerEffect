//
//  StylistModel.swift
//  MiltonSwift
//
//  Created by Mr. Naveen Kumar on 05/06/21.
//

import UIKit
import SwiftyJSON

class ActiveStylist: NSObject {
    
    var status    =    Int()
    var message   =    String()
    var data      =    [ActiveStylistData]()
    
    override init() {
    }
    
    init(obj: JSON) {
        self.status   = obj["status"].intValue
        self.message  = obj["message"].stringValue
        
        if obj["data"].exists() {
            for obj in obj["data"].arrayValue {
                let objData = ActiveStylistData.init(obj: obj)
                self.data.append(objData)
            }
        }
    }
}

class ActiveStylistData: NSObject {
    var id                      = String()
    var online                  = Int()
    var firstname               = String()
    var lastname                = String()
    var middlename              = String()
    var gender                  = String()
    var experience              = String()
    var completedOrderCount     = Int()
    var stylistFavCount         = Int()
    var ratingCount             = Int()
    var avgRating               = Double()
    var profile                 = String()
   
    override init() {
    }
    
    init(obj: JSON) {
        self.id                    =    obj["_id"].stringValue
        self.online                =    obj["online"].intValue
        self.firstname             =    obj["firstname"].stringValue
        self.lastname              =    obj["lastname"].stringValue
        self.middlename            =    obj["middlename"].stringValue
        self.gender                =    obj["gender"].stringValue
        self.experience            =    obj["experience"].stringValue
        self.completedOrderCount   =    obj["completed_order_count"].intValue
        self.stylistFavCount       =    obj["stylist_fav_count"].intValue
        self.ratingCount           =    obj["rating_count"].intValue
        self.avgRating             =    obj["avg_rating"].doubleValue
        self.profile               =    obj["profile"].stringValue
    }
    
    
}
