//
//  PresenterProtocol.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import Foundation

protocol PresenterProtocol {
    var itemCount: Int { get }
    
    func itemAt(_ index: Int) -> ShowCharacter?
    
    func viewDidLoad()
    func fetchMore()
}
