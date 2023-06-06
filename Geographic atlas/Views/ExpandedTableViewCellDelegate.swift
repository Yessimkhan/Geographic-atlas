//
//  ExpandedTableViewCellDelegate.swift
//  Geographic atlas
//
//  Created by Yessimkhan Zhumash on 06.06.2023.
//

import UIKit
import SDWebImage


protocol ExpandedTableViewCellDelegate: AnyObject {
    func cellDidToggleExpansion(_ cell: ExpandedTableViewCell)
    func nextView(_ cell: ExpandedTableViewCell,viewModel: CountryDetail)
}

class ExpandedTableViewCell: UITableViewCell {
    static let identifier = "ExpandedTableViewCell"
    var isExpanded: Bool = false
    weak var delegate: ExpandedTableViewCellDelegate?
    var countryCode: String = ""
    
    let FlagImage:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "kaz")
        imageView.image = image
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let countryName:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.textColor = .black
        return label
    }()
    
    let cityName:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textColor = .black
        return label
    }()
    let Population:UILabel = {
        let label = UILabel()
        label.text = "Population:"
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.0)
        return label
    }()
    let PopulationData:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    let Area:UILabel = {
        let label = UILabel()
        label.text = "Area:"
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.0)
        return label
    }()
    let AreaData:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    let Currencies:UILabel = {
        let label = UILabel()
        label.text = "Currencies:"
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.0)
        return label
    }()
    let CurrenciesData:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    var seeLessButton: UIButton = {
        var button = UIButton()
        var image = UIImage(systemName: "chevron.up")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(seeLessButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var LearnMore: UIButton = {
        let button = UIButton()
        button.setTitle("Learn more", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    @objc private func seeLessButtonTapped() {
        isExpanded.toggle()
        delegate?.cellDidToggleExpansion(self)
    }
    @objc private func learnMoreButtonTapped() {
        APICaller.shared.getCountryDetalis(with: countryCode){[weak self]
            result in
            switch result{
            case .success(let country):
                guard let strongSelf = self else{
                    return
                }
                let viewModel = country
                self?.delegate?.nextView(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1)
        contentView.layer.cornerRadius = 12
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public func configure(with country: CountryElement){
        countryName.text = country.name.common
        cityName.text = country.capital?[0]
        guard let url = URL(string: country.flags?.png ?? "") else {
            return
        }
        FlagImage.sd_setImage(with: url, completed: nil)
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
        CurrenciesData.text = curName
        countryCode = country.cca2
    }

}
extension ExpandedTableViewCell{
    func setUpView(){
        contentView.addSubview(FlagImage)
        contentView.addSubview(countryName)
        contentView.addSubview(cityName)
        contentView.addSubview(seeLessButton)
        contentView.addSubview(Population)
        contentView.addSubview(Area)
        contentView.addSubview(Currencies)
        contentView.addSubview(LearnMore)
        contentView.addSubview(PopulationData)
        contentView.addSubview(AreaData)
        contentView.addSubview(CurrenciesData)
        
    }
    func setUpConstraints(){
        FlagImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.width.equalTo(82)
            make.height.equalTo(48)
        }
        countryName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(106)
            make.height.equalTo(20)
            make.width.equalTo(189)
        }
        cityName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.equalToSuperview().inset(106)
            make.height.equalTo(16)
        }
        seeLessButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32.25)
            make.height.equalTo(7.5)
            make.width.equalTo(13.5)
            make.trailing.equalToSuperview().inset(35)
        }
        Population.snp.makeConstraints { make in
            make.top.equalTo(FlagImage.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(12)
            make.height.equalTo(18)
            make.width.equalTo(80)
        }
        PopulationData.snp.makeConstraints { make in
            make.top.equalTo(FlagImage.snp.bottom).inset(-12)
            make.leading.equalTo(Population.snp.trailing).inset(-4)
            make.height.equalTo(18)
            make.width.equalTo(235)
        }
        Area.snp.makeConstraints { make in
            make.top.equalTo(Population.snp.bottom).inset(-8)
            make.leading.equalToSuperview().inset(12)
            make.height.equalTo(18)
            make.width.equalTo(37)
        }
        AreaData.snp.makeConstraints { make in
            make.top.equalTo(Population.snp.bottom).inset(-8)
            make.leading.equalTo(Area.snp.trailing).inset(-4)
            make.height.equalTo(18)
            make.width.equalTo(278)
        }
        Currencies.snp.makeConstraints { make in
            make.top.equalTo(Area.snp.bottom).inset(-8)
            make.leading.equalToSuperview().inset(12)
            make.height.equalTo(18)
            make.width.equalTo(82)
        }
        CurrenciesData.snp.makeConstraints { make in
            make.top.equalTo(Area.snp.bottom).inset(-8)
            make.leading.equalTo(Currencies.snp.trailing).inset(-4)
            make.height.equalTo(18)
            make.width.equalTo(114)
        }
        LearnMore.snp.makeConstraints { make in
            make.top.equalTo(Currencies.snp.bottom).inset(-26)
            make.bottom.equalToSuperview().inset(26)
            make.width.equalTo(600)
            make.centerX.equalToSuperview()
            
        }
        
    }
}

