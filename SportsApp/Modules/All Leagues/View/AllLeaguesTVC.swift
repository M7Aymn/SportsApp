//
//  AllLeaguesTVC.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 12/08/2024.
//

import UIKit

class AllLeaguesTVC: UITableViewController {
    
    var viewModel = AllLeaguesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LeagueCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
        
        viewModel.bindResultToVC = {
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Favourite"
        
        viewModel.loadLeaguesTable()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfleagues()
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
        self.performSegue(withIdentifier: "leagueDetailsSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "leagueDetailsSegue" {
                if let nextViewController = segue.destination as? LeagueDetailsVC {
                    let index = sender as! Int
#warning("move this function to viewModel and give it only indexPath.row")
                    if viewModel.isFav {
                        nextViewController.viewModel.sport = viewModel.sports[index]
                    } else {
                        nextViewController.viewModel.sport = viewModel.sport ?? .football
                    }
                    nextViewController.viewModel.league = viewModel.leagues[index]
                }
            }
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    private func navigateToSafari(for league: LeagueModel) {
        if let url = self.viewModel.getYouTubeChannelURL(for: league){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
