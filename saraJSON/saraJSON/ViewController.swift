//
//  ViewController.swift
//  saraJSON
//
//  Created by SARA SAUD on 3/18/1443 AH.
//

import UIKit

    var soriarray = [Post]()
    struct Post: Codable {
        let id : Int
        let title : String
        let body : String
    }
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return soriarray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post1 = soriarray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1",for: indexPath) as! soriCell
        cell.idCell.text = "\(post1.id)"
        cell.titleCell.text = post1.title
        cell.bodyCell.text = post1.body
        return cell
    }
    @IBOutlet weak var MyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyTableView.delegate = self
        MyTableView.dataSource = self
        simpleGetUrlRequset()
    }
        func simpleGetUrlRequset(){
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {return}
                print(String(data: data , encoding: .utf8)!)
             let posts = try? JSONDecoder().decode([Post].self, from: data)
                soriarray = posts ?? []

                DispatchQueue.main.async {
                    self.MyTableView.reloadData()
                }}
            task.resume()
        }

}
class soriCell :UITableViewCell{
    
    
    @IBOutlet weak var idCell: UILabel!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var bodyCell: UILabel!
    
}
        

