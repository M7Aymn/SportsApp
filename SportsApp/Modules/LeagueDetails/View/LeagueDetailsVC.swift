//
//  LeagueDetailsVC.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit

class LeagueDetailsVC: UIViewController {
    let viewModel = LeagueDetailsViewModel()
    let indicator = UIActivityIndicatorView(style: .large)
    let button = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: nil, action: #selector(favButtonPressed))
    var isFav = false {
        didSet {
            button.image = isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        }
    }
    
    @IBOutlet weak var leagueCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
    }
    
    func setupUI() {
        title = viewModel.league.leagueName
        setupIndicator()
        viewModel.getDetails()
        setupButton()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    func setupViewModel() {
        viewModel.stopIndicator = {
            self.indicator.stopAnimating()
        }
        
        viewModel.noResults = {
            self.indicator.stopAnimating()
            self.leagueCollectionView.isHidden = true
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            imageView.center = self.view.center
            imageView.image = UIImage(named: "noResults")
            self.view.addSubview(imageView)
        }
        
        viewModel.bindResultToVC = {
            self.leagueCollectionView.reloadData()
        }
    }
    
    func setupIndicator() {
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func setupButton() {
        button.target = self
        self.navigationItem.rightBarButtonItem = button
        isFav = viewModel.checkFavorite()
    }
    
    func setupCollectionView() {
        leagueCollectionView.delegate = self
        leagueCollectionView.dataSource = self
        
        leagueCollectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "eventCell")
        leagueCollectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
    }
    
    @objc func favButtonPressed() {
        if isFav {
            // removing from fav
            let alert = UIAlertController(title: "Remove favorite", message: "Are you sure you want to remove this league from favorites?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { UIAlertAction in
                self.viewModel.removeFromFavorites()
                self.isFav.toggle()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        } else {
            // adding to fav
            self.viewModel.addToFavorites()
            isFav.toggle()
        }
    }
}


extension LeagueDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.upcomingEvents.count
        case 1:
            return viewModel.latestEvents.count
        case 2:
            return viewModel.teams.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = leagueCollectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
            cell.setupCell(event: viewModel.upcomingEvents[indexPath.row])
            return cell
        case 1:
            let cell = leagueCollectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
            cell.setupCell(event: viewModel.latestEvents[indexPath.row])
            return cell
        case 2:
            let cell = leagueCollectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCell
            cell.setupCell(team: viewModel.teams[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headers = ["Upcoming Events", "Latest Results", "Teams"]
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? SectionHeader{
            sectionHeader.sectionHeaderLabel.text = headers[indexPath.section]
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            self.performSegue(withIdentifier: "TeamDetailsSegue", sender: (viewModel.sport, viewModel.teams[indexPath.item].teamKey))
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
#warning("move this to viewModel, load data in TeamDetails viewModel")
            if segue.identifier == "TeamDetailsSegue" {
                if let nextViewController = segue.destination as? TeamDetailsVC {
                    let (sport, teamKey) = sender as! (Sport, Int)
                    nextViewController.viewModel.sport = sport
                    nextViewController.viewModel.teamID = teamKey
                }
            }
        }
}


extension LeagueDetailsVC: UICollectionViewDelegateFlowLayout {
    func setupCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0 :
                return self.upcomingSection()
            case 1 :
                return self.latestSection()
            case 2:
                return self.teamsSection()
            default:
                return self.upcomingSection()
            }
        }
        leagueCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func upcomingSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        if viewModel.upcomingEvents.count != 0 {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
        }
        
        
        //        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
        //            items.forEach { item in
        //                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
        //                let minScale: CGFloat = 0.8
        //                let maxScale: CGFloat = 1.0
        //                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
        //                item.transform = CGAffineTransform(scaleX: scale, y: scale)
        //            }
        //        }
        return section
    }
    
    func latestSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        if viewModel.latestEvents.count != 0 {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
        }
        
        return section
    }
    
    func teamsSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        if viewModel.teams.count != 0 {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize:headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
        }
        
        return section
    }
}
