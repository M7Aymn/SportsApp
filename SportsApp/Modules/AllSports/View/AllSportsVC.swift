//
//  ViewController.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit

class AllSportsVC: UIViewController {

    let sportNames = ["Football", "Basketball", "Cricket", "Tennis"]
    let sportTypes: [Sport] = [.football, .basketball, .cricket, .tennis]
    let sportImages = [
        UIImage(systemName: "soccerball"),
        UIImage(systemName: "basketball.fill"),
        UIImage(systemName: "cricket.ball.fill"),
        UIImage(systemName: "tennisball.fill")
    ]
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        
        sportsCollectionView.register(UINib(nibName: "SportCell", bundle: nil), forCellWithReuseIdentifier: "SportCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Sports"
    }

}

extension AllSportsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as! SportCell
        cell.setupSport(name: sportNames[indexPath.row], image: sportImages[indexPath.row]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "allLeagues") as! AllLeaguesTVC
        vc.title = sportNames[indexPath.row]
        vc.isFav = false
        vc.viewModel.sport = sportTypes[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


