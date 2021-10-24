//
//  ViewController.swift
//  Day21
//
//  Created by Abdulaziz on 18/03/1443 AH.
//

import UIKit

struct Post: Codable{
  let id: Int
  let title: String
  let body: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var Aa: Array<Post> = []
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Aa.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let A1 = Aa[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "show from API", for: indexPath) as! ViewCell
    
    cell.idCell.text = "\(A1.id)"
    cell.titleCell.text = A1.title
    cell.bodyCell.text = A1.body
    
    return cell
  }
  
  func P(){
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
    
    if let posts = try? decoder.decode([Post].self, from: json) {
      Aa = posts
      
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
    P()
  }
}

class ViewCell: UITableViewCell {
  
  @IBOutlet weak var idCell: UILabel!
  @IBOutlet weak var titleCell: UILabel!
  @IBOutlet weak var bodyCell: UILabel!
}
