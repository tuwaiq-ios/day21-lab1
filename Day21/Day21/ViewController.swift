//
//  ViewController.swift
//  Day21
//
//  Created by  m Al-qhtani on 24/10/2021.
//

import UIKit

struct Post: Codable{
    let id: Int
    let title: String
    let body: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts: Array<Post> = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let xx = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "show", for: indexPath) as! ViewCell
        
        cell.idCell.text = "\(xx.id)"
        cell.titleCell.text = xx.title
        cell.bodyCell.text = xx.body
        
        return cell
    }
    
    func simpleGetUrIRequst(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            
            self.parse(json: data)
        }
        task.resume()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let poost = try? decoder.decode([Post].self, from: json) {
            posts = poost
            
            DispatchQueue.main.async {
                self.TV.reloadData()
            }
        }
    }
    
    @IBOutlet weak var TV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TV.delegate = self
        TV.dataSource = self
        simpleGetUrIRequst()
    }
}

class ViewCell: UITableViewCell {
    
    @IBOutlet weak var idCell: UILabel!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var bodyCell: UILabel!
}
