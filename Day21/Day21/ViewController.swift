//
//  ViewController.swift
//  Day21
//
//  Created by dmdm on 24/10/2021.
//

import UIKit

var d = [Post] ()

struct Post: Codable{
    let id: Int
    let title: String
    let body: String
    
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return d.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let p = d [indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
  
        cell.idLable.text = "\(p.id)"
        cell.titleLable.text = p.title
        cell.bodyLable.text = p.body
        return cell
    }
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        simpleGetUrlRequest()
        
    }
    
    func simpleGetUrlRequest() {

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            print(String(data: data, encoding: .utf8)!)
            d = posts ?? []
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}

class Cell: UITableViewCell{
    
    @IBOutlet weak var idLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var bodyLable: UILabel!
    
}
