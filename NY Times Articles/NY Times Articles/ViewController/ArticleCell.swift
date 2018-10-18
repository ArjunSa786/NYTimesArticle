//
//  ArticleCell.swift
//  NY Times Articles
//


import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleImgVw: UIImageView!
    @IBOutlet weak var articleTitleLbl: UILabel!
    @IBOutlet weak var articleByLineLbl: UILabel!
    @IBOutlet weak var articlePublishedAtLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(article: Article) {
        articleTitleLbl.text = article.articleTitle
        articleByLineLbl.text = article.articleBy
        articlePublishedAtLbl.text = article.articlePublishedDate
        articleImgVw.loadImageUsingCacheWithImageURLString(article.articleMedia[0].mediaMetaData[0].url, placeHolder: nil) { (bool) in
            
        }
    }
}
