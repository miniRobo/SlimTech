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
    
   
    //var chartData = [0.5,1.5,3.5,4.0,4.1,7.7,9.9,10,11,11,11,11,11,11,11,12.5,13,13.2,13.3,15,15.1,15.1,15.1,17.9]
    //var chartLegend = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    var chartData = [1,2,3,7,9,9,9,15]
    var chartLegend = [1,2,3,4,5,6,7,8]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        //barChart.isHidden = true
        //bar chart setup
        barChart.backgroundColor = UIColor.gray
        barChart.delegate = self
        barChart.dataSource = self
        barChart.minimumValue = 0
        barChart.maximumValue = CGFloat(chartData.max()!)
        
        lineChart.isHidden = true
        //bar chart setup
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
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      
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
        
        barChart.reloadData()
        lineChart.reloadData()
        
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
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
        
        return CGFloat(chartData[Int(index)])
        
    }
    
    func barChartView(_ barChartView: JBBarChartView!, colorForBarViewAt index: UInt) -> UIColor! {
        
        return (index % 2 == 0) ? UIColor.blue : UIColor.green
        
        
    }
    
    
    func barChartView(_ barChartView: JBBarChartView!, didSelectBarAt index: UInt, touch touchPoint: CGPoint) {
        
        let data = chartData[Int(index)]
        let key = chartLegend[Int(index)]
        
        informationLabel.text = "Usage at \(key): \(data)"
        
    }
    
    func didDeselect(_ barChartView: JBBarChartView!) {
        //informationLabel.text = ""
    }
    
    func barSelectionColor(for barChartView: JBBarChartView!) -> UIColor! {
        return UIColor.black
    }
    func barPadding(for barChartView: JBBarChartView!) -> CGFloat {
        return CGFloat(3.0)
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
            return UIColor.green
        }
        
        return UIColor.purple
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, selectionColorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.yellow
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
        return CGFloat(10)
    }
    func lineChartView(_ lineChartView: JBLineChartView!, fillColorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 0) {
            return UIColor.blue
        }
        else {
            return UIColor.green
        }
    }
    
    
    

}

