//
//  CompetitionTableView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 26.09.2022.
//

import UIKit

class CompetitionTableView: UIView {
    
    var usersTable: UsersTable?
    
    let side = CGFloat(40)
    
    private lazy var qty = usersTable?.playersArray.count
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .backgroundColor
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private lazy var tableCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.delegate = self
        table.dataSource = self
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.black.cgColor
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var playersNamesCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.backgroundColor = .black
        table.delegate = self
        table.dataSource = self
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.black.cgColor
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var playersScoreCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.backgroundColor = .black
        table.delegate = self
        table.dataSource = self
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.black.cgColor
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    convenience init(usersTable: UsersTable) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.usersTable = usersTable
        setupView()
        self.backgroundColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(tableCollectionView)
        contentView.addSubview(playersNamesCollectionView)
        contentView.addSubview(playersScoreCollectionView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            playersNamesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            playersNamesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playersNamesCollectionView.trailingAnchor.constraint(equalTo: tableCollectionView.leadingAnchor),
            playersNamesCollectionView.widthAnchor.constraint(equalToConstant: 3*side),
            playersNamesCollectionView.heightAnchor.constraint(equalToConstant: side*CGFloat(qty!)),
        ])
        
        NSLayoutConstraint.activate([
            tableCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableCollectionView.leadingAnchor.constraint(equalTo: playersNamesCollectionView.trailingAnchor),
            tableCollectionView.trailingAnchor.constraint(equalTo: playersScoreCollectionView.leadingAnchor),
            tableCollectionView.widthAnchor.constraint(equalToConstant: side*CGFloat(qty!)),
            tableCollectionView.heightAnchor.constraint(equalTo: playersNamesCollectionView.heightAnchor),
        ])

        NSLayoutConstraint.activate([
            playersScoreCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            playersScoreCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playersScoreCollectionView.leadingAnchor.constraint(equalTo: tableCollectionView.trailingAnchor),
            playersScoreCollectionView.widthAnchor.constraint(equalToConstant: side),
            playersScoreCollectionView.heightAnchor.constraint(equalTo: playersNamesCollectionView.heightAnchor),
        ])
    }
}

extension CompetitionTableView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        qty!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItemsInSection = 0
        if collectionView == tableCollectionView {
            numberOfItemsInSection = qty!
        } else {
            numberOfItemsInSection = 1
        }
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tableCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionTableCollectionViewCell.identifire, for: indexPath)
            cell.backgroundColor = .backgroundColor
            
            if indexPath.row == indexPath.section  {
                cell.backgroundColor = .anyDarckColor
            }
            
            return cell
            
        } else if collectionView == playersNamesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionTableCollectionViewCell.identifire, for: indexPath) as! CompetitionTableCollectionViewCell
            cell.backgroundColor = .backgroundColor
            cell.label.text = "#\(indexPath.section+1) \(usersTable!.playersArray[indexPath.section].name)\n\(usersTable!.playersArray[indexPath.section].secondName)"
            cell.label.textAlignment = .left
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionTableCollectionViewCell.identifire, for: indexPath) as! CompetitionTableCollectionViewCell
            cell.backgroundColor = .backgroundColor
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.backgroundColor == .backgroundColor {
            print(indexPath)
        }
    }
    
    
}

extension CompetitionTableView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.frame.size
        
        switch collectionView {
            
        case tableCollectionView:
            let width = (size.width)/CGFloat(qty!)
            let height = (size.height)/CGFloat(qty!)
            
            return CGSize(
                width: width,
                height: height
            )
        default:
            let width = (size.width)
            let height = (size.height/CGFloat(qty!))
            
            return CGSize(
                width: width,
                height: height
            )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
