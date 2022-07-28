//
//  Button.swift
//  roadmap_page3
//
//  Created by 이나영 on 2022/07/24.
//

import Foundation
import UIKit

class Pagebtn: UIButton{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.borderWidth = 2
        
    }
}
    
    class Pagebtn2: UIButton{
        required init(coder aDecoder: NSCoder){
            super.init(coder: aDecoder)!
            
            self.layer.borderWidth = 1
        
            
        }
}
