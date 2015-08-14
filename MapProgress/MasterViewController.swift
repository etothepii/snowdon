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
    let numberFormatter = NSNumberFormatter()
    let twoDPNumberFormatter = NSNumberFormatter()
    
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
        numberFormatter.maximumFractionDigits = 0
        twoDPNumberFormatter.minimumFractionDigits = 2
        twoDPNumberFormatter.minimumIntegerDigits = 1
        twoDPNumberFormatter.maximumFractionDigits = 2
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
        graph.plotAreaFrame.paddingTop = 5
        graph.plotAreaFrame.paddingRight = 5
        graph.plotAreaFrame.paddingBottom = 37
        graph.plotAreaFrame.paddingLeft = 48
        graph.paddingTop = 0
        graph.paddingRight = 0
        graph.paddingBottom = 0
        graph.paddingLeft = 0
        // Axes
        var axes = graph.axisSet as! CPTXYAxisSet
        var lineStyle = CPTMutableLineStyle()
        var textStyle = CPTMutableTextStyle()
        lineStyle.lineWidth = 2
        textStyle.color = CPTColor.blackColor()
        axes.xAxis.labelingPolicy = CPTAxisLabelingPolicy.FixedInterval
        axes.xAxis.labelFormatter = numberFormatter
        axes.xAxis.axisLineStyle = lineStyle
        axes.xAxis.majorIntervalLength = NSNumber(double: 5).decimalValue
        axes.xAxis.minorTicksPerInterval = UInt(4)
        axes.xAxis.majorTickLineStyle = lineStyle
        axes.xAxis.majorTickLength = 5.0
        axes.xAxis.minorTickLineStyle = lineStyle
        axes.xAxis.minorTickLength = 2.0
        axes.xAxis.labelTextStyle = textStyle;
        axes.xAxis.labelFormatter = numberFormatter
        axes.xAxis.titleOffset = 17.0
        axes.yAxis.labelingPolicy = CPTAxisLabelingPolicy.FixedInterval
        axes.yAxis.labelFormatter = numberFormatter
        axes.yAxis.axisLineStyle = lineStyle
        axes.yAxis.majorIntervalLength = NSNumber(double: 200.0).decimalValue
        axes.yAxis.minorTicksPerInterval = UInt(1)
        axes.yAxis.majorTickLineStyle = lineStyle
        axes.yAxis.majorTickLength = 5.0
        axes.yAxis.minorTickLineStyle = lineStyle
        axes.yAxis.minorTickLength = 2.0
        axes.yAxis.labelTextStyle = textStyle;
        axes.yAxis.titleOffset = 33.0
        updateRoute(appDelegate.applicationContext.routeManager.getCurrentRoute())
        axes.xAxis.orthogonalCoordinateDecimal = NSNumber(double: routeCalculator.getMinAltitude()).decimalValue
        self.graphView.hostedGraph = graph
        self.navigationController?.hidesBarsOnTap = true
        updateAxesTitles()
    }
    
    func getProgressString(current: Double, total: Double) -> String {
        return numberFormatter.stringFromNumber(NSNumber(double: 100 * current / total))! + "%, " + twoDPNumberFormatter.stringFromNumber(current)! + " / " + twoDPNumberFormatter.stringFromNumber(total)!
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
        super.viewWillDisappear(animated)
    }
    
    func updateAxesTitles() {
        var axes = graph.axisSet as! CPTXYAxisSet
        
        axes.yAxis.title = "Altitude (" + getProgressString(routeCalculator.getCurrentCummulativeAltitude(), total: routeCalculator.getTotalAltitude()) + ")"
        axes.xAxis.title = "Distance (" + getProgressString(routeCalculator.getCurrentDistance(), total: routeCalculator.getTotalDistance()) + ")"
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        let latLon = WGS84(latitude: locValue.latitude, longitude: locValue.longitude)
        let osGrid = latLon.toOSGrid()
        routeCalculator.setLocation(osGrid)
        updateAxesTitles()
        graph.reloadData()
        self.graphView.setNeedsDisplay()
    }

    private func updateRoute(route: Route) {
        routeCalculator.setRoute(route)
        self.navigationItem.title = route.getName()
        plotSpace!.scaleToFitPlots(lines)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }


}

