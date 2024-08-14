//
//  ViewController.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit

class AllSportsVC: UIViewController {
    let viewModel = AllSportsViewModel()
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Sports"
    }
    
    func setupVC() {
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        
        sportsCollectionView.register(UINib(nibName: "SportCell", bundle: nil), forCellWithReuseIdentifier: "SportCell")
        
        viewModel.navigateToAllLeaguesTVC = { index in
            let vc = self.storyboard?.instantiateViewController(identifier: "allLeagues") as! AllLeaguesTVC
            vc.title = self.viewModel.sports[index].title
            vc.isFav = false
            vc.viewModel.sport = self.viewModel.sports[index]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension AllSportsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as! SportCell
        cell.setupSport(title: viewModel.sports[indexPath.row].title, image: UIImage(named: viewModel.sports[indexPath.row].imageName))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToAllLeaguesTVC(indexPath.row)
    }
    
}

extension AllSportsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2 - 15, height: UIScreen.main.bounds.width/2 - 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
