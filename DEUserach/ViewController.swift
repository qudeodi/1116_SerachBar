//
//  ViewController.swift
//  DEUserach
//
//  Created by D7703_08 on 2017. 11. 16..
//  Copyright © 2017년 D7703_08. All rights reserved.
//
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
//  [강좌] 아이폰 앱개발
//  [학번] 2011 11185
//  [이름] 강민석
//
//  [위치]
//  08PC 데스크탑 > 2011 11185 > DEUserach
//                              > DEUserach.xcodeproj
//
//  [GitHub repository]
//  name : 1116_SerachBar
//  addr : https://github.com/qudeodi/1116_SerachBar.git
//  stat :
//
// [내용]
//  1. stroyboard -> Constraints
//  2. 코드로 SearchBar 구현
//  3. IndexFilter
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    @IBOutlet weak var tableV: UITableView!

    let arrayA = ["ac","ag","be","db","ne","db","cd","ba","df","ef"]
    var twiceDic: [String:[String]]!
    var twiceNames: [String]!
    var fillteredArray = [String]()
    
    var searchCon: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pathA = Bundle.main.path(forResource: "Twice", ofType: "json")
        let dataA = try! Data(contentsOf: URL(fileURLWithPath: pathA!))
        self.twiceDic = try! JSONSerialization.jsonObject(with: dataA, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:[String]]
        self.twiceNames = Array(twiceDic.keys)
        
        self.searchCon = UISearchController(searchResultsController: nil)
        self.searchCon.searchResultsUpdater = self
        self.searchCon.dimsBackgroundDuringPresentation = false
        self.searchCon.searchBar.sizeToFit()
        self.tableV.tableHeaderView = self.searchCon.searchBar
        
        self.tableV.register(UITableViewCell.self, forCellReuseIdentifier: "Reuse")
        
        tableV.dataSource = self
        tableV.delegate = self

    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.twiceNames
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.twiceNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchCon.isActive {
            return fillteredArray.count
        } else {
            //return self.twiceNames.count
            let memberName = self.twiceNames[section]
            let specArr = self.twiceDic[memberName]
            return specArr!.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.twiceNames[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse", for: indexPath)
        
        if self.searchCon.isActive {
            cell.textLabel?.text = fillteredArray[indexPath.row]
        } else {
            let memberName = self.twiceNames[indexPath.section]
            let specArr = self.twiceDic[memberName]
            
            cell.textLabel?.text = specArr![indexPath.row]
        }
        
        //cell.textLabel?.text = arrayA[indexPath.row]
        
        //cell.textLabel?.text = self.searchCon.isActive ? fillteredArray[indexPath.row] : self.twiceNames[indexPath.row]
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //print(searchController.searchBar.text!)
        fillteredArray.removeAll(keepingCapacity: false)
        let predicateA = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let arrayF = (arrayA as NSArray).filtered(using: predicateA)
        fillteredArray = arrayF as! [String]
        self.tableV.reloadData()
        
    }
    
}




