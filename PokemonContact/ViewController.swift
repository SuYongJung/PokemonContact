//
//  ViewController.swift
//  PokemonContact
//
//  Created by 정수용 on 7/10/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pokemon Contact"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        return addButton
    }()
    
    let tableView = UITableView()
    
    let dataSource: [Contact] = [
        Contact(name: "SuYong Jung", phoneNumber: "010-1111-2222", imageUrl: ""),
        Contact(name: "IlYong Jung", phoneNumber: "010-3333-4444", imageUrl: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(tableView)
        setupUI()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        tableView.dataSource = self
        
        tableView.delegate = self
        
        view.backgroundColor = .white
        
        let goToVC2Button = UIButton(type: .system)
        goToVC2Button.setTitle("Go to VC2", for: .normal)
        goToVC2Button.addTarget(self, action: #selector(goToVC2), for: .touchUpInside)
        
        view.addSubview(goToVC2Button)
        goToVC2Button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goToVC2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToVC2Button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
        
    
    
    private func setupUI() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.top.equalTo(titleLabel).offset(40)
        }
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
