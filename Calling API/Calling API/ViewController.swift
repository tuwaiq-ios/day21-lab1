//
//  ViewController.swift
//  Calling API
//
//  Created by MacBook on 18/03/1443 AH.
//

import UIKit

var xy = [Post]()

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    
}

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let po = xy[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.idCell.text = "\(po.id)"
        cell.titlecell.text = po.title
        cell.bodycell.text = po.body
        
        return cell
        
        
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    
    func simpleGetUrlRequest()
    {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            xy = posts ?? []
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        simpleGetUrlRequest()
    }
}
class Cell: UITableViewCell {
    
    @IBOutlet weak var idCell: UILabel!
    @IBOutlet weak var titlecell: UILabel!
    @IBOutlet weak var bodycell: UILabel!
}


