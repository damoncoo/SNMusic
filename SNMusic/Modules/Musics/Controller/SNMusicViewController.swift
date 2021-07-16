//
//  SNMusicViewController.swift
//  SNMusic
//
//  Created by Darcy on 2021/6/2.
//

import YiCore
import Alamofire
import AMMusicPlayerController

class SNMusicViewController: SNWrapTableViewController <SNMusic>, AMMusicPlayerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .pageBgColor
        self.setup()
    }
    
    func setup()  {
        self.title = "音乐"
        self.tableViewInfo?.refresh()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem( title: "搜索", style: .plain,
                                                                  target: self, action: #selector(didiHitSearch))
    }
    
    override func registerCells() -> [WrapTableCell] {
        return [
            WrapTableCell(reuseId: SNMusicCellID, isNib: false, type: SNMusicCell.self, nib: nil)
        ]
    }
    
    override func makeRequest(page: NSInteger, limit: NSInteger) -> DataRequest? {
        ApiClient.shared.makeRequest(path: "/api/v2/music/song", method: .get, data: nil)
    }
    
    override func cellForItemIn(item: SNMusic, indexPath: IndexPath? = nil) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: SNMusicCellID, for: indexPath!) as! SNMusicCell
        cell.fillWithData(music: item)
        return cell
    }
    
    override func didSelectRow(item: SNMusic) {
        
        let urls = [ URL(string: item.url)! ]
        let modal = AMMusicPlayerController.make(urls: urls,
                                                 index: 0)
        modal?.delegate = self
        modal?.presentPlayer(src: self)
        
    }
    
    // MARK: -
    @objc func didiHitSearch()  {
        
    }
    
    func musicPlayerControllerDidDismissByTap() {
        
    }
    
    func musicPlayerControllerDidDismissBySwipe() {
        
    }
    
    func musicPlayerControllerDidFail(controller: AMMusicPlayerController?, err: AMMusicPlayerError) {
        
    }
    
}
