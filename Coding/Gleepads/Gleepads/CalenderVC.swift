//
//  CalenderVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 04/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import CVCalendar

class CalenderVC: UIViewController, CVCalendarViewDelegate,CVCalendarMenuViewDelegate {
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }
    

    @IBOutlet weak var calendarMenu: CVCalendarMenuView!
    
    @IBOutlet weak var calendarView: CVCalendarView!
    
    @IBOutlet weak var BGView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.delegate = self
        calendarMenu.delegate = self
       
        let exitTap = UITapGestureRecognizer(target: self, action: #selector(exit))
        BGView.addGestureRecognizer(exitTap)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarMenu.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    @objc func exit(recog : UIGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }

}
