import UIKit

protocol OutputCalendarDataProtocol: AnyObject{
    func outputChangeHeight(height: CGFloat)
    func outputDidSelectDate(date: Date)
}
