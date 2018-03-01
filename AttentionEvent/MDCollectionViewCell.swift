//
//  MDCollectionViewCell.swift
//  AttentionEvent
//
//  Created by VuVince on 1/18/18.
//  Copyright © 2018 VuVince. All rights reserved.
//

import UIKit

class MDCollectionViewCell: UICollectionViewCell, MDModelViewProtocol {
    @IBOutlet weak var indexLabel: UILabel!
    
    func setup(with model: MDModelProtocol?) {
        guard let value = model as? MDModel else {
            indexLabel.text = ""
            return
        }
        indexLabel.text = "\(value.index)"
    }
    
}
