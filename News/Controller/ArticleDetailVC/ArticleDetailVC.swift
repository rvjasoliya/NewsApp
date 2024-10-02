//
//  ArticleDetailVC.swift
//  News
//
//  Created by iMac on 23/01/24.
//

import UIKit
import SDWebImage

class ArticleDetailVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var articleContentLabel: UILabel!
    
    // MARK: - Properties
    
    var vm = ArticleViewModel()
    
    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initialConfig()
    }
    
    // MARK: - Selectors
    
    // Back Button Action
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    
    // Initial Config
    func initialConfig() {
        self.setupUI()
        self.setData()
    }
    
    // SetupUI
    func setupUI() {
        self.articleImageView.layer.cornerRadius = 16
    }
    
    // Set Data
    func setData() {
        guard let article = vm.article else { return }
        self.headlineLabel.text = article.title
        self.articleDescriptionLabel.text = article.description
        let imageUrl = URL(string: article.urlToImage ?? "")
        let indicator = SDWebImageActivityIndicator.medium
        self.articleImageView.sd_imageIndicator = indicator
        DispatchQueue.global(qos: .userInteractive).async {
            self.articleImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder-image"))
        }
        self.articleContentLabel.text = article.content
        self.publishDateLabel.text = article.publishedAt?.toFormatedDate(from: "yyyy-MM-dd'T'HH:mm:ssZ", to: "dd MMM yyyy, hh:mm a")
        self.authorLabel.text = article.author
        self.sourceLabel.text = article.source?.name
    }

}
