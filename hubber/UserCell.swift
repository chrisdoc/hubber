//
//  UserCell.swift
//  Hubber
//
//  Created by Christoph Kieslich on 14/10/2016.
//  Copyright © 2016 Husten. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func bind(_ user: User) {
        if let url = URL(string: user.avatar), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            avatar.image = image
        }
        name.text = user.username
    }
}

extension UserCell: Reusable {}
