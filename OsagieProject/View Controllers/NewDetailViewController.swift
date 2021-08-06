//
//  NewDetailViewController.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 02/08/2021.
//

import UIKit
import DateToolsSwift

struct ThingSpeakDateSorted{
    var day:Date
    var arrayValues:[ThingSpeakFieldValues]
}

class NewDetailViewController: UIViewController {
    
    var singleThingSpeakhmm: ThingSpeakField?
    var array_Dates = [Date]()

    var array_of_array_thingSpeak = [ThingSpeakDateSorted]()
    
    var alotOfDates = [Date]()
    @IBOutlet weak var collThingSpeak: UICollectionView!
    @IBOutlet weak var pageControlOsagie: UIPageControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = singleThingSpeakhmm?.fieldTitle
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barTintColor = .white
        getAllTheDatesAndSortThem()
        configureColledtionView()
       
    }
    
    fileprivate func configureColledtionView(){
        collThingSpeak.delegate = self
        collThingSpeak.dataSource = self
        collThingSpeak.register(HistoryCVC.getNib(), forCellWithReuseIdentifier: HistoryCVC.identifier)
        collThingSpeak.isPagingEnabled = true
        if let flowlayout = collThingSpeak.collectionViewLayout as? UICollectionViewFlowLayout{
            flowlayout.scrollDirection = .horizontal
            flowlayout.minimumLineSpacing = 0
        }
        
//        let collectionViewRefreshControl = UIRefreshControl()
//        collectionViewRefreshControl.tintColor = .yellow
//        collectionViewRefreshControl.attributedTitle = NSAttributedString(string: "Fetching Energy Data...")
//        collThingSpeak.refreshControl = collectionViewRefreshControl
//        collThingSpeak.addTarget(self, action: #selector(getChartData), for: .valueChanged)
    }
    
    fileprivate func getAllTheDatesAndSortThem(){
        singleThingSpeakhmm?.field_value_array.forEach({
            m in
            alotOfDates.append(m.actualDate)
        })
        array_Dates = alotOfDates.unique()
        print(array_Dates.count)
        getAllTheValuesAndSortThem()
    }
    
    
    fileprivate func getAllTheValuesAndSortThem(){
        for oneDate in array_Dates{
            let oneArray = singleThingSpeakhmm?.field_value_array.filter{
                $0.actualDate.isSameDay(date: oneDate)
            }
            
            if let oneArray = oneArray{
                let singleThingSpeakDateSorted = ThingSpeakDateSorted(day: oneDate, arrayValues: oneArray)
                array_of_array_thingSpeak.append(singleThingSpeakDateSorted)
            }
        }
        collThingSpeak.reloadData()
    }
    
}


extension NewDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array_of_array_thingSpeak.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let historyCVCell = collThingSpeak.dequeueReusableCell(withReuseIdentifier: HistoryCVC.identifier, for: indexPath) as! HistoryCVC
        
        
        let singleIndexDate = array_Dates[indexPath.item]
        let singleIndexDateString = singleIndexDate.toShortString()
        historyCVCell.labelDate.text = "\(singleIndexDate.isToday ?  ("Today: " + singleIndexDateString):singleIndexDateString)"
        historyCVCell.convertToChartDataEntry(array_adafruit: self.array_of_array_thingSpeak[indexPath.item].arrayValues)
//        print(self.array_of_array_thingSpeak[indexPath.item].arrayValues.count)
//        historyCVCell.changeLegendColor(theColor: UserDefUtils.userChartTintColor)
        return historyCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collThingSpeak.frame.width, height: collThingSpeak.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPageNumber = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControlOsagie.currentPage = currentPageNumber
//        updateViewControllerValuesAccordingToDay(currentPageNumber: currentPageNumber)
        
    }
    
}
