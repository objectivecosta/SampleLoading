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
        async {
            await fetch()
        }
    }
    
    func fetchMore() {
        async {
            await fetch(page: currentPage + 1)
        }
    }
    
    @MainActor private func fetch(page: Int = 1) async {
        print("-fetch async/await thread:", Thread.current)

        print("-fetch async/await thread inside async:", Thread.current)
        
        do {
            let characters = try await service.fetchCharacters(page: page)
            
            print("-fetch async/await thread inside async post await:", Thread.current)
            
            self.items.append(contentsOf: characters)
            
            self.view?.didReceiveItems(showCharacters: characters)
        } catch {
            print("-fetch async/await error:", error)
        }
        
        print("-fetch async/await ending:", Thread.current)
    }
}
