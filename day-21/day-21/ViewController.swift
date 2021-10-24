//
//  ViewController.swift
//  day-21
//
//  Created by  HANAN ASIRI on 18/03/1443 AH.
//

import UIKit

var postArray = [post]()

struct post: Codable {
    let id: Int
    let title: String
    let body: String
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        let P = postArray[indexPath.row]
       
        Cell.id.text = "\(P.id)"
        Cell.body.text = P.body
        Cell.title.text = P.title
        
        return Cell
    }
    
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        simpleGetUrlRequest()
   
    }
        func simpleGetUrlRequest() {
        
   let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print(String(data: data, encoding: .utf8)!)
        let posts = try? JSONDecoder().decode([post].self, from: data)
          postArray = posts ?? []
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    task.resume()

}
}

