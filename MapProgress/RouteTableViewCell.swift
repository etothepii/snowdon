//
//  RouteTableViewCell.swift
//  
//
//  Created by James Robinson on 12/08/2015.
//
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    @IBOutlet weak var RouteName: UILabel!
    var internalName: String? = nil
    var routeManager: RouteManager?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            routeManager!.setCurrentRoute(internalName!)
        }
    }

}
