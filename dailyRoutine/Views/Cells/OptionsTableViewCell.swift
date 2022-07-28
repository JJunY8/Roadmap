import UIKit

class OptionsTableViewCell: UITableViewCell {

    // initialise elements
    var switchStateOutput: ((Bool)->())?

    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray2
        return label
    }()
    
    let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.addTarget(self, action: #selector(repeatSwitchChange), for: .valueChanged)
        return repeatSwitch
    }()
    
    // life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    // private methods
    private func setupView(){
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(backgroundViewCell)
        addSubview(nameCellLabel)
        addSubview(repeatSwitch)
    }
    
    @objc
    private func repeatSwitchChange(paramTarget: UISwitch){
        guard let switchStateOutput = switchStateOutput else {return}
        switchStateOutput(paramTarget.isOn)
    }
}

// ScheduleViewController
extension OptionsTableViewCell {
    
    private func setupForScheduleVC(namesArray: [[String]], indexPath: IndexPath, color: String, isEdit: Bool, isRepeat: Bool){
        nameCellLabel.text = namesArray[indexPath.section][indexPath.row]
        !isEdit ? (nameCellLabel.textColor = .systemGray2) : (nameCellLabel.textColor = .black)

        
        let color = UIColor().colorFromHex(color)
        repeatSwitch.onTintColor = color
        
        switch indexPath.section {
        case 0...2:
            repeatSwitch.isHidden = true
            backgroundViewCell.backgroundColor = .white
        case 3:
            backgroundViewCell.backgroundColor = color
            nameCellLabel.textColor = .clear
            repeatSwitch.isHidden = true
        case 4:
            backgroundViewCell.backgroundColor = .white
            nameCellLabel.textColor = .black
            !isEdit ? (repeatSwitch.isOn = true) : (repeatSwitch.isOn = isRepeat)
            repeatSwitch.isHidden = false
        default:
            break
        }
    }
    
    func cellScheduleConfigure(namesArray: [[String]], indexPath: IndexPath, color: String, isEdit: Bool, isRepeat: Bool){
        setupForScheduleVC(namesArray: namesArray, indexPath: indexPath, color: color, isEdit: isEdit, isRepeat: isRepeat)
    }
}
// constraints
extension OptionsTableViewCell {

    private func setConstraints(){
        let constraints = [
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15),
            
            repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeatSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


