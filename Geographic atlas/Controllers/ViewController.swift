//
//  ViewController.swift
//  Geographic atlas
//
//  Created by Yessimkhan Zhumash on 13.05.2023.
//

import UIKit
import SnapKit



class ViewController: UIViewController {

    
    private var countries: [CountryElement] = [CountryElement]()
    private var countriesByContinent: [String: [CountryElement]] = [:]
    
    
    let headerView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.94)
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 91)
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: view.frame.height - 1, width: view.frame.width*3, height: 1)
        bottomBorder.backgroundColor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.36).cgColor
        view.layer.addSublayer(bottomBorder)
        return view
    }()
    
    let Title: UILabel = {
        let label = UILabel()
        label.text = "World countries"
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.textColor = .black
        return label
    }()
    
    private var myTableView: UITableView = {
        let myTableView = UITableView(frame: .zero, style: .grouped)
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        myTableView.register(ExpandedTableViewCell.self, forCellReuseIdentifier: ExpandedTableViewCell.identifier)
        myTableView.backgroundColor = .white
        myTableView.separatorStyle = .none
        return myTableView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.estimatedRowHeight = 216
        myTableView.rowHeight = UITableView.automaticDimension
        setUpView()
        setUpConstraints()
        APICaller.shared.getCountries{ [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let countries):
                    self?.countries = countries
                    self?.countriesByContinent = Dictionary(grouping: countries, by: { $0.continents.first ?? "" })
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.myTableView.reloadData()
            }
        }
    }
    
}


// MARK: - Setup Views and Constraints
extension ViewController{
    func setUpView(){
        view.addSubview(headerView)
        view.addSubview(Title)
        view.addSubview(myTableView)
    }
    func setUpConstraints(){
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(91)
        }
        Title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(59)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        myTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
    }
    
}


// MARK: - TableView DataSource and Delegate Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource   {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return countriesByContinent.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let continent = Array(countriesByContinent.keys.sorted())[section]
        return countriesByContinent[continent]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let continent = Array(countriesByContinent.keys.sorted())[section]
        return continent
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        header.textLabel?.textColor = UIColor(red: 0.67, green: 0.70, blue: 0.73, alpha: 1)
        header.textLabel?.text = header.textLabel?.text?.uppercased()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let continent = Array(countriesByContinent.keys.sorted())[indexPath.section]
        if let countriesInSection = countriesByContinent[continent], countriesInSection.count > indexPath.row {
            let country = countriesInSection[indexPath.row]
            return country.isExpanded ?? false ? 216 : 84
        }
        return 84
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let continent = Array(countriesByContinent.keys.sorted())[indexPath.section]
        if let countriesInSection = countriesByContinent[continent], countriesInSection.count > indexPath.row {
            let country = countriesInSection[indexPath.row]
            if country.isExpanded ?? false {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExpandedTableViewCell.identifier, for: indexPath) as! ExpandedTableViewCell
                cell.configure(with: country)
                cell.delegate = self
                cell.backgroundColor = .white
                cell.selectionStyle = .none
                print(cell.isSelected)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
                cell.configure(with: country)
                cell.delegate = self
                cell.backgroundColor = .white
                cell.selectionStyle = .none
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
}


//MARK: - functions for expanded cell and navigationcontroller
extension ViewController: CustomTableViewCellDelegate {
    func cellDidToggleExpansion(_ cell: CustomTableViewCell) {
        guard let indexPath = myTableView.indexPath(for: cell) else { return }
        let continent = Array(countriesByContinent.keys.sorted())[indexPath.section]
        if var countriesInSection = countriesByContinent[continent] {
            var country = countriesInSection[indexPath.row]
            country.isExpanded = !(country.isExpanded ?? false)
            countriesInSection[indexPath.row] = country
            countriesByContinent[continent] = countriesInSection
            myTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
extension ViewController: ExpandedTableViewCellDelegate {
    func nextView(_ cell: ExpandedTableViewCell, viewModel: CountryDetail) {
        DispatchQueue.main.async { [weak self] in
            let vc = CountryDetalisViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func cellDidToggleExpansion(_ cell: ExpandedTableViewCell) {
        guard let indexPath = myTableView.indexPath(for: cell) else { return }
        let continent = Array(countriesByContinent.keys.sorted())[indexPath.section]
        if var countriesInSection = countriesByContinent[continent] {
            var country = countriesInSection[indexPath.row]
            country.isExpanded = !(country.isExpanded ?? false)
            countriesInSection[indexPath.row] = country
            countriesByContinent[continent] = countriesInSection
            myTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}





