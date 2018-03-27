//
//  PushCell.swift
//  Mabius
//
//  Created by Timafei Harhun on 03.03.17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import UIKit

protocol PushCellOutput: class {
    func switchValueChanged(newValue: Bool)
}

class PushCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var swtch: UISwitch!
    
    var output: PushCellOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let view = UIView(frame: self.bounds)
        view.backgroundColor = UIColor.cylMainColor().withAlphaComponent(0.3)
        self.selectedBackgroundView = view
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: Switch value changed
    @IBAction func swtchValueChange() {
        output.switchValueChanged(newValue: swtch.isOn)
    }

}
