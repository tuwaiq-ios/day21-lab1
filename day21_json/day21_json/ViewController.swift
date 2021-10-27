//
//  ViewController.swift
//  day21_json
//
//  Created by sara al zhrani on 18/03/1443 AH.
//

import UIKit
struct post: Codable {
    
    let userId: Int
      let id: Int
      let title: String
      let body: String
}
var postArray = [post]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleGetUrlRequest()
        tableview.delegate = self
        tableview.dataSource = self
    }

    func simpleGetUrlRequest( ){
        
   
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print("the response is :" ,String(data: data, encoding: .utf8)!)
        
        let posts = try? JSONDecoder().decode([post].self, from: data)
        
        postArray = posts ?? []
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    task.resume()
    
                  }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cell
        
        let data = postArray[indexPath.row]
        
        cell.userId.text = "\(data.userId)"
        
        cell.id.text = "\(data.id)"
        cell.title.text = data.title
        cell.body.text = data.body
        return cell

}

}
