//
//  APresenter.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import Foundation

@available(iOS 15.0, *)
class APresenter: PresenterProtocol {
    weak var view: ViewProtocol?
    var service: AServiceProtocol
    
    init(service: AServiceProtocol = AService()) {
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
        print("-fetch async/await thread:", Thread.current)

        async {
            print("-fetch async/await thread inside async:", Thread.current)
            
            let characters = try await service.fetchCharacters(page: page)
            
            print("-fetch async/await thread inside async post await:", Thread.current)
            
            self.items.append(contentsOf: characters)
            
            await self.view?.didReceiveItems(showCharacters: characters)
        }
        
        print("-fetch async/await ending:", Thread.current)
    }
}
