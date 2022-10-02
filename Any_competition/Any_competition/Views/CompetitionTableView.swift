//
//  CompetitionTableView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 26.09.2022.
//

import UIKit

class CompetitionTableView: UIView {
    
    var usersTable: UsersTable?
    
    private lazy var qty = usersTable?.playersArray.count
    
    private lazy var tableCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var playersNamesCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.backgroundColor = .black
        table.delegate = self
        table.dataSource = self
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var playersScoreCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.backgroundColor = .black
        table.delegate = self
        table.dataSource = self
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    convenience init(usersTable: UsersTable) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.usersTable = usersTable
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(tableCollectionView)
        self.addSubview(playersNamesCollectionView)
        self.addSubview(playersScoreCollectionView)
        
        NSLayoutConstraint.activate([
            tableCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            tableCollectionView.leadingAnchor.constraint(equalTo: playersNamesCollectionView.trailingAnchor),
            tableCollectionView.trailingAnchor.constraint(equalTo: playersScoreCollectionView.leadingAnchor),
            tableCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            playersNamesCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            playersNamesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playersNamesCollectionView.trailingAnchor.constraint(equalTo: tableCollectionView.leadingAnchor),
            playersNamesCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6),
            playersNamesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            playersScoreCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            playersScoreCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playersScoreCollectionView.leadingAnchor.constraint(equalTo: tableCollectionView.trailingAnchor),
            playersScoreCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6),
            playersScoreCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
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
            cell.layer.borderWidth = 0
            
            if indexPath.row == indexPath.section  {
                cell.backgroundColor = .anyDarckColor
            }
            
            return cell
            
        } else if collectionView == playersNamesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionTableCollectionViewCell.identifire, for: indexPath) as! CompetitionTableCollectionViewCell
            cell.backgroundColor = .backgroundColor
            cell.label.text = usersTable!.playersArray[indexPath.section].name + " " + usersTable!.playersArray[indexPath.section].secondName
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionTableCollectionViewCell.identifire, for: indexPath) as! CompetitionTableCollectionViewCell
            cell.backgroundColor = .backgroundColor
            cell.layer.borderWidth = 0
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.backgroundColor == .white {
            print(indexPath)
        }
    }
    
    
}

extension CompetitionTableView: UICollectionViewDelegateFlowLayout {
    
    var insetSpaseBetween: CGFloat {0.01}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == tableCollectionView {
            let size = collectionView.frame.size
            let width = (size.width-CGFloat((qty!+1))*insetSpaseBetween)/CGFloat(qty!)
            let height = (size.height-CGFloat((qty!*2+1))*insetSpaseBetween)/CGFloat(qty!)
            return CGSize(
                width: width,
                height: height
            )
                                                               
                } else {
                    let size = collectionView.frame.size
                    return CGSize(width: (size.width-5*insetSpaseBetween), height: (size.height-9*insetSpaseBetween)/CGFloat((usersTable?.playersArray.count)!))
                }
                }
                
                func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                    return 0
                }
                
                func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                    return 0
                }
                }
