//
//  ViewController.swift
//  Day 21 API Request
//
//  Created by Eth Os on 18/03/1443 AH.
//

import UIKit

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var postTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        postTabelView.delegate = self
        postTabelView.dataSource = self
        getData()
        
    }

  func getData() {
      
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
        guard let data = data else { return }
        
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        postsArray = posts ?? []
        
        DispatchQueue.main.async {
            self.postTabelView.reloadData()
        }
    }

    task.resume()
  }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostCell
        let data = postsArray[indexPath.row]
        
        cell.userIdLabel.text = "\(data.userId)"
        cell.idLabel.text = "\(data.id)"
        cell.titleLabel.text = data.title
        cell.bodyLabel.text = data.body
        
        return cell
    }
    
}

