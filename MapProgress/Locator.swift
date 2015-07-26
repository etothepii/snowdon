//
//  Locator.swift
//  MapProgress
//
//  Created by James Robinson on 20/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

protocol Locator {
    func getCurrentLocation() -> OSGrid
}