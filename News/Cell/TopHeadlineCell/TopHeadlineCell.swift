//
//  TopHeadlineCell.swift
//  News
//
//  Created by iMac on 23/01/24.
//

import UIKit
import SDWebImage

class TopHeadlineCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let xibName = "TopHeadlineCell"
    static let reuseIdentifier = "TopHeadlineCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.articleImage.layer.cornerRadius = 8
    }
    
    func configCell(article: Articles) {
        let imageUrl = URL(string: article.urlToImage ?? "")
        let indicator = SDWebImageActivityIndicator.medium
        self.articleImage.sd_imageIndicator = indicator
        DispatchQueue.global(qos: .userInteractive).async {
            self.articleImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder-image"))
        }        
        self.headlineLabel.text = article.title
        self.dateLabel.text = article.publishedAt?.setTimesAgo()
    }
    
}
