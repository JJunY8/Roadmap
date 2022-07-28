import UIKit

class ColorsViewController: UITableViewController {

    // initialise elements
    private let headersNameArray = ["빨강색", "주황색", "노랑색", "초록색", "파랑색", "진한 파랑색", "보라색"]
    var outputColor: ((String)->())?

    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "이벤트 색상 선택하기"
        setupTableView()
    }
    
    
    // private methods
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.bounces = false
        tableView.separatorStyle = .none
        
        tableView.register(
            ColorsTableViewCell.self,
            forCellReuseIdentifier: String(describing: ColorsTableViewCell.self))
        
        
        tableView.register(
            HeadersTableViewCell.self,
            forHeaderFooterViewReuseIdentifier: String(describing: HeadersTableViewCell.self))
    }
    
    private func choseColor(color: String) {
        guard let outputColor = outputColor else {return}
        outputColor(color)
        self.navigationController?.popViewController(animated: true)
    }
}
    
// TableView
extension ColorsViewController{
    
    // Cells
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ColorsTableViewCell.self), for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: choseColor(color: "FC2B2D")
        case 1: choseColor(color: "FD8D0E")
        case 2: choseColor(color: "FECF0F")
        case 3: choseColor(color: "2ECC46")
        case 4: choseColor(color: "106BFF")
        case 5: choseColor(color: "0433FF")
        case 6: choseColor(color: "AF39EE")

        default:
            choseColor(color: "FFFFFF")
        }
    }
    
    // headers
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HeadersTableViewCell.self)) as! HeadersTableViewCell
        
        header.headerCellConfigure(nameArray: headersNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
