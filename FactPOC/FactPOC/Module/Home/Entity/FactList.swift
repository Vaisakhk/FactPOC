//
//  FactList.swift
//  FactPOC
//
//  Created by User on 2/2/20.
//  Copyright © 2020 VK. All rights reserved.
//

import UIKit

struct FactList: Decodable {
    let title: String?
    let rows: [Fact]?
}
