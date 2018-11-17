//
//  QuizTableViewCell.swift
//  Quiz
//
//  Created by g891 DIT UPM on 11/20/18.
//  Cristina López Alonso
//  Julio Langtry Yañez
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameQuestion: UILabel!
    @IBOutlet weak var nameAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
