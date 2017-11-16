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
//  name :
//  addr :
//  stat :
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    @IBOutlet weak var tableV: UITableView!

    let arrayA = ["ac","ag","be","db","ne","db","cd","ba","df","ef"]
    var fillteredArray = [String]()
    
    var searchCon: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchCon = UISearchController(searchResultsController: nil)
        self.searchCon.searchResultsUpdater = self
        self.searchCon.dimsBackgroundDuringPresentation = false
        self.searchCon.searchBar.sizeToFit()
        self.tableV.tableHeaderView = self.searchCon.searchBar
        
        self.tableV.register(UITableViewCell.self, forCellReuseIdentifier: "Reuse")
        
        tableV.dataSource = self
        tableV.delegate = self

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchCon.isActive {
            return fillteredArray.count
        } else {
            return arrayA.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse", for: indexPath)
        
        cell.textLabel?.text = arrayA[indexPath.row]
        
        cell.textLabel?.text = self.searchCon.isActive ? fillteredArray[indexPath.row] : arrayA[indexPath.row]
        
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




