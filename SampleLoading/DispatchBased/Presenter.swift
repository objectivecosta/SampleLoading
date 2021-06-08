//
//  Presenter.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import Foundation

class Presenter: PresenterProtocol {
    weak var view: ViewProtocol?
    var service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    private var items: [ShowCharacter] = []
    private var currentPage: Int = 1
    
    var itemCount: Int {
        return items.count
    }
    
    func itemAt(_ index: Int) -> ShowCharacter? {
        return items[index]
    }
    
    func viewDidLoad() {
        fetch()
    }
    
    func fetchMore() {
        fetch(page: currentPage + 1)
    }
    
    private func fetch(page: Int = 1) {
        service.fetchCharacters(page: page) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let characters):
                self.items.append(contentsOf: characters)
                self.view?.didReceiveItems(showCharacters: characters)
                
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        }
    }
}
