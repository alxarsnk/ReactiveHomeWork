//
//  ListTableViewCell.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 13.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var firstProperty: UILabel!
    @IBOutlet weak var secondProperty: UILabel!
    @IBOutlet weak var thirdProperty: UILabel!
    @IBOutlet weak var fourthProperty: UILabel!
    
    func configureCell(with model: CellViewModel) {
        
        firstProperty.text = model.firstProperty
        firstProperty.font = UIFont.boldSystemFont(ofSize: 17.0)
        secondProperty.text = model.secondProperty
        thirdProperty.text = model.thirdProperty
        fourthProperty.text = model.fourthProperty
    }
}
