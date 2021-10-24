//
//  SceneDelegate.swift
//  Day21
//
//  Created by Amal on 18/03/1443 AH.
//

import UIKit

var post = [Post] ()
struct Post: Codable {
    
    let id: Int
    let title: String
    let body: String

}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let p = post[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! tvCell
        cell.label1.text = "\(p.id)"
        cell.label2.text = p.title
        cell.label3.text = p.body
        
        return cell
    }
    

    @IBOutlet weak var TV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TV.delegate = self
        TV.dataSource = self
       
        simpleGetUrlRequest()
    }
    func  simpleGetUrlRequest() {
        let url = URL(string:
                        "https://jsonplaceholder.typicode.com/posts")!
  
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
        guard let data = data else { return }
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        post = posts ?? []
            
            DispatchQueue.main.async {
                self.TV.reloadData()
            }
            
        }

        task.resume()
        
    }
}

