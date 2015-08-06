//
//  MasterViewController.swift
//  MapProgress
//
//  Created by James Robinson on 17/04/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, CPTPlotDataSource {
    
    @IBOutlet var graphView: CPTGraphHostingView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let routeCalculator = RouteCalculator()
    
    var objects = [AnyObject]()
    private var graph = CPTXYGraph(frame: CGRectZero)
    private var data = [CGPoint]()
    private var plotSpace: CPTXYPlotSpace? = nil
    private var lines = [CPTScatterPlot]()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        plotSpace = graph.defaultPlotSpace as? CPTXYPlotSpace
        var lineStyle = CPTMutableLineStyle()
        lineStyle.miterLimit = CGFloat(1)
        lineStyle.lineWidth = CGFloat(3)
        lineStyle.lineColor = CPTColor.blueColor()
        lines.append(CPTScatterPlot(frame: CGRectZero))
        lines[0].dataLineStyle = lineStyle
        lines[0].dataSource = self
        graph.addPlot(lines[0], toPlotSpace: plotSpace!)
        graph.paddingLeft = 5
        graph.paddingTop = 18
        graph.paddingRight = 5
        graph.paddingBottom = 5
        
        updateRoute(appDelegate.applicationContext.routeManager.getCurrentRoute())
        
        self.graphView.hostedGraph = graph
    }
    
    private func updateRoute(route: Route) {
        
        // Axes
        var axes = graph.axisSet as! CPTXYAxisSet
        var lineStyle = CPTMutableLineStyle()
        lineStyle.lineWidth = 2
        axes.xAxis.axisLineStyle = lineStyle
        axes.yAxis.axisLineStyle = lineStyle
        
        let altitude = routeCalculator.getAltitude(route)
        let distance = routeCalculator.getDistance(route)
        data = [CGPoint]()
        for (var i = 0; i < altitude.count; i++) {
            data.append(CGPoint(x: distance[i], y: altitude[i]))
        }
        plotSpace!.scaleToFitPlots(lines)
    }

    func numberOfRecordsForPlot(plot: CPTPlot!) -> UInt {
        return UInt(data.count)
    }
    
    func doubleForPlot(plot: CPTPlot!, field: UInt, recordIndex: UInt) -> Double {
        var datum: CGPoint = data[Int(recordIndex)]
        switch (field) {
            case 0:
                return Double(datum.x)
            default:
                return Double(datum.y)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }


}

