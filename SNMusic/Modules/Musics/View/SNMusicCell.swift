//
//  SNMusicCell.swift
//  SNMusic
//
//  Created by Darcy on 2021/7/12.
//

import YiCore
import Kingfisher

public let SNMusicCellID = "SNMusicCellID"

class SNMusicCell: SNBaseTableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.mainTextColor
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.subTextColor
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .green
        
        self.setup()
    }
    
    func setup() {
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.timeLabel)
    
        self.titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.contentView.snp.left).offset(15)
            maker.top.equalTo(self.contentView.snp.top).offset(12)
            maker.right.equalTo(self.contentView.snp.right).offset(-15)
        }
        
        self.timeLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.titleLabel.snp.left).offset(0)
            maker.top.equalTo(self.titleLabel.snp.bottom).offset(12)
            maker.height.equalTo(14)
            maker.right.equalTo(self.contentView.snp.right).offset(-12)
            maker.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
        }
        
    }
    
    func fillWithData(music: SNMusic) {
        
        self.titleLabel.text = music.name
        
        self.timeLabel.text = music.created_time?.toZZZDate()?.toDateString()
        
    }
    
}
