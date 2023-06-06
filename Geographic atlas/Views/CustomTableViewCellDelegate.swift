//
//  CustomTableViewCell.swift
//  First
//
//  Created by Yessimkhan Zhumash on 27.12.2022.
//

import UIKit
import SDWebImage


protocol CustomTableViewCellDelegate: AnyObject {
    func cellDidToggleExpansion(_ cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    var isExpanded: Bool = false
    weak var delegate: CustomTableViewCellDelegate?
    
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
    var seeMoreButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.down")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        
        button.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func seeMoreButtonTapped() {
        isExpanded.toggle()
        delegate?.cellDidToggleExpansion(self)
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
    }

}
extension CustomTableViewCell{
    func setUpView(){
        contentView.addSubview(FlagImage)
        contentView.addSubview(countryName)
        contentView.addSubview(cityName)
        contentView.addSubview(seeMoreButton)
        
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
        seeMoreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32.25)
            make.height.equalTo(7.5)
            make.width.equalTo(13.5)
            make.trailing.equalToSuperview().inset(35)
            
        }
        
    }
}


