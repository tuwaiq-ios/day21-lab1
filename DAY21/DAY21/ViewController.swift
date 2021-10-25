//
//  ViewController.swift
//  DAY21
//
//  Created by Hassan Yahya on 18/03/1443 AH.
//

import UIKit


var x: Array<Post> = []

struct Post: Codable{
    let id: Int
    let title: String
    let body: String
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return x.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = x[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath
                                                 
        ) as! ViewCell
        
        cell.idL.text = "\(post.id)"
        cell.bodyL.text = post.body
        cell.titleL.text = post.title
        
        return cell
    }
    
    
    @IBOutlet weak var postTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTV.delegate = self
        postTV.dataSource = self
        ABI()
    }
    
    
    
    func ABI() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            x = posts ?? []
            
            DispatchQueue.main.async {
                self.postTV.reloadData()
            }
        }
        
        task.resume()
    }
}

class ViewCell: UITableViewCell{
    
    @IBOutlet weak var idL: UILabel!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var bodyL: UILabel!
}




