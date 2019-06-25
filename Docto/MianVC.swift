//
//  MianVC.swift
//  Docto
//
//  Created by Venkatesh Bathina on 06/12/18.
//  Copyright © 2018 Venkatesh Bathina. All rights reserved.
//

import UIKit

class MianVC: UIViewController {
    //    @IBOutlet weak var AvailableView: UIView!
    //    @IBOutlet weak var myAppointmentsView: UIView!
    @IBOutlet weak var appointBtn: UIButton!
    var totalData = DoctoMain()
    var filteredData = DoctoMain()
    var isfiltered = Bool()
    // var searchActive = Bool()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.getData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.notifyData(_:)), name: NSNotification.Name.init("slot"), object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func notifyData(_ notification:Notification) {
        if let data = notification.userInfo?["data"] as? DoctoDetails {
            // do something with your image
            for i in 0..<self.totalData.doctoDetails.count {
                if self.totalData.doctoDetails[i].name == data.name {
                    self.totalData.doctoDetails[i] = data
                    break
                } else {
                    
                }
            }
            self.tableView.reloadData()
        }
    }
    func getData() {
        do {
            if let file = Bundle.main.url(forResource: "LocationData", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    //parseJson(json: object)
                    print(object)
                    self.totalData.setData(data: object as [String : AnyObject])
                    if self.totalData.doctoDetails.count > 0 {
                        self.tableView.reloadData()
                    }
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    func BGBackground(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .background).async(execute: block)
    }
    
    func UI(_ block: @escaping ()->Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    @IBAction func availableBtn(_ sender: UIButton) {
        self.isfiltered = false
        self.tableView.reloadData()
    }
    @IBAction func myAppointBtn(_ sender: Any) {
        self.isfiltered = true
        self.filteredData.doctoDetails = self.totalData.doctoDetails.filter({$0.isSeletced})
        self.appointBtn.setTitle("My Appointments (\(self.filteredData.doctoDetails.count))", for: .normal)
        self.tableView.reloadData()
        
    }
    // MARK: Testing github
    func someData() {
        self.isfiltered = true
        self.filteredData.doctoDetails = self.totalData.doctoDetails.filter({$0.isSeletced})
        self.appointBtn.setTitle("My Appointments (\(self.filteredData.doctoDetails.count))", for: .normal)
        self.tableView.reloadData()
    }
    func someMoreData() {
        self.isfiltered = true
        self.filteredData.doctoDetails = self.totalData.doctoDetails.filter({$0.isSeletced})
        self.appointBtn.setTitle("My Appointments (\(self.filteredData.doctoDetails.count))", for: .normal)
        self.tableView.reloadData()
    }
    
}
extension MianVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.isfiltered ? self.filteredData.doctoDetails.count : self.totalData.doctoDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = self.isfiltered ? self.filteredData.doctoDetails[indexPath.row] : self.totalData.doctoDetails[indexPath.row]
        
        print(data)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoctorsCell
        cell.name.text = data.name
        cell.hosp.text = data.descript
        cell.speciality.text = data.specialities[0]
        cell.isFiltered = isfiltered
        cell.setDataIntoModel(slots:data)
        self.BGBackground {
            if let url = NSURL(string: data.photo) {
                if let data = NSData(contentsOf: url as URL) {
                    self.UI {
                        cell.doctorImageview.image = UIImage(data: data as Data)
                    }
                }
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 167
    }
}
