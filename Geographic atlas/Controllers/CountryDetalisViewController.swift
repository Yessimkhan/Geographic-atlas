//
//  CountryDetailsView.swift
//  Geographic atlas
//
//  Created by Yessimkhan Zhumash on 16.05.2023.
//


import UIKit
import SnapKit

class CountryDetalisViewController: UIViewController {
    
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
        label.text = "Kazakstan"
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.textColor = .black
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize = CGSize(width: scrollView.frame.width , height: 800)
        return scrollView
    }()
    
    let FlagImage:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "kaz")
        imageView.image = image
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let Region: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "circle.fill")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.setTitle("   Region:", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00), for: .normal)
        return button
    }()
    let RegionData: UILabel = {
        let label = UILabel()
        label.text = "Asia"
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
    let Capital: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "circle.fill")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.setTitle("   Capital:", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00), for: .normal)
        return button
    }()
    let CapitalData: UILabel = {
        let label = UILabel()
        label.text = "Nur Sultan"
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
    let CapitalCoordinates: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "circle.fill")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.setTitle("   Capital coordinates:", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00), for: .normal)
        return button
    }()
    
    let CapitalCoordinatesData: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
    
    
    let Population: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "circle.fill")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.setTitle("   Population:", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00), for: .normal)
        return button
    }()
    let PopulationData: UILabel = {
        let label = UILabel()
        label.text = "19 mln"
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
    let Area: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "circle.fill")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.setTitle("   Area:", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00), for: .normal)
        return button
    }()
    let AreaData: UILabel = {
        let label = UILabel()
        label.text = "2 724 900 km^2"
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
    let Currency: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "circle.fill")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.setTitle("   Currency:", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00), for: .normal)
        return button
    }()
    let CurrencyData: UILabel = {
        let label = UILabel()
        label.text = "Tenge (KZT)"
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
    let Timezones: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "circle.fill")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.setTitle("   Timezones:", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00), for: .normal)
        return button
    }()
    let TimezonesData: UILabel = {
        let label = UILabel()
        label.text = "GMT+6"
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.imageView?.tintColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 20)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
// MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setUpView()
        setUpConstraints()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    func configure(with country: CountryDetail){
        Title.text = country.name.common
        guard let url = URL(string: country.flags?.png ?? "") else {
            return
        }
        FlagImage.sd_setImage(with: url, completed: nil)
        RegionData.text = country.subregion
        CapitalData.text = country.capital[0]
        CapitalCoordinatesData.text = "\(country.capitalInfo.latlng[0]), \(country.capitalInfo.latlng[1])"
        PopulationData.text = String(country.population)
        AreaData.text = String(country.area)
        var curName:String = ""
        if let currencies = country.currencies {
            // Iterate through the currency dictionary
            for (_, currency) in currencies {
                if let currencyName = currency.name {
                    // Use the currency name
                    curName = curName + " \(currencyName)"
                }
            }
        } else {
            // The country doesn't have currency data
            print("No currency data available")
        }
        CurrencyData.text = curName
        TimezonesData.text = country.timezones[0]
    }
    

    
}
// MARK: - Setup Views and Constraints
extension CountryDetalisViewController {
    func setUpView(){
        view.addSubview(headerView)
        view.addSubview(Title)
        view.addSubview(scrollView)
        view.addSubview(backButton)
        scrollView.addSubview(FlagImage)
        scrollView.addSubview(Region)
        scrollView.addSubview(RegionData)
        scrollView.addSubview(Capital)
        scrollView.addSubview(CapitalData)
        scrollView.addSubview(CapitalCoordinates)
        scrollView.addSubview(CapitalCoordinatesData)
        scrollView.addSubview(Population)
        scrollView.addSubview(PopulationData)
        scrollView.addSubview(Area)
        scrollView.addSubview(AreaData)
        scrollView.addSubview(Currency)
        scrollView.addSubview(CurrencyData)
        scrollView.addSubview(Timezones)
        scrollView.addSubview(TimezonesData)
        
    }
    func setUpConstraints(){
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(91)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.leading.equalToSuperview().inset(20)
//            make.height.width.equalTo(30)
        }
        
        Title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(59)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        FlagImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.height.equalTo(195)
            make.width.equalTo(370)
            make.centerX.equalToSuperview()
        }
        Region.snp.makeConstraints { make in
            make.top.equalTo(FlagImage.snp.bottom).inset(-20)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(10)
        }
        RegionData.snp.makeConstraints { make in
            make.top.equalTo(Region.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(24)
        }
        Capital.snp.makeConstraints { make in
            make.top.equalTo(RegionData.snp.bottom).inset(-24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(10)
        }
        CapitalData.snp.makeConstraints { make in
            make.top.equalTo(Capital.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(24)
        }
        CapitalCoordinates.snp.makeConstraints { make in
            make.top.equalTo(CapitalData.snp.bottom).inset(-24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(10)
        }
        CapitalCoordinatesData.snp.makeConstraints { make in
            make.top.equalTo(CapitalCoordinates.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(24)
        }
        Population.snp.makeConstraints { make in
            make.top.equalTo(CapitalCoordinatesData.snp.bottom).inset(-24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(10)
        }
        PopulationData.snp.makeConstraints { make in
            make.top.equalTo(Population.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(24)
        }
        Area.snp.makeConstraints { make in
            make.top.equalTo(PopulationData.snp.bottom).inset(-24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(10)
        }
        AreaData.snp.makeConstraints { make in
            make.top.equalTo(Area.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(24)
        }
        Currency.snp.makeConstraints { make in
            make.top.equalTo(AreaData.snp.bottom).inset(-24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(10)
        }
        CurrencyData.snp.makeConstraints { make in
            make.top.equalTo(Currency.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(24)
        }
        Timezones.snp.makeConstraints { make in
            make.top.equalTo(CurrencyData.snp.bottom).inset(-24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(10)
        }
        TimezonesData.snp.makeConstraints { make in
            make.top.equalTo(Timezones.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(24)
        }
        
    }
}

