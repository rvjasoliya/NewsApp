//
//  TopHeadlineVC.swift
//  News
//
//  Created by iMac on 23/01/24.
//

import UIKit

class TopHeadlineVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var vm = TopHeadlineViewModel()
    let topHeadlineHeaderViewHeight: CGFloat = 0
    
    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.initialConfig()
    }
    
    // MARK: - Helper Functions
    
    // Initial Config
    func initialConfig() {
        self.registerCell()
        self.tableViewSetup()
        self.fetchTopHeadlines()
    }
    
    // Register Cell
    func registerCell() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: CategoryCell.xibName, bundle: nil), forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
    }
    
    // TableView Setup
    func tableViewSetup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: TopHeadlineCell.xibName, bundle: nil), forCellReuseIdentifier: TopHeadlineCell.reuseIdentifier)
    }
    
    //fetch notes from server
    func fetchTopHeadlines() {
        let requestObject = TopHeadlinesRequestData(apiKey: API.APIKey, country: nil, category: self.vm.category, pageSize: nil, page: nil, q: nil)
        self.vm.netRequestForGetTopHeadlines(queryData: requestObject){ (status, message) in
            if status {
                self.tableView.reloadData()
            }
        }
    }

}

// MARK: - Extensions

// MARK: Collection View Setup
extension TopHeadlineVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
        let item = self.vm.categories[indexPath.item]
        cell.titleLabel.text = item
        if self.vm.category == item {
            cell.titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
            cell.titleLabel.textColor = UIColor(named: "Brandeis Blue")
            cell.bottomBorder.backgroundColor = UIColor(named: "Brandeis Blue")
        } else {
            cell.titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
            cell.titleLabel.textColor = UIColor(named: "AuroMetalSaurus")
            cell.bottomBorder.backgroundColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.vm.categories[indexPath.item]
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.collectionView.reloadData()
        self.vm.category = item
        self.fetchTopHeadlines()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.vm.categories[indexPath.item]
        if self.vm.category == item {
            return CGSize(width: getWidthFromItem(title: self.vm.categories[indexPath.row], font: UIFont.systemFont(ofSize: 18.0, weight: .semibold)).width + 25, height: 48)
        } else {
            return CGSize(width: getWidthFromItem(title: self.vm.categories[indexPath.row], font: UIFont.systemFont(ofSize: 18.0, weight: .regular)).width + 25, height: 48)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    // Get Width From String
    func getWidthFromItem(title: String, font: UIFont) -> CGSize {
        let itemSize = title.size(withAttributes: [
            NSAttributedString.Key.font: font
        ])
        return itemSize
    }
    
}

// MARK: TableView Setup
extension TopHeadlineVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.articleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TopHeadlineCell.reuseIdentifier) as! TopHeadlineCell
        let rowPath = self.vm.articleArray[indexPath.row]
        cell.configCell(article: rowPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowPath = self.vm.articleArray[indexPath.row]
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "ArticleDetailVC") as! ArticleDetailVC
        newVC.vm.article = rowPath
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let topHeadlineHeaderView = TopHeadlineHeaderView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: self.topHeadlineHeaderViewHeight))
//        return topHeadlineHeaderView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return self.topHeadlineHeaderViewHeight
//    }
    
}
