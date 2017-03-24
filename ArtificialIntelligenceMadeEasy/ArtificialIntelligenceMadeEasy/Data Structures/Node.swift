//
//  Node.swift
//  ArtificialIntelligenceSwift
//
//  Created by user on 3/22/17.
//  Copyright © 2017 someCompanyNameHere. All rights reserved.
//

import UIKit

class Node {

    var contents:String
    var children = [Node]()

    init(contents:String) {
        self.contents = contents
    }

}
