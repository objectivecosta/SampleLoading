//
//  CharacterTableViewCell.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    private var currentCharacter: ShowCharacter? = nil
    
    private var headshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = nil
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        build()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(_ showCharacter: ShowCharacter) {
        currentCharacter = showCharacter
        characterNameLabel.text = showCharacter.name
        
        DispatchQueue(label: "background", qos: .background).async { [weak self] in
            guard let self = self else {
                return
            }
            
            guard let url = URL(string: showCharacter.image) else {
                return
            }
            
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            
            guard let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                if self.currentCharacter?.image == showCharacter.image {
                    self.headshotImageView.image = image
                }
            }
            
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentCharacter = nil
        characterNameLabel.text = nil
        headshotImageView.image = nil
    }
    
    // MARK: - Build
    
    func build() {
        buildHierarchy()
        buildConstraints()
    }
    
    func buildHierarchy() {
        contentView.addSubview(headshotImageView)
        contentView.addSubview(characterNameLabel)
    }
    
    func buildConstraints() {
        let hA = headshotImageView.heightAnchor.constraint(equalToConstant: 64.0)
        hA.priority = UILayoutPriority.init(rawValue: 999.0)
        hA.isActive = true
        
        headshotImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        
        headshotImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0).isActive = true
        
        headshotImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0).isActive = true
        
        headshotImageView.widthAnchor.constraint(equalTo: headshotImageView.heightAnchor, constant: 0.0).isActive = true
        
        characterNameLabel.leadingAnchor.constraint(equalTo: headshotImageView.trailingAnchor, constant: 16.0).isActive = true
        
        characterNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 16.0).isActive = true
        
        characterNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0).isActive = true
    }
}

