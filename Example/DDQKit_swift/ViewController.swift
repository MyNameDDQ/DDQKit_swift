//
//  ViewController.swift
//  DDQKit_swift
//
//  Created by MyNameDDQ on 07/15/2021.
//  Copyright (c) 2021 MyNameDDQ. All rights reserved.
//

import UIKit
import DDQKit_swift

class ViewController: UIViewController {

    private var label: UILabel = .ddqLabel(text: "DDQKit")
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        let arr = [""]
    
        self.view.ddqAddSubViews(subViews: [self.label])
    }

    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.label.ddqMake { (make) in
            make.ddqLeft(property: self.view.ddqMakeLeft, value: 0.0).ddqTop(property: self.view.ddqMakeTop, value: self.ddqSafeInsets.top).ddqSizeToFit()
        }
    }
}

