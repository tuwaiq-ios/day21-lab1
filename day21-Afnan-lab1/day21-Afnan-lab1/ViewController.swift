//
//  ViewController.swift
//  day21-Afnan-lab1
//
//  Created by Fno Khalid on 18/03/1443 AH.
//

import UIKit


struct post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
}

var postsArray = [post]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = postsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
     
        cell.userId.text = "\(data.userId)"
        cell.id.text = "\(data.id)"
        cell.title.text = data.title
        cell.body.text = data.body
        
        return cell
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        simpleGetUrlRequest()
    }

    func simpleGetUrlRequest( ) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts" )!

        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
           let posts = try? JSONDecoder().decode([post].self, from: data)
           
            
            postsArray = posts ?? []
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        task.resume()
    }

}

