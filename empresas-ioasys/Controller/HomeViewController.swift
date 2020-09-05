//
//  HomeViewController.swift
//  empresas-ioasys
//
//  Created by Mateus Fernandes on 03/09/20.
//  Copyright © 2020 Mateus Fernandes. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var companies:[Companies] = []
    var headers:Dictionary<String, Any> = [:]
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Pesquise por empresa"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        DispatchQueue.main.async {
            CompaniesApi.filterEnterpriseCompanies(userHeaders: self.headers, onComplete: { (companies) in
                self.companies = companies
            
            }) { (error) in
                print(error)
            }
        }
    }
    
}


extension HomeViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
  }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "cellCompaniesDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellCompaniesDetail" {
            let viewDestination = segue.destination as! CompaniesDetailViewController
            viewDestination.companies = self.companies
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = companies[indexPath.row].enterprise_name
        return cell
    }
}

