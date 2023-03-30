//
//  QuotesListCell.swift
//  Technical-test
//
//  Created by Rustam Dzhumaniazov on 30.03.2023.
//

import UIKit

class QuotesListCell: UITableViewCell {
    private let name = UILabel()
    private let lastCurrency = UILabel()
    private let readableLastChangePercent = UILabel()
    private let favourite = UIImageView()
    private let internalView = UIView()
    
    var quote: Quote? {
        didSet {
            name.text = quote?.name
            lastCurrency.text = (quote?.last ?? "") + " " + (quote?.currency ?? "")
            readableLastChangePercent.text = quote?.readableLastChangePercent
            switch quote?.variationColor {
                case "green":
                    readableLastChangePercent.textColor = .green
                case "red":
                    readableLastChangePercent.textColor = .red
                default:
                    readableLastChangePercent.textColor = .darkText
            }
        }
    }
    var isFavourite: Bool = false {
        didSet {
            if (isFavourite) {
                favourite.image = UIImage(named: "favorite")
            } else {
                favourite.image = UIImage(named: "no-favorite")
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        setupView()
        setupAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        
    }
    
    func setupView() {
        name.font = .systemFont(ofSize: 20)
        lastCurrency.font = .systemFont(ofSize:20)
        readableLastChangePercent.font = .systemFont(ofSize: 30)
        
        internalView.addSubview(name)
        internalView.addSubview(lastCurrency)
        
        favourite.contentMode = .scaleAspectFit
        
        self.addSubview(internalView)
        self.addSubview(readableLastChangePercent)
        self.addSubview(favourite)
    }
    
    func setupAutolayout() {
        internalView.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        lastCurrency.translatesAutoresizingMaskIntoConstraints = false
        readableLastChangePercent.translatesAutoresizingMaskIntoConstraints = false
        favourite.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            internalView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            internalView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 12),
            internalView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            internalView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            
            name.topAnchor.constraint(equalTo: internalView.topAnchor, constant: 0),
            name.leftAnchor.constraint(equalTo: internalView.leftAnchor, constant: 0),
            
            lastCurrency.topAnchor.constraint(equalTo: name.topAnchor, constant: 12),
            lastCurrency.leftAnchor.constraint(equalTo: internalView.leftAnchor, constant: 0),
            lastCurrency.bottomAnchor.constraint(equalTo: internalView.bottomAnchor, constant: 0),
            
            readableLastChangePercent.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            readableLastChangePercent.leftAnchor.constraint(equalTo: internalView.rightAnchor, constant: 20),
            
            favourite.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            favourite.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            favourite.widthAnchor.constraint(equalToConstant: 40),
            favourite.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
