import UIKit
import SwiftUI

class ScheduleOptionsTableViewController: UITableViewController {

    // MARK: - initialise elements
    private let headersNameArray = ["날짜와 시간", "자격증 정보", "주의 사항", "색상", "알람"]

    var cellNamesArray = [["날짜", "시간"],
                         ["자격증명", "공인/사설", "시험 소요시간", "시험 장소"],
                         ["주의사항"],
                         ["106BFF"],
                         ["7일마다 알람 반복 여부"]
    ]
    
    var scheduleModel = ScheduleRealmModel()
    var editMode = false
    var scheduleDate: Date?
    var scheduleTime: Date?
    var scheduleWeekDay = Int()
    var scheduleRepeat = true


    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "시험 일정 추가하기"
        setupTableView()
                
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped))
    }
    
    
    // Actions-Targets
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.bounces = false

        tableView.separatorStyle = .none
        
        tableView.register(
            OptionsTableViewCell.self,
            forCellReuseIdentifier: String(describing: OptionsTableViewCell.self))
        
        tableView.register(
            HeadersTableViewCell.self,
            forHeaderFooterViewReuseIdentifier: String(describing: HeadersTableViewCell.self))
    }
    
    
    @objc
    private func saveButtonTapped(){
        if
            scheduleDate == nil ||
            scheduleTime == nil ||
            cellNamesArray[1][0] == "자격증 정보" {
            
                alertSuccessSave(title: "오류", message: "정보를 채워주세요: 날짜와 시간, 자격증 정보 등")
        } else {
            
            switch editMode {
            case false:
                setModel()

                RealmManager.shared.saveScheduleModel(model: scheduleModel)
                scheduleModel = ScheduleRealmModel()
                cellNamesArray = [["날짜", "시간"],
                                  ["자격증명", "공인/사설", "시험 소요시간", "시험 장소"],
                                  ["주의사항"],
                                  ["106BFF"],
                                  ["7일마다 알람 반복 여부"]
             ]

                alertSuccessSave(title: "저장 성공", message: nil)
                tableView.reloadData()
                
            case true:

                RealmManager.shared.editScheduleModel(
                    model: scheduleModel,
                    nameArray: cellNamesArray,
                    date: scheduleDate,
                    time: scheduleTime,
                    weekDay: scheduleWeekDay,
                    isRepeat: scheduleRepeat)
                
                scheduleModel = ScheduleRealmModel()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    private func setModel(){
        scheduleModel.scheduleDate = scheduleDate
        scheduleModel.scheduleTime = scheduleTime
        scheduleModel.scheduleWeekday = scheduleWeekDay
        scheduleModel.scheduleRepeat = scheduleRepeat

        scheduleModel.scheduleName = cellNamesArray[1][0]
        scheduleModel.scheduleType = cellNamesArray[1][1]
        scheduleModel.scheduleBuilding = cellNamesArray[1][2]
        scheduleModel.scheduleAudience = cellNamesArray[1][3]
        scheduleModel.scheduleTeacher = cellNamesArray[2][0]
        scheduleModel.scheduleColor = cellNamesArray[3][0]
    }

    private func pushToTeacherViewController(){
        let cell = tableView.cellForRow(at: [2,0]) as! OptionsTableViewCell

        navigationController?.navigationBar.topItem?.title = "Options"
        
    }

    private func pushToColorsViewController(){
        let vc = ColorsViewController()
        vc.outputColor = { [weak self] color in
            self?.cellNamesArray[3][0] = color
            self?.tableView.reloadRows(at: [[3,0],[4,0]], with: .none)
        }
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func switchRepeatState(value: Bool) {
        scheduleRepeat = value
    }
    
    private func pushViewController(vc: UIViewController){
        let vc = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    // TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return cellNamesArray[0].count
        case 1: return cellNamesArray[1].count
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OptionsTableViewCell.self), for: indexPath) as! OptionsTableViewCell
        
        cell.cellScheduleConfigure(namesArray: cellNamesArray,
                                   indexPath: indexPath,
                                   color: cellNamesArray[3][0],
                                   isEdit: editMode,
                                   isRepeat: scheduleRepeat)
        
        cell.switchStateOutput = { [weak self] switchState in
            self?.switchRepeatState(value: switchState)
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 20
    }
    
    
    //TableView (Header)
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HeadersTableViewCell.self)) as! HeadersTableViewCell
        
        header.headerCellConfigure(nameArray: headersNameArray, section: section)
        return header
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    
    //TableView (DidSelect)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell

        switch indexPath {
        case [0,0]: alertDate(label: cell.nameCellLabel) { numberOfWeekday, date in
            self.scheduleDate = date
            self.scheduleWeekDay = numberOfWeekday
        }
        case [0,1]: alertTime(label: cell.nameCellLabel) { time in
            self.scheduleTime = time
        }
        case [1,0]: alertForCellName(
            label: cell.nameCellLabel,
            name: "자격증명",
            placeholder: "자격증명을 입력하세요.") { text in
                self.cellNamesArray[1][0] = text
            }
        case [1,1]: alertForCellName(
            label: cell.nameCellLabel,
            name: "공인/사설",
            placeholder: "공인 또는 사설 유형을 입력하세요.") { text in
                self.cellNamesArray[1][1] = text
            }
        case [1,2]: alertForCellName(
            label: cell.nameCellLabel,
            name: "시험 소요시간",
            placeholder: "시험 소요시간을 입력하세요.") { text in
                self.cellNamesArray[1][2] = text
            }

        case [1,3]: alertForCellName(
            label: cell.nameCellLabel,
            name: "시험 장소",
            placeholder: "시험 장소를 입력하세요.") { text in
                self.cellNamesArray[1][3] = text
            }

        case [2,0]: alertForCellName(label: cell.nameCellLabel, name: "주의 사항", placeholder: "숙지해야하는 주의사항을 입력하세요.") {_ in
            
        }
        case [3,0]:
            pushToColorsViewController()
        default:
            print("")
        }
    }
}
