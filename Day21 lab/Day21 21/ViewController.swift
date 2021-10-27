//
//  ViewController.swift
//  Day21
//
//  Created by Ahmed Assiri on 18/03/1443 AH.
//


import UIKit


var x: Array<AA> = []

struct AA: Codable{
  let id: Int
  let title: String
  let body: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
 
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return x.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let xx = x[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "123", for: indexPath) as! Cell
    
    cell.AA.text = "\(xx.id)"
    cell.BB.text = xx.title
    cell.CC.text = xx.body
    
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
    
    if let task = try? decoder.decode([AA].self, from: json) {
      x = task
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
      tableView.delegate = self
      tableView.dataSource = self
    simpleGetUrIRequst()
  }
}

class Cell: UITableViewCell {
  
  @IBOutlet weak var AA: UILabel!
    
  @IBOutlet weak var BB: UILabel!
    
  @IBOutlet weak var CC: UILabel!
}


