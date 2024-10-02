//
//  HolidayHeaderView.swift
//  GujaratiCalendar
//
//  Created by iMac on 08/11/23.
//

import UIKit

class TopHeadlineHeaderView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        // Initial Code
        
        self.setInitialLayout()
    }
    
    func setInitialLayout() {
        Bundle.main.loadNibNamed("TopHeadlineHeaderView", owner: self, options: nil)
        self.contentView.isOpaque = false
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
    }

}
