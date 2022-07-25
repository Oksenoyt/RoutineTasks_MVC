//
//  TaskTableViewCell.swift
//  RoutineTasks
//
//  Created by Elenka on 24.07.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet var checkDoTaskStackButton: [UIButton]!
    
    @IBOutlet weak var nameTaskLabel: UILabel!
    
    
    private func checkDoTaskView() {
        for checkDoTaskButton in checkDoTaskStackButton {
            checkDoTaskButton.layer.cornerRadius = 16
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        checkDoTaskView()
        backgroundColor = #colorLiteral(red: 0.9536015391, green: 0.9351417422, blue: 0.9531318545, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

