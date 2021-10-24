//
//  ViewController.swift
//  Day-21
//
//  Created by PC on 18/03/1443 AH.

import UIKit

var arrayPost = [Post]()

struct Post: Codable {
    let id : Int
    let title: String
    let body : String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        JsonUrl()
    }
    
    func JsonUrl() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            
            arrayPost = posts ?? []
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
              
            }
            
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postArr = arrayPost[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostCell
        
        cell.idLbl.text = "\(postArr.id)"
        cell.titleLbl.text = postArr.title
        cell.bodyLbl.text = postArr.body
        cell.backgroundColor = .systemFill
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

class PostCell: UITableViewCell{
    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    
}


