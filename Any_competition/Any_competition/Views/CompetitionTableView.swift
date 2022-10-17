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
    
    var side = CGFloat(0)
        
    var delegate: CompetitionTableViewDelegate?
    
    private lazy var qty = competitionTable?.qtyPlayers
    
    private lazy var subView: UIView = {
        let content = UIView()
        content.backgroundColor = .backgroundColor
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
    
    private lazy var playersNumberCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        table.backgroundColor = .backgroundColor
        table.delegate = self
        table.dataSource = self
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var tableCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.delegate = self
        table.dataSource = self
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var playersNamesCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.delegate = self
        table.dataSource = self
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var playersScoreCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.delegate = self
        table.dataSource = self
        table.register(CompetitionTableCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionTableCollectionViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    convenience init(competitionTable: CompetitionTable, side: CGFloat) {
        self.init()
        self.side = side
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
        subView.addSubview(playersNumberCollectionView)
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
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subView.heightAnchor.constraint(equalToConstant: side*CGFloat(qty!+1)),
        ])
        
        NSLayoutConstraint.activate([
            playersNumberCollectionView.topAnchor.constraint(equalTo: subView.topAnchor),
            playersNumberCollectionView.leadingAnchor.constraint(equalTo: tableCollectionView.leadingAnchor),
            playersNumberCollectionView.trailingAnchor.constraint(equalTo: tableCollectionView.trailingAnchor),
            playersNumberCollectionView.heightAnchor.constraint(equalToConstant: side),
        ])
        
        NSLayoutConstraint.activate([
            playersNamesCollectionView.topAnchor.constraint(equalTo: playersNumberCollectionView.bottomAnchor),
            playersNamesCollectionView.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            playersNamesCollectionView.widthAnchor.constraint(equalToConstant: 2.5*side),
            playersNamesCollectionView.heightAnchor.constraint(equalToConstant: side*CGFloat(qty!)),
            playersNamesCollectionView.bottomAnchor.constraint(equalTo: subView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: playersNumberCollectionView.bottomAnchor),
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
    
    func reloadData(competitionTable: CompetitionTable) {
        self.competitionTable = competitionTable
        tableCollectionView.reloadData()
        playersNamesCollectionView.reloadData()
        playersScoreCollectionView.reloadData()
    }
}

extension CompetitionTableView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var section: Int
        
        if collectionView != playersNumberCollectionView {
            section = qty!
        } else {
            section = 1
        }
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItemsInSection: Int
        if collectionView == tableCollectionView {
            numberOfItemsInSection = qty!
        } else if collectionView == playersNumberCollectionView {
            numberOfItemsInSection = qty!
        } else {
            numberOfItemsInSection = 1
        }
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionTableCollectionViewCell.identifire, for: indexPath) as! CompetitionTableCollectionViewCell
        
        switch collectionView {
            
        case tableCollectionView:
            cell.backgroundColor = .white
            cell.label.textAlignment = .center
 
            let match = CompetitionViewController.competition?.competitionTable!.competitionTable[indexPath.section].matchesOfPlayer[indexPath.row]
            
            if match!.isDone != true { // проверка, что матч не состоялся

                if indexPath.row == indexPath.section  {
                    cell.backgroundColor = .anyDarckColor
                }

            } else {

                if match!.isWinned {
                    cell.label.text = "3"
                    cell.backgroundColor = .anyColor
                } else {
                    cell.label.text = "0"
                    cell.backgroundColor = .anyColor1
                }
          
            }
            
            return cell
        case playersNamesCollectionView:
            
            cell.backgroundColor = .white
            cell.label.text = "#\(indexPath.section+1) \(competitionTable!.playersArray[indexPath.section].name)\n\(competitionTable!.playersArray[indexPath.section].nick)"
            cell.label.textAlignment = .left
            return cell
            
        case playersNumberCollectionView:
                           
            cell.label.text = "#\(indexPath.row + 1)"
            cell.layer.borderWidth = 0
            cell.label.textAlignment = .center
            
            return cell
            
        case playersScoreCollectionView:
            
            if let player = competitionTable?.playersArray[indexPath.section]  {
                
                cell.label.text = "\((competitionTable?.calculatePointsOfPlayer(player))!)"
                
            }
            
            cell.backgroundColor = .white
            cell.label.textAlignment = .center
            
            return cell
            
        default:
            return cell
        }
//
//        if collectionView == tableCollectionView {
//
//            cell.backgroundColor = .white
//            cell.label.textAlignment = .center
//
//            let match = CompetitionViewController.competition?.competitionTable!.competitionTable[indexPath.section].matchesOfPlayer[indexPath.row]
//
//            if match!.isDone != true { // проверка, что матч не состоялся
//
//                if indexPath.row == indexPath.section  {
//                    cell.backgroundColor = .anyDarckColor
//                }
//
//            } else {
//
//                if match!.isWinned {
//                    cell.label.text = "3"
//                    cell.backgroundColor = .anyColor
//                } else {
//                    cell.label.text = "0"
//                    cell.backgroundColor = .anyColor1
//                }
//
//            }
//
//            return cell
//
//        } else if collectionView == playersNamesCollectionView {
//
//            cell.backgroundColor = .white
//            cell.label.text = "#\(indexPath.section+1) \(competitionTable!.playersArray[indexPath.section].name)\n\(competitionTable!.playersArray[indexPath.section].nick)"
//            cell.label.textAlignment = .left
//            return cell
//        } else {
//
//
//            if let player = competitionTable?.playersArray[indexPath.section]  {
//
//                cell.label.text = "\((competitionTable?.calculatePointsOfPlayer(player))!)"
//
//            }
//
//            cell.backgroundColor = .white
//            cell.label.textAlignment = .center
//
//            return cell
//        }
  
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == tableCollectionView {
            if indexPath.row != indexPath.section {
                delegate?.chooseMatch(indexPath)
            }
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
        case playersNumberCollectionView:
            
            let width = (size.width)/CGFloat(qty!)
            let height = (size.height)
            
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
