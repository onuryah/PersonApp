//
//  PersonCell.swift
//  PersonApp
//
//  Created by Macbook on 7.04.2023.
//

import UIKit

class PersonCell: UITableViewCell {
    @IBOutlet weak var personLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLabel(person: Person) {
        personLabel.text = person.description
    }
}
