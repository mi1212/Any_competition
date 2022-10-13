//
//  CompetitionTableView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 26.09.2022.
//

import UIKit

protocol CompetitionTableViewDelegate: AnyObject {
    func chooseMatch(_ indexPathOfMatch: IndexPath)
}

class CompetitionTableView: UIView {
 
    var competitionTable: CompetitionTable?
    
    let side = CGFloat(40)
        
    var delegate: CompetitionTableViewDelegate?
    
    private lazy var qty = competitionTable?.playersArray.count
    
    private lazy var subView: UIView = {
        let content = UIView()
        content.backgroundColor = .white
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    lazy var tableCollectionView: UICollectionView = {
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
    
    convenience init(competitionTable: CompetitionTable) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.competitionTable = competitionTable
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(subView)
        
        subView.addSubview(scrollView)
        subView.addSubview(playersNamesCollectionView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(tableCollectionView)
        contentView.addSubview(playersScoreCollectionView)
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.topAnchor),
            subView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            subView.widthAnchor.constraint(equalToConstant: 2.5*side + side*CGFloat(qty!+1)),
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            playersNamesCollectionView.topAnchor.constraint(equalTo: subView.topAnchor),
            playersNamesCollectionView.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            playersNamesCollectionView.widthAnchor.constraint(equalToConstant: 2.5*side),
            playersNamesCollectionView.heightAnchor.constraint(equalToConstant: side*CGFloat(qty!)),
            playersNamesCollectionView.bottomAnchor.constraint(equalTo: subView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: subView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: subView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: playersNamesCollectionView.trailingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])

        NSLayoutConstraint.activate([
            tableCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableCollectionView.widthAnchor.constraint(equalToConstant: side*CGFloat(qty!)),
            tableCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            playersScoreCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            playersScoreCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playersScoreCollectionView.leadingAnchor.constraint(equalTo: tableCollectionView.trailingAnchor),
            playersScoreCollectionView.widthAnchor.constraint(equalToConstant: side),
            playersScoreCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
            cell.backgroundColor = .white
            
            
            
            let match = CompetitionViewController.competitionTable!.competitionTable[indexPath.section][indexPath.row]
            if match.isDone != true {
                if indexPath.row == indexPath.section  {
                    cell.backgroundColor = .anyDarckColor
                }
            } else {
                cell.backgroundColor = .green
            }
            
            return cell
            
        } else if collectionView == playersNamesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionTableCollectionViewCell.identifire, for: indexPath) as! CompetitionTableCollectionViewCell
            cell.backgroundColor = .white
            cell.label.text = "#\(indexPath.section+1) \(competitionTable!.playersArray[indexPath.section].name)\n\(competitionTable!.playersArray[indexPath.section].secondName)"
            cell.label.textAlignment = .left
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionTableCollectionViewCell.identifire, for: indexPath) as! CompetitionTableCollectionViewCell
            cell.backgroundColor = .white
            
            
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == tableCollectionView {
            delegate?.chooseMatch(indexPath)
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
