//
//  ApplicationContext.swift
//  MapProgress
//
//  Created by James Robinson on 26/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class ApplicationContext {

    let routeDeserializer = RouteDeserializer();
    let routeManager = RouteManager()
    let documentsDir: String;
    var error: NSError?;
    
    init() {
        let fileManager = NSFileManager.defaultManager()
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray;
        documentsDir = paths.firstObject as! String;
        let enumerator: NSDirectoryEnumerator = fileManager.enumeratorAtPath(documentsDir)!
        while let element = enumerator.nextObject() as? String {
            if element.hasSuffix("json") {
                let routePath = documentsDir.stringByAppendingPathComponent(element)
                routeManager.addRoute(
                    routeDeserializer.deserialize(
                        NSData(contentsOfFile: routePath, options: .DataReadingMappedIfSafe, error: nil)!));
            }
        }
    }

}