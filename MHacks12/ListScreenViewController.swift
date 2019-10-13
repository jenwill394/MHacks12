//
//  ListScreenViewController.swift
//  MHacks12
//
//  Created by Andreea Serban on 10/12/19.
//  Copyright © 2019 Jennifer Williams. All rights reserved.
//

import UIKit

class ListScreenViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
    var items: [Item] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = createArray()
        TableView.delegate = self
        TableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func createArray() -> [Item]{
        
        var tempitems: [Item] = []
        
        let item1 = Item(title: "Banana")
        let item2 = Item(title: "Apple")
        let item3 = Item(title: "La Croix")
        
        tempitems.append(item1)
        tempitems.append(item2)
        tempitems.append(item3)
        
        return tempitems
    }
}

extension ListScreenViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        
        cell.setItem(item: item)
        
        return cell
    }
}
