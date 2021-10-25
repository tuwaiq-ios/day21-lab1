//
//  ViewController.swift
//  day 21
//
//  Created by alanood on 18/03/1443 AH.
//

import UIKit


struct post: Codable {
    let userId: Int
    let id: Int
    let title: String
    
}

var postI = [post]()

class ViewController: UIViewController, UITableViewDelegate,
                      UITableViewDataSource {
    
    
    @IBOutlet weak var tableVC: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVC.delegate = self
        tableVC.dataSource = self
        simpleGetUrlRequest()
    }
    
    
    func simpleGetUrlRequest(){
        let url = URL(string:"https://jsonplaceholder.typicode.com/posts")!
        let task = URLSession.shared.dataTask(with: url){
            (data, response,error) in
            guard let data = data else { return }
            print("The response is :", String(data: data, encoding: .utf8)!)
            let posts = try? JSONDecoder().decode([post].self, from: data)
            postI = posts ?? []
            
            DispatchQueue.main.async {
                self.tableVC.reloadData()
            }
        }
        
        task.resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let postM = postI[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)as! Cell
        
        cell.userId.text = "\(postM.userId)"
        cell.id.text = "\(postM.id)"
        cell.title.text = postM.title
        
        return cell
    }
    
    
    
    
    
    
}

class Cell: UITableViewCell {
    
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    
}
