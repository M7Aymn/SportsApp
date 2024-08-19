//
//  AllLeaguesTVC.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 12/08/2024.
//

import UIKit

class AllLeaguesTVC: UITableViewController {
    let viewModel = AllLeaguesViewModel()
    let indicator = UIActivityIndicatorView(style: .large)
    let noFavoriteImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Favorite"
        
        viewModel.loadLeaguesTable()
    }
    
    func setupUI() {
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        noFavoriteImageView.center = CGPoint(x: view.center.x, y: view.center.y * 0.75)
        noFavoriteImageView.image = UIImage(named: "noFavorites")
        noFavoriteImageView.contentMode = .scaleAspectFit
        noFavoriteImageView.layer.cornerRadius = 150
        noFavoriteImageView.layer.masksToBounds = true
        view.addSubview(noFavoriteImageView)
        noFavoriteImageView.isHidden = true
        
        let nib = UINib(nibName: "LeagueCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
    }
    
    func setupViewModel() {
        viewModel.bindResultToVC = {
            self.indicator.stopAnimating()
            self.tableView.reloadData()
        }
        
        viewModel.showNoFavoriteImage = { showImage in
            self.tableView.isScrollEnabled = !showImage
            self.noFavoriteImageView.isHidden = !showImage
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfLeagues()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        let selectedLeague = viewModel.getLeague(index: indexPath.row)
        cell.setupCell(league: selectedLeague)
        cell.buttonTapped = {
            self.navigateToSafari(for: selectedLeague)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if viewModel.isFav {
        Connectivity.shared.check { [weak self] connected in
            if connected {
                self?.performSegue(withIdentifier: "leagueDetailsSegue", sender: indexPath.row)
            } else {
                let alert = UIAlertController(title: "No Connection", message: "Make sure you are connected to WiFi or cellular and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self?.present(alert, animated: true)
            }
        }
//        } else {
//            self.performSegue(withIdentifier: "leagueDetailsSegue", sender: indexPath.row)
//        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "leagueDetailsSegue" {
                if let nextVC = segue.destination as? LeagueDetailsVC {
                    let index = sender as! Int
                    let sport = (viewModel.isFav) ? (viewModel.sports[index]) : (viewModel.sport ?? .football)
                    nextVC.viewModel.sport = sport
                    nextVC.viewModel.league = viewModel.leagues[index]
                }
            }
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.isFav
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Remove favorite", message: "Are you sure you want to remove this league from favorites?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { UIAlertAction in
                self.viewModel.removeFromFavorites(index: indexPath.row)
                self.viewModel.getFavoriteLeagues()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    private func navigateToSafari(for league: LeagueModel) {
        if let url = self.viewModel.getYouTubeChannelURL(for: league){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
