//
//  ViewController.swift
//  PokemonContact
//
//  Created by 정수용 on 7/10/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    let tableView = UITableView()
    
    let dataSource: [Contact] = [
        Contact(name: "SuYong Jung", phoneNumber: "010-1111-2222", imageUrl: ""),
        Contact(name: "IlYong Jung", phoneNumber: "010-3333-4444", imageUrl: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        tableView.dataSource = self
        
        tableView.delegate = self
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(goToVC2))
        navigationItem.title = "Pokemon Contact"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id)
        
        if let cell = cell as? TableViewCell {
            cell.nameLabel.text = dataSource[indexPath.row].name
            cell.phoneNumberLabel.text = dataSource[indexPath.row].phoneNumber
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    @objc func goToVC2() {
        let vc2 = PhoneBookViewController()
        navigationController?.pushViewController(vc2, animated: true)
    }
    
}


