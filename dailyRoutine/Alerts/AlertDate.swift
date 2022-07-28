import UIKit

extension UIViewController {
    
    func alertDate(label: UILabel, completion: @escaping (Int, Date)->()) {
        
        let alert = UIAlertController(
            title: "",
            message: nil,
            preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.preferredDatePickerStyle = .wheels
        
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(
            title: "저장하기",
            style: .default) { (action) in
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.mm.dd"
                dateFormatter.locale = Locale(identifier: "ko_KR")
                let dateString = dateFormatter.string(from: datePicker.date)
                
                let calendar = Calendar.current
                
                let component = calendar.dateComponents([.weekday], from: datePicker.date)
                guard let weekday = component.weekday else {return}
                
                let date = datePicker.date
                
                completion(weekday, date)
                
                label.textColor = .black
                label.text = dateString
            }
        
        let cancel = UIAlertAction(
            title: "취소하기",
            style: .destructive)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.negativeWidthConstraint()

        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        present(alert, animated: true)
    }
}
