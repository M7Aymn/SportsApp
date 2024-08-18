//
//  TeamDetailsVC.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 16/08/2024.
//

import UIKit
import Kingfisher
class TeamDetailsVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var imgViewBG: UIImageView!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var playersTableView: UITableView!
    let indicator = UIActivityIndicatorView(style: .large)
    var viewModel = TeamDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    private func setupUI(){
        addGradientToBGImage()
        configTable()
        setupIndicator()
        checkSport()
        viewModel.getTeamDetails()
    }
    private func setupViewModel(){
        viewModel.bindResultToViewController = {
            self.logoImgView.kf.setImage(with: URL(string: self.viewModel.team[0].teamLogo ?? ""), placeholder: UIImage(named: "teamLogo"))
            self.teamNameLabel.text = self.viewModel.team[0].teamName
            let coachName = self.viewModel.team[0].coaches?[0].coachName ?? ""
            if coachName == "" {
                self.coachNameLabel.text = coachName
            }else {
                self.coachNameLabel.text = "Coach: \(coachName)"
            }
            self.playersTableView.reloadData()
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
        }
        viewModel.noResultFound = {
#warning("Add no result photo")
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
        }
    }
    private func configTable(){
        playersTableView.delegate = self
        playersTableView.dataSource = self
        let nib = UINib(nibName: "PlayerCell", bundle: nil)
        playersTableView.register(nib, forCellReuseIdentifier: "PlayerCell")
    }
    
    private func addGradientToBGImage(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imgViewBG.bounds
        gradientLayer.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.locations = [0.0, 0.2, 0.8, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        imgViewBG.layer.addSublayer(gradientLayer)
    }
    private func checkSport(){
        switch viewModel.getSportType() {
        case .football:
            imgViewBG.image = UIImage(named: "footballBG")
        case .basketball:
            imgViewBG.image = UIImage(named: "basketballBG")
        case .cricket:
            imgViewBG.image = UIImage(named: "cricketBG")
        case .tennis:
            imgViewBG.image = UIImage(named: "tennisBG")
        }
    }
    private func setupIndicator(){
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    //MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPlayersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        cell.setupCell(player: viewModel.getPlayer(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
