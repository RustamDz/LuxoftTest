//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

class QuotesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    private let dataManager:DataManager = DataManager()
    private var market:Market? = nil
    private var tableView: UITableView!
    private var favouritesManager = FavouritesManager()
    
    override func viewDidLoad() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.register(QuotesListCell.self, forCellReuseIdentifier: "QuotesListCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        dataManager.fetchMarket { [weak self] market in
            self?.market = market
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let quote = market?.quotes?[indexPath.row] else { return }
        let quoteDetailsViewController = QuoteDetailsViewController(quote: quote) {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        self.present(quoteDetailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return market?.quotes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuotesListCell", for: indexPath as IndexPath)
        if let cell = cell as? QuotesListCell, let quote = market?.quotes?[indexPath.row] {
            cell.quote = quote
            cell.isFavourite = favouritesManager.isFavourite(quote: quote)
        }
        return cell
    }
}
