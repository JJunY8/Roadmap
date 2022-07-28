import UIKit

//정보 입력하고 나면 보이는 이벤트 관련 코드

class ScheduleTableViewCell: UITableViewCell {

    //  initialise elements
    private var topStackView = UIStackView()
    private var bottomStackView = UIStackView()

    private let lessonNameLabel = UILabel(
        text: "",
        font: UIFont.avenirNextDemiBold20())

    private let teacherNameLabel = UILabel(
        text: "",
        font: UIFont.avenirNext20(),
        alignment: .right)

    private let lessonTimeLabel = UILabel(
        text: "",
        font: UIFont.avenirNextDemiBold20())
    
    private let typeLabel = UILabel(
        text: "유형:",
        font: UIFont.avenirNext14(),
        alignment: .right)

    private let lessonTypeLabel = UILabel(
        text: "",
        font: UIFont.avenirNextDemiBold14())

    private let buildingLabel = UILabel(
        text: "소요시간:",
        font: UIFont.avenirNext14(),
        alignment: .right)

    private let lessonBuildingLabel = UILabel(
        text: "",
        font: UIFont.avenirNextDemiBold14())
 
    private let audienceLabel = UILabel(
        text: "시험장소",
        font: UIFont.avenirNext14(),
        alignment: .right)
 
    private let lessonAudienceLabel = UILabel(
        text: "",
        font: UIFont.avenirNextDemiBold14())

    // life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupStackViews()
        self.setupView()
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

        addSubview(topStackView)
        addSubview(lessonTimeLabel)
        addSubview(bottomStackView)
    }
    
    private func setupStackViews(){
        self.topStackView = UIStackView(
            arrangeSubviews: [lessonNameLabel,
                              teacherNameLabel],
            axis: .horizontal,
            spacing: 10,
            distribution: .fillEqually)
        
        self.bottomStackView = UIStackView(
            arrangeSubviews: [typeLabel,
                              lessonTypeLabel,
                              buildingLabel,
                              lessonBuildingLabel,
                              audienceLabel,
                              lessonAudienceLabel],
            axis: .horizontal,
            spacing: 5,
            distribution: .fillProportionally)
    }
    
    private func setupCell(model: ScheduleRealmModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        
        guard let time = model.scheduleTime else {return}
        
        lessonNameLabel.text = model.scheduleName
        teacherNameLabel.text = model.scheduleTeacher
        lessonTimeLabel.text = dateFormatter.string(from: time)
        lessonTypeLabel.text = model.scheduleType
        lessonBuildingLabel.text = model.scheduleBuilding
        lessonAudienceLabel.text = model.scheduleAudience
        backgroundColor = UIColor().colorFromHex("\(model.scheduleColor)")
    }
    
    // public methods
    func cellConfigure(model: ScheduleRealmModel) {
        setupCell(model: model)
    }
}

// constraints
extension ScheduleTableViewCell {
    
    private func setConstraints(){
        let constraints = [
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25),
            
            lessonTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            lessonTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            lessonTimeLabel.widthAnchor.constraint(equalToConstant: 100),
            lessonTimeLabel.heightAnchor.constraint(equalToConstant: 25),
            
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: lessonTimeLabel.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
