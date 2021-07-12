//
//  NibbedVC.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

protocol NibbedVC: AnyObject {
    
    /// This will get a view controller from a nib, if a nib in main bundle exist that has exactly the same name as the class of the view controller.
    static func instantiateFromNib() -> Self
}

extension NibbedVC where Self: UIViewController {
    static func instantiateFromNib() -> Self {
        
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after it, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        
        let vc = Self.init(nibName: className, bundle: Bundle.main)

        return vc
    }
}
