//
//  DoctorsCell.swift
//  Docto
//
//  Created by Venkatesh Bathina on 06/12/18.
//  Copyright © 2018 Venkatesh Bathina. All rights reserved.
//

import UIKit

class DoctorsCell: UITableViewCell {
    
    @IBOutlet weak var doctorImageview: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var hosp: UILabel!
    @IBOutlet weak var speciality: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var timeSlots = DoctoDetails()
    var isFiltered = Bool()
    var filterData = DoctoDetails()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setDataIntoModel(slots:DoctoDetails) {
        self.timeSlots = slots
        if isFiltered == true {
            self.filterData.timeSlots = self.timeSlots.timeSlots.filter({$0.isSelected})
        } else {
            
        }
        self.collectionView.reloadData()
    }
    func GithubDataAdded() {
       // self.timeSlots = slots
        if isFiltered == true {
            self.filterData.timeSlots = self.timeSlots.timeSlots.filter({$0.isSelected})
        } else {
            
        }
        self.collectionView.reloadData()
    }
    
    //    func showTwoButtonAlertWithRightAction (title:String,buttonTitleLeft:String,buttonTitleRight:String,message: String,completionHandler:@escaping () -> ()) {
    //        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    //        alert.addAction(UIAlertAction(title: buttonTitleLeft, style: UIAlertAction.Style.default, handler: nil))
    //        alert.addAction(UIAlertAction(title: buttonTitleRight, style: UIAlertAction.Style.default, handler: { action in
    //            completionHandler()
    //        }))
    //        sel
    //    }
    
}
extension DoctorsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered == true {
            return self.filterData.timeSlots.count
        }
        return self.timeSlots.timeSlots.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "time", for: indexPath) as! TimeSlotsCell
        if isFiltered == true {
            cell.backgroundColor = UIColor.lightGray
            cell.timeLbl.text = self.filterData.timeSlots[indexPath.row].time

        } else {
            cell.timeLbl.text = self.timeSlots.timeSlots[indexPath.row].time
            if self.timeSlots.timeSlots[indexPath.row].isSelected == true {
                cell.backgroundColor = UIColor.orange
            } else {
                cell.backgroundColor = UIColor.lightGray
            }
        }
        
        //if self.timeSlots
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFiltered == false {
            if self.timeSlots.timeSlots[indexPath.row].isSelected == true {
                self.timeSlots.timeSlots[indexPath.row].isSelected = false
                self.timeSlots.isSeletced = true
            } else {
                self.timeSlots.timeSlots[indexPath.row].isSelected = true
                self.timeSlots.isSeletced = true
            }
            let imageDataDict:[String: DoctoDetails] = ["data": self.timeSlots]
            NotificationCenter.default.post(name: NSNotification.Name.init("slot"), object: nil, userInfo: imageDataDict)
        }
    }
    
}
