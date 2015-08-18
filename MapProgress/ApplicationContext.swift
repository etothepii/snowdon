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
    let dataPath: String;
    let routesPath: String;
    var error: NSError?;
    
    init() {
        let fileManager = NSFileManager.defaultManager()
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray;
        let documentsDir = paths.firstObject as! String;
        dataPath = documentsDir.stringByAppendingPathComponent("MapProgress");
        if (!fileManager.fileExistsAtPath(dataPath)) {
            fileManager.createDirectoryAtPath(dataPath, withIntermediateDirectories: false, attributes: nil, error: &error)
        }
        routesPath = dataPath.stringByAppendingPathComponent("Routes");
        if (!fileManager.fileExistsAtPath(routesPath)) {
            fileManager.createDirectoryAtPath(routesPath, withIntermediateDirectories: false, attributes: nil, error: &error)
        }
        var rockvaleShortLoop = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent("RockvaleShortLoop.json")
        fileManager.copyItemAtPath(rockvaleShortLoop, toPath: routesPath.stringByAppendingPathComponent("default_route.json"), error: nil)
        var culboneLongWalk = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent("culboneLongWalk.json")
        fileManager.copyItemAtPath(culboneLongWalk, toPath: routesPath.stringByAppendingPathComponent("second_route.json"), error: nil)
        var day02 = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent("day01.json")
        fileManager.copyItemAtPath(day02, toPath: routesPath.stringByAppendingPathComponent("fourth_route.json"), error: nil)
        var edgbaston = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent("edgbastonResevoir.json")
        fileManager.copyItemAtPath(edgbaston, toPath: routesPath.stringByAppendingPathComponent("edgbastonResevoir.json"), error: nil)
        let enumerator: NSDirectoryEnumerator = fileManager.enumeratorAtPath(routesPath)!
        while let element = enumerator.nextObject() as? String {
            if element.hasSuffix("json") {
                let routePath = routesPath.stringByAppendingPathComponent(element)
                routeManager.addRoute(
                    routeDeserializer.deserialize(
                        NSData(contentsOfFile: routePath, options: .DataReadingMappedIfSafe, error: nil)!));
            }
        }
    }

}