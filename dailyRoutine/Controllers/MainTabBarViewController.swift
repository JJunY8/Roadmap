import UIKit


// 하단 아이콘 관련 코드
class MainTabBarViewController: UITabBarController {

    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // private methods
    private func setupTabBar(){
        
        let scheduleViewController = createNavController(
            vc: ScheduleViewController(),
            itemName: "자격증 시험 일정 관리",
            itemImage: "calendar.badge.clock")
        
        viewControllers = [
            scheduleViewController
        ]
    }
    
    private func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(
            title: itemName,
            image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(
                top: 10,
                left: 0,
                bottom: 0,
                right: 0)),
            tag: 0)
        
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        
        return navController
    }
}

