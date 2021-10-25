//
//  ViewController.swift
//  day 21
//
//  Created by Maram Al shahrani on 18/03/1443 AH.
//

import UIKit
var pp = [post] ()
struct post : Codable {
    let id :Int
    let title:String
    let body :String
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let p = pp[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        
        cell.Id.text = "\(p.id)"
        cell.title.text = p.title
        cell.body.text  = p.body
        return cell
        
    }
    
    @IBOutlet weak var TableView1: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView1.dataSource=self
        TableView1.delegate=self
        
        
        simpleGetUrlRequest()
          }
          func simpleGetUrlRequest() {
          let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
              let task=URLSession.shared.dataTask(with: url) {(data,respone,error) in
                  guard let data = data else {return}
                  let posts = try? JSONDecoder().decode([post].self, from:data)
                  pp = posts ?? []
                  DispatchQueue.main.async {
                      self.TableView1.reloadData()
                  }
              }
              task.resume()
    }

}

        
        
       
    
    





class  Cell:UITableViewCell{
    
    
    @IBOutlet weak var Id: UILabel!
    
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var body: UILabel!
    
}

