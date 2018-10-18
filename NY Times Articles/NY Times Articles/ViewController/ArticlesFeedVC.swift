//
//  NewsFeedTableViewController.swift
//  NY Times Articles
//


import UIKit

class ArticlesFeedVC: UITableViewController {
    // Member variables
    private let cellID = "ArticleCellIdentifier"
    private var articleArray = [Article]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    let service = ArticleService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call Service class using Generic Function
        getArticle(fromService: service)
    }

    private func getArticle<S: GetArticle>(fromService service: S) where S.T == Array<Article?> {
        service.getArticlesList(completion: { [weak self] (result) in
            switch result {
            case .Success(let articles):
                var tempArticle = [Article]()
                for article in articles {
                    if let article = article {
                        tempArticle.append(article)
                    }
                }
                self?.articleArray = tempArticle
            case .Error(let error):
                print(error)
            }
        })
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ArticleCell
        cell.configureCell(article: articleArray[indexPath.row])
        return cell
    }

}
