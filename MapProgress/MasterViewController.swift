//
//  MasterViewController.swift
//  MapProgress
//
//  Created by James Robinson on 17/04/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet var graphView: CPTGraphHostingView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    var objects = [AnyObject]()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        var graph = CPTXYGraph(frame: CGRectZero)
        
        graph.paddingLeft = 5
        graph.paddingTop = 5
        graph.paddingRight = 5
        graph.paddingBottom = 5
        // Axes
        var axes = graph.axisSet as! CPTXYAxisSet
        var lineStyle = CPTMutableLineStyle()
        lineStyle.lineWidth = 2
        axes.xAxis.axisLineStyle = lineStyle
        axes.yAxis.axisLineStyle = lineStyle
        
        self.graphView.hostedGraph = graph
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }


}

