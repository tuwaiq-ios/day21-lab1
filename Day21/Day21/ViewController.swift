//
//  ViewController.swift
//  Day21
//
//  Created by dmdm on 24/10/2021.
//

import UIKit

var d = [Post] ()

struct Post: Codable{
    let id: Int
    let title: String
    let body: String
    
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return d.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func simpleGetUrlRequest() {

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}
