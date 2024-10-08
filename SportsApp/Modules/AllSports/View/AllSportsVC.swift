//
//  ViewController.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit

class AllSportsVC: UIViewController {
    let viewModel: AllSportsViewModel!
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    required init?(coder: NSCoder) {
        self.viewModel = AllSportsViewModel()
        super.init(coder: coder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Sports"
    }
    
    func setupUI() {
        setupCollectionView()
        setupObserver()
    }
    
    func setupCollectionView() {
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        
        sportsCollectionView.register(UINib(nibName: "SportCell", bundle: nil), forCellWithReuseIdentifier: "SportCell")
    }
    
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange),name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func setupViewModel() {
        viewModel.navigateToAllLeaguesTVC = { index in
            self.viewModel.connectivity.checkConnectivity { [weak self] connected in
                if connected {
                    let allLeaguesVC = self?.storyboard?.instantiateViewController(identifier: "allLeagues") as! AllLeaguesTVC
                    allLeaguesVC.title = (self?.viewModel.sports[index].title ?? "") + " Leagues"
                    allLeaguesVC.viewModel.isFav = false
                    allLeaguesVC.viewModel.sport = self?.viewModel.sports[index]
                    self?.navigationController?.pushViewController(allLeaguesVC, animated: true)
                } else {
                    let alert = UIAlertController(title: "No Connection", message: "Make sure you are connected to WiFi or cellular and try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func orientationDidChange() {
        sportsCollectionView.reloadData()
    }
}

extension AllSportsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as! SportCell
        cell.setupCell(title: viewModel.sports[indexPath.row].title, image: UIImage(named: viewModel.sports[indexPath.row].imageName))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToAllLeaguesTVC(indexPath.row)
    }
    
}

extension AllSportsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let safeAreaInsets = view.safeAreaInsets
        let safeAreaWidth = view.bounds.width - safeAreaInsets.left - safeAreaInsets.right
        let size = CGSize(width: safeAreaWidth/2 - 15, height: safeAreaWidth/2 - 15)
        return size
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
