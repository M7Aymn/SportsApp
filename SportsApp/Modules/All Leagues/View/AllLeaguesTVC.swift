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
        
        loadLeaguesTable()
    }
    
    func loadLeaguesTable(){
        if viewModel.isFavouriteScreen() {
            viewModel.getFavouriteLeagues()
        } else {
            viewModel.getLeaguesFromNetwork()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        let selectedLeague = viewModel.leagues[indexPath.row]
        cell.setupCell(league: selectedLeague)
        cell.buttonTapped = {
            self.navigateToWebView(for: selectedLeague)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "leagueDetailsSegue", sender: viewModel.leagues[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "leagueDetailsSegue" {
                if let nextViewController = segue.destination as? LeagueDetailsVC {
                    nextViewController.viewModel.league = sender as! LeagueModel
                }
            }
        }
    
    private func navigateToWebView(for league: LeagueModel) {
            let webViewController = leagueYoutubeWebViewVC()
        webViewController.urlString = viewModel.getYouTubeChannelURL(for: league)
            navigationController?.pushViewController(webViewController, animated: true)
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
