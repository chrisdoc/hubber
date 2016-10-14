//
//  RepositoryCell.swift
//  Hubber
//
//  Created by Christoph Kieslich on 14/10/2016.
//  Copyright © 2016 Husten. All rights reserved.
//

import UIKit
class RepositoryCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var starCounter: UILabel!
    
    func bind(_ repository: Repository) {
        name.text = repository.name
        descriptionText.text = repository.description
        starCounter.text = String(repository.starCount)
    }
}

extension RepositoryCell: Reusable {}
