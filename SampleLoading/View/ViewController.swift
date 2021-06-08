//
//  ViewController.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import UIKit

protocol ViewProtocol: AnyObject {
    #warning("This return function from the presenter to the view controller needs to be called on the main thread!")
    /*@MainActor*/ func didReceiveItems(showCharacters: [ShowCharacter])
}

class ViewController: UIViewController, ViewProtocol {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: PresenterProtocol
    
    init(presenter: PresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        build()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        presenter.viewDidLoad()
    }
    
    // MARK: - ViewProtocol

    func didReceiveItems(showCharacters: [ShowCharacter]) {
        print("-didReceiveItems thread:", Thread.current)
        tableView.reloadData()
    }
    
    // MARK: - View
    
    func build() {
        buildHierarchy()
        buildConstraints()
    }
    
    func buildHierarchy() {
        view.addSubview(tableView)
    }
    
    func buildConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("Error dequeuing cell")
        }
        
        if let item = presenter.itemAt(indexPath.row) {
            cell.populate(item)
        }
        
        return cell
    }
}

