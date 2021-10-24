//
//  ViewController.swift
//  day21
//
//  Created by Tsnim Alqahtani on 18/03/1443 AH.
//

import UIKit
var pp = [Post] ()

struct Post: Codable {
let id: Int
let title:String
let body: String
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let p = pp[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CELL
        cell.idCell.text = "\(p.id)"
        cell.titleCell.text = p.title
        cell.bodyCell.text = p.body
        return cell
    }
    
    @IBOutlet weak var tableVC: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVC.delegate = self
        tableVC.dataSource = self
        
        simpleGetUrlRequest()
    }
    func simpleGetUrlRequest() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else { return }
        let posts = try? JSONDecoder().decode([Post].self, from:data)
            pp = posts ?? []
            
            DispatchQueue.main.async {
                self.tableVC.reloadData()
            }
        }
        task.resume()
}
}
class CELL: UITableViewCell{
    @IBOutlet weak var idCell: UILabel!
    
    @IBOutlet weak var titleCell: UILabel!
    
    @IBOutlet weak var bodyCell: UILabel!
}
