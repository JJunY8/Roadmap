import RealmSwift
import Realm

class RealmManager {
    
    static let shared = RealmManager()
    
    private init(){}
    
    let localRealm = try! Realm()
    
    //Schedule
    func saveScheduleModel(model: ScheduleRealmModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteScheduleModel(model: ScheduleRealmModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func editScheduleModel(model: ScheduleRealmModel, nameArray: [[String]], date: Date?, time: Date?, weekDay: Int, isRepeat: Bool) {
        try! localRealm.write {
            model.scheduleDate = date
            model.scheduleWeekday = weekDay
            model.scheduleTime = time
            model.scheduleName = nameArray[1][0]
            model.scheduleType = nameArray[1][1]
            model.scheduleBuilding = nameArray[1][2]
            model.scheduleAudience = nameArray[1][3]
            model.scheduleTeacher = nameArray[2][0]
            model.scheduleColor = nameArray[3][0]
            model.scheduleRepeat = isRepeat
        }
    }
}
