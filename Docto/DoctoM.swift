//
//  DoctoM.swift
//  Docto
//
//  Created by Venkatesh Bathina on 06/12/18.
//  Copyright © 2018 Venkatesh Bathina. All rights reserved.
//

import Foundation
class DoctoMain: NSObject {
    
    
    var totalSpecialities = [String]()
    var totalSlots = [(time:String,userid:String,isSelected:Bool)]()
    var doctoDetails = [DoctoDetails]()
    
    func setData(data:[String:AnyObject]) {
        if let jsonData = data["doctors"] as? [AnyObject] {
            for i in 0..<jsonData.count {
                let doctorData = DoctoDetails()
                doctorData.setDataIntoModel(data: jsonData[i] as! [String:AnyObject])
                self.doctoDetails.append(doctorData)
            }
        }
    }
    
    //    name: "Dr. Donna Rutherford",
    //    description: "Sakra World Hospital",
    //    photo: "https://image.shutterstock.com/image-vector/happy-woman-icon-image-450w-661665682.jpg",
    //    specialities: [
    //    "Orthopedist",
    //    "Neurologist"
    //    ],
    //    slots: [
    //    {},
    //    {
    //    time: "10-11",
    //    userid: null
    //    },
    //    {
    //    time: "11-12",
    //    userid: null
    //    },
    //    {
    //    time: "2-3",
    //    userid: "Lili Whiteley"
    //    },
    //    {
    //    time: "3-4",
    //    userid: null
    //    }
    //    ]
    //    },
}

class DoctoDetails: DoctoMain {
    var name = ""
    var descript = ""
    var photo = ""
    var specialities = [String]()
    var timeSlots = [(time:String,userid:String,isSelected:Bool)]()
    var userId = ""
    var isSeletced = Bool()
    
    func setDataIntoModel(data:[String:AnyObject]) {
        self.name = data["name"] as? String ?? ""
        self.userId = data["userId"] as? String ?? ""
        self.descript = data["description"] as? String ?? ""
        self.photo = data["photo"] as? String ?? ""
        if let specs = data["specialities"] as? [AnyObject] {
            for i in 0..<specs.count {
                self.specialities.append(specs[i] as! String)
                if self.totalSpecialities.count > 0 {
                    var isAvailable = Bool()
                    for j in 0..<self.totalSpecialities.count {
                        if self.totalSpecialities[j] == self.specialities[i] {
                            isAvailable = true
                            break
                            
                        } else {
                            isAvailable = false
                        }
                    }
                    if isAvailable == false {
                        self.totalSpecialities.append(specs[i] as! String)
                    }
                } else {
                    self.totalSpecialities.append(specs[i] as! String)
                }
            }
        }
        if let slots = data["slots"] as? [AnyObject] {
            for i in 0..<slots.count {
                if let slot = slots[i] as? [String:AnyObject] {
                    self.timeSlots.append((time: slot["time"] as? String ?? "", userid: slot["userid"] as? String ?? "",isSelected:false))
                    if self.totalSlots.count > 0 {
                        var isAvailable = Bool()
                        for j in 0..<self.totalSlots.count {
                            if self.totalSlots[j].time == slot["time"] as? String ?? "" {
                                isAvailable = true
                                break
                                
                            } else {
                                isAvailable = false
                            }
                        }
                        if isAvailable == false {
                            self.totalSlots.append((time: slot["time"] as? String ?? "", userid: slot["userid"] as? String ?? "",isSelected:false))
                        }
                    } else {
                        self.totalSlots.append((time:slot["time"] as? String ?? "", userid: slot["userid"] as? String ?? "",isSelected:false))
                    }
                }
            }
        }
    }
}
