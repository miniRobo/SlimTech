//
//  ViewController.swift
//  SlimTech
//
//  Created by Dawsen Richins on 2/13/17.
//  Copyright © 2017 Droplet. All rights reserved.
//

import UIKit
import JBChart

class ViewController: UIViewController, JBBarChartViewDelegate, JBBarChartViewDataSource, JBLineChartViewDataSource, JBLineChartViewDelegate {
    
    @IBOutlet weak var barChart: JBBarChartView!
    @IBOutlet weak var switchButton: UIButton!
    
    @IBOutlet weak var lineChart: JBLineChartView!
    
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    
    @IBOutlet weak var batteryUse: UILabel!
    @IBOutlet weak var screenTime: UILabel!
    @IBOutlet weak var mainApplication: UILabel!
    
    
    //TEST DATA
    
    //for background testing
    @IBOutlet weak var counterLabel: UILabel!
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var countNum = 1
    //end testing
    
    //var chartData = [0.5,1.5,3.5,4.0,4.1,7.7,9.9,10,11,11,11,11,11,11,11,12.5,13,13.2,13.3,15,15.1,15.1,15.1,17.9]
    //var chartLegend = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    var chartData = [1,2,3,7,9,9.5,10.3,18]
    var chartLegend = [1,2,3,4,5,6,7,8]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
<<<<<<< Updated upstream
        //for background testing
        //this function monitor if the app moved to the background state
        NotificationCenter.default.addObserver(self, selector: #selector(detectBackground), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        //end testing
=======
        //bottom view of application setup
        //sets label variables to default values
        batteryUse.isHidden = true
        screenTime.isHidden = true
        mainApplication.isHidden = true
        
>>>>>>> Stashed changes
        
     //creation for the barChart and LineChart views
        
        
        barChart.backgroundColor = UIColor.gray
        barChart.delegate = self
        barChart.dataSource = self
        barChart.minimumValue = 0
        barChart.maximumValue = CGFloat(chartData.max()!)
        
        lineChart.isHidden = true
        lineChart.backgroundColor = UIColor.gray
        lineChart.delegate = self
        lineChart.dataSource = self
        lineChart.minimumValue = 0
        lineChart.maximumValue = CGFloat(chartData.max()!)
        
        barChart.reloadData()
        lineChart.reloadData()
        
        informationLabel.textColor = UIColor.clear
        informationLabel.text = " "
        
        barChart.setState(.collapsed, animated: false)
        lineChart.setState(.collapsed, animated: false)
        
        //mathematical work around for the y and x axis labels
        //TODO: fix resizing issue
        var xString = " "
        var yString = ""
        
        for xValues in chartLegend {
            xString += "   \(xValues)    "
        }
        xLabel.text = xString
        
        var max: Double = Double(chartData.max()!)
        var increment = (Double(max)/9.0).rounded()
        var i = 9
        max = 8 * increment
        
        while(i>0){
            if(i==9){
                yString += "\(Int(max))\n\n"
                max = max-increment
            } else if(i==1){
                yString += "0"
            } else{
                yString += "\(Int(max))\n\n"
                max = max - increment
            }
            
            i-=1
        }
        yLabel.text = yString
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        //adds labels to the graph at the moment of appearance on the screen
        
        let footer = UILabel(frame: CGRect(x: 0, y: barChart.frame.height + 3, width: barChart.frame.width, height: 20))
        
        
        
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: barChart.frame.width, height: 25))
        header.textColor = UIColor.black
        header.font = UIFont.systemFont(ofSize: 24)
        header.text = "Phone Usage"
        informationLabel.textColor = UIColor.white
        header.textAlignment = NSTextAlignment.center
        
        
        //barChart.footerView = footer
        barChart.headerView = header
       

    }
    
    
    
    @IBAction func switchButtonPressed(_ sender: Any) {
        //allows for the switching between views of line graph and bar graph
        
        if(barChart.isHidden == true){
            
            barChart.isHidden = false
            lineChart.isHidden = true
            
            barChart.footerView = lineChart.footerView
            barChart.headerView = lineChart.headerView
        }
        else{
            
            barChart.isHidden = true
            lineChart.isHidden = false
            
            lineChart.footerView = barChart.footerView
            lineChart.headerView = barChart.headerView
            
        }
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //reloads data of the graph every time a switch between the graphs is made
        barChart.reloadData()
        lineChart.reloadData()
        
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        //gets rid of the graph view with an animation every time new view is presented
        super.viewDidDisappear(animated)
        hideChart()
        
    }

    func hideChart(){
        barChart.setState(.collapsed, animated: true)
        lineChart.setState(.collapsed, animated: true)
        
        
    }
    
    
    func showChart(){
        barChart.setState(.expanded, animated: true)
        lineChart.setState(.expanded, animated: true)
        
    }
    
    //MARK: JBBarChartView
    
    func numberOfBars(in barChartView: JBBarChartView!) -> UInt {
        
        return UInt(chartData.count)
    }
    
    func barChartView(_ barChartView: JBBarChartView!, heightForBarViewAt index: UInt) -> CGFloat {
        //returning the height for each bar on the graph
        return CGFloat(chartData[Int(index)])
        
    }
    
    func barChartView(_ barChartView: JBBarChartView!, colorForBarViewAt index: UInt) -> UIColor! {
        //switches the color between each graph
        return (index % 2 == 0) ? UIColor.darkGray : UIColor.white
        
        
    }
    
    
    func barChartView(_ barChartView: JBBarChartView!, didSelectBarAt index: UInt, touch touchPoint: CGPoint) {
        //provides animation for the clicking mechanism on the graph
        //displays the data to the user for that time clicked
        let data = chartData[Int(index)]
        let key = chartLegend[Int(index)]
        
        informationLabel.text = "Usage at \(key): \(data)"
        
        batteryUse.isHidden = false
        screenTime.isHidden = false
        mainApplication.isHidden = false
        
    }
    
    func didDeselect(_ barChartView: JBBarChartView!) {
        //informationLabel.text = ""
    }
    
    func barSelectionColor(for barChartView: JBBarChartView!) -> UIColor! {
        return UIColor.black
    }
    func barPadding(for barChartView: JBBarChartView!) -> CGFloat {
        return CGFloat(7.0)
    }
    
    
    //MARK: JBLineChartView
    
    func numberOfLines(in lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        if (lineIndex == 0){
            return UInt(chartData.count)
        }
        
        return 0
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        if(lineIndex == 0) {
            return CGFloat(chartData[Int(horizontalIndex)])
        }
        
        return 0
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 0){
            return UIColor.white
        }
        
        return UIColor.purple
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, selectionColorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.black
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, didSelectLineAt lineIndex: UInt, horizontalIndex: UInt) {
        if (lineIndex == 0){
            let data = chartData[Int(horizontalIndex)]
            let key = chartLegend[Int(horizontalIndex)]
            informationLabel.text = "Usage at \(key): \(data)"
        }
    }
    
    func didDeselectLine(in lineChartView: JBLineChartView!) {
        //informationLabel.text = ""
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, dotRadiusForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        return CGFloat(14)
    }
   /* func lineChartView(_ lineChartView: JBLineChartView!, fillColorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 0) {
            return UIColor.darkGray
        }
        else {
            return UIColor.white
        }
    }*/
    
    
    //for background testing
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerBackgroundTask() {
        //.beginBackgroundTask start the long running task
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    //when start button is no longer highlighted
    func endBackgroundTask() {
        print("Background task ended.")
        //must call .endBackgroundTask or else app will be terminated
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    
   
    
    //count add function to output to the Counter label
    func addOne() {
        
        var total = countNum
        countNum += 1
      
        let results = "\(total)"
        
        //showing results in the consel of what state the app is in
        switch UIApplication.shared.applicationState {
        case .active:
            print("App is foreground")
            counterLabel.text = results
        case .background:
            print("App is backgrounded. Next number = \(countNum)")
            print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
        case .inactive:
            print("App is inactive")
            break
        }
    }
    
    //when app enter the background state
    func detectBackground() {
        print("App is in background")
        registerBackgroundTask()
        //Timer.scheduledTimer repeat a function at a certain interval for every 1 second
       Timer.scheduledTimer(timeInterval: 1, target: self,
                                           selector: #selector(addOne), userInfo: nil, repeats: true)
        
    }
    //end testing
    
    
    

}

