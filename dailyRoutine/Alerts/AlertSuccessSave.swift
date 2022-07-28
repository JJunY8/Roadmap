import UIKit

extension UIViewController {
    
    func alertSuccessSave(title: String, message: String?) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let ok = UIAlertAction(
            title: "저장하였습니다.",
            style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
