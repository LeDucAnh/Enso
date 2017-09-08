//
//  UITableView+Extensions.swift
//  Enso
//
//  Created by Mac on 8/26/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit




extension UITableView {
    func getAllCells(section:Int) -> [UITableViewCell] {
    
    var cells = [UITableViewCell]()
    // assuming tableView is your self.tableView defined somewhere

     
        for j in 0...self.numberOfRows(inSection: section)-1
        {

            
            if let cell = self.cellForRow(at: NSIndexPath(row: j, section: section) as IndexPath) {
                
                cells.append(cell)
            }
            
        }
    
    return cells
}
    func getAllIndex(section:Int) -> [IndexPath] {
        
        var indexes = [IndexPath]()
        // assuming tableView is your self.tableView defined somewhere
        
        
        for j in 0...self.numberOfRows(inSection: section) - 1
        {
            
            
             let index =  IndexPath(row: j, section: section)
            
                
                indexes.append(index)
            
            
        }
        
        return indexes
    }


}
