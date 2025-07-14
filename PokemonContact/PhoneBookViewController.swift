//
//  PhoneBookViewController.swift
//  PokemonContact
//
//  Created by 정수용 on 7/10/25.
//

import UIKit
import SnapKit
import Kingfisher

class PhoneBookViewController: UIViewController {
    
    let appearance = UINavigationBarAppearance()
    
    let randomImageView: UIImageView = {
        let randomImageView = UIImageView()
        randomImageView.contentMode = .scaleAspectFit
        randomImageView.layer.cornerRadius = 75
        randomImageView.layer.borderColor = UIColor.lightGray.cgColor
        randomImageView.layer.borderWidth = 2
//        randomImageView.image = UIImage(named: "피카츄")
        return randomImageView
    }()
    let randomButton: UIButton = {
        let randomButton = UIButton()
        randomButton.setTitle("Add Random Image", for: .normal)
        randomButton.setTitleColor(.lightGray, for: .normal)
        randomButton.addTarget(self, action: #selector(randomImageTapped), for: .touchDown)
        return randomButton
    }()
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Hello, World!"
        return textField
    }()
    let numberTextView: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Hello, World!"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save",
                                                                    style: .plain,
                                                                    target: self,
                                                                    action: #selector(tabBarButtonTapped))
        navigationItem.title = "Phone Book"
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(randomImageView)
        view.addSubview(randomButton)
        view.addSubview(nameTextField)
        view.addSubview(numberTextView)
        
        
        randomImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(150)
        }
        
        randomButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(randomImageView.snp.bottom).offset(10)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(randomButton.snp.bottom).offset(10)
        }
        
        numberTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
        }
    }
    
    @objc func tabBarButtonTapped() {
        print("Tab Bar Button Tapped!")
    }
    
    @objc func printLog() {
        print("Add Button Tapped!")
    }
    
    @objc private func randomImageTapped() {
            
            let randomID = Int.random(in: 1...1000)
            let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
            requestAPI(urlString: urlString) { sprites in
                DispatchQueue.main.async {
                    self.randomImageView.kf.setImage(with: URL(string: sprites.front_default)!)
                }
            }
        }
        
        func requestAPI(urlString: String, completion: @escaping(Sprites) -> Void ) {
            guard let url = URL(string: urlString) else { return }
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in guard let data else { return }
                let decoder = JSONDecoder()
                do {
                    let poketmon = try decoder.decode(PocketmonImageResult.self, from: data)
                    completion(poketmon.sprites)
                } catch {
                    print("JSON Data Error")
                }
            }.resume()
        }
    
}
struct PocketmonImageResult: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
}

struct Sprites: Decodable {
    let front_default: String
}

