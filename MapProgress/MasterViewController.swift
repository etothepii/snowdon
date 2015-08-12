//
//  MasterViewController.swift
//  MapProgress
//
//  Created by James Robinson on 17/04/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import UIKit
import MapKit

class MasterViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var graphView: CPTGraphHostingView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let routeCalculator = RouteCalculator()
    let locationManager = CLLocationManager()
    
    var objects = [AnyObject]()
    private var graph = CPTXYGraph(frame: CGRectZero)
    private var plotSpace: CPTXYPlotSpace? = nil
    private var lines = [CPTScatterPlot]()
    private var routeDataSource: RouteDataSource? = nil
    private var locationDataSource: LocationDataSource? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func createLineStyle(miterLimit: Int, lineWidth: Int, lineColor: CPTColor) -> CPTMutableLineStyle {
        var lineStyle = CPTMutableLineStyle()
        lineStyle.miterLimit = CGFloat(miterLimit)
        lineStyle.lineWidth = CGFloat(lineWidth)
        lineStyle.lineColor = lineColor
        return lineStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        self.view.backgroundColor = UIColor.whiteColor();
        plotSpace = graph.defaultPlotSpace as? CPTXYPlotSpace
        routeDataSource = RouteDataSource(routeCalculator: routeCalculator)
        locationDataSource = LocationDataSource(routeCalculator: routeCalculator)
        lines.append(CPTScatterPlot(frame: CGRectZero))
        lines[0].dataLineStyle = createLineStyle(1, lineWidth: 3, lineColor: CPTColor.blueColor())
        lines[0].dataSource = routeDataSource
        graph.addPlot(lines[0], toPlotSpace: plotSpace!)
        lines.append(CPTScatterPlot(frame: CGRectZero))
        var locationSymbol = CPTPlotSymbol.ellipsePlotSymbol()
        locationSymbol.fill = CPTFill(color: CPTColor.redColor())
        locationSymbol.size = CGSizeMake(12.0, 12.0)
        lines[1].plotSymbol = locationSymbol
        lines[1].dataSource = locationDataSource
        graph.addPlot(lines[1], toPlotSpace: plotSpace!)
        graph.paddingLeft = 5
        graph.paddingTop = 18
        graph.paddingRight = 5
        graph.paddingBottom = 5
        updateRoute(appDelegate.applicationContext.routeManager.getCurrentRoute())
        self.graphView.hostedGraph = graph
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        let latLon = WGS84(latitude: locValue.latitude, longitude: locValue.longitude)
        let osGrid = latLon.toOSGrid()
        routeCalculator.setLocation(osGrid)
        graph.reloadData()
        self.graphView.setNeedsDisplay()
    }

    private func updateRoute(route: Route) {
        
        // Axes
        var axes = graph.axisSet as! CPTXYAxisSet
        var lineStyle = CPTMutableLineStyle()
        lineStyle.lineWidth = 2
        axes.xAxis.axisLineStyle = lineStyle
        axes.yAxis.axisLineStyle = lineStyle
        routeCalculator.setRoute(route)
        plotSpace!.scaleToFitPlots(lines)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }


}

