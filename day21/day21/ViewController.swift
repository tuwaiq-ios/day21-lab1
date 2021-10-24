//
//  ViewController.swift
//  day21
//
//  Created by Macbook on 18/03/1443 AH.
//

import UIKit

struct Posts : Codable{
    let userId : Int
    let id : Int
    let title : String
    let body : String
}

var aa : Array<Posts> = []

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let TV = UITableView()
        TV.dataSource = self
        TV.delegate = self
        TV.register(Cell.self, forCellReuseIdentifier: "cell")
        TV.backgroundColor = .white
        TV.rowHeight = 270
        TV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(TV)
        
        
        
        NSLayoutConstraint.activate([TV.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     TV.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     TV.topAnchor.constraint(equalTo: view.topAnchor),
                                     TV.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                    ])
        
        lis()
        
        func lis() {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            
            
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                let post = try? JSONDecoder().decode([Posts].self, from: data)
                aa = post ?? []
                
                DispatchQueue.main.async {
                    TV.reloadData()
                }
            }
            
            task.resume()
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aa.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = aa[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        cell.usid.text = "user id:  \(list.userId)"
        cell.idc.text = "id:  \(list.id)"
        cell.titlec.text = "Title:  \(list.title)"
        cell.bodyc.text = "Body:  \(list.body)"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            aa.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
}


class Cell: UITableViewCell {
    
    let usid = UILabel()
    let idc = UILabel()
    let titlec = UILabel()
    let bodyc = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        
        
        idc.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(idc)
        NSLayoutConstraint.activate([idc.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
                                     idc.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                                     idc.heightAnchor.constraint(equalToConstant: 40),
                                     idc.widthAnchor.constraint(equalToConstant: 120)])
        
        bodyc.numberOfLines = 6
        bodyc.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bodyc)
        NSLayoutConstraint.activate([bodyc.topAnchor.constraint(equalTo: topAnchor,constant: 90),
                                     bodyc.leftAnchor.constraint(equalTo: bodyc.leftAnchor , constant: 40),
                                     bodyc.heightAnchor.constraint(equalToConstant: 200),
                                     bodyc.widthAnchor.constraint(equalToConstant: 400)])
        
        
        
        usid.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(usid)
        NSLayoutConstraint.activate([usid.topAnchor.constraint(equalTo: topAnchor,constant: 40),
                                     usid.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
                                     usid.heightAnchor.constraint(equalToConstant: 40),
                                     usid.widthAnchor.constraint(equalToConstant: 120)])
        
        
        titlec.numberOfLines = 2
        titlec.textColor = .blue
        titlec.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titlec)
        NSLayoutConstraint.activate(
            [titlec.topAnchor.constraint(equalTo: topAnchor,constant: 80),
             titlec.leftAnchor.constraint(equalTo: titlec.leftAnchor , constant: 40),
             titlec.widthAnchor.constraint(equalToConstant: 400)
            ])
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}


