//
//  StudyEditorMain.swift
//  RoadMap
//
//  Created by 박지윤 on 2022/07/29.
//

import UIKit
import FMDB

class StudyEditorMain : UIViewController {
    
    var databasePath = String()
    var inputScore = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initDB()
    }


    func initDB(){
        
        let fileMgr = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        
        databasePath = docDir + "/subject.db"
        
        
        if !fileMgr.fileExists(atPath: databasePath) {
            //디비 만들기
            let db = FMDatabase(path: databasePath)
            
            if db.open(){
                // 테이블을 만들기
                let subquery = "create table if not exists subject (id integer primary key autoincrement, subjectname text, score text);"
                let exprimentquery = "create table if not exists portfolio (id integer primary key autoincrement, pofolname text, startdate date, finishdate date);"
                
                if !db.executeStatements(subquery) || !db.executeStatements(exprimentquery) {
                    
                    NSLog("subject DB 생성 실패")
                    
                }else{
                    NSLog("subject DB 생성 성공")
                }
            }
        }else{
            NSLog("디비파일 있음")
        }
        
    }
}
