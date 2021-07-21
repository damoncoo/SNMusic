//
//  SNMusicViewController.swift
//  SNMusic
//
//  Created by Darcy on 2021/6/2.
//

import YiCore
import Alamofire
import AMMusicPlayerController

class SNMusicViewController: SNWrapTableViewController <SNMusic>, AMMusicPlayerDelegate, UISearchBarDelegate {
    
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .pageBgColor
        self.setup()
    }
    
    func setup()  {
        self.title = "音乐"
        self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: self.view.safeAreaEdges().bottom, right: 0)
        
        self.tableViewInfo?.refresh()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem( title: "搜索", style: .plain,
                                                                  target: self, action: #selector(didiHitSearch))
        
        self.searchBar.placeholder = "搜索Youtube"
        self.searchBar.delegate = self
        self.tableView.showsVerticalScrollIndicator = false
        self.searchBar.frame = CGRect.init(x: 0, y: 0, width: UIScreenWidth, height: 50)
        self.tableView.tableHeaderView = self.searchBar
    }
    
    override func registerCells() -> [WrapTableCell] {
        return [
            WrapTableCell(reuseId: SNMusicCellID, isNib: false, type: SNMusicCell.self, nib: nil)
        ]
    }
    
    override func makeRequest(page: NSInteger, limit: NSInteger) -> DataRequest? {
        ApiClient.shared.makeRequest(path: "/api/v2/music/song", method: .get, data: [
            "page" : page
        ])
    }
    
    override func cellForItemIn(item: SNMusic, indexPath: IndexPath? = nil) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: SNMusicCellID, for: indexPath!) as! SNMusicCell
        cell.fillWithData(music: item)
        return cell
    }
    
    
    override func didSelectRow(item: SNMusic) {
                
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }

        self.tableView.deselectRow(at: indexPath, animated: false)
        
        let urls = [ URL(string: item.url)! ]
        let modal = AMMusicPlayerController.make(urls: urls,
                                                 index: 0)
        modal?.delegate = self
        modal?.presentPlayer(src: self)
        
    }
    
    // MARK: -
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        self.goToSearch()        
        return false
    }
    
    func goToSearch()  {
        
        let search = SNSearchViewController()
        self.navigationController?.pushViewController(search)
    }
    
    
    override func onDataFresh() {
        
        DispatchQueue.main.async {
            self.tableViewInfo?.footerState = .none
            super.onDataFresh()
        }
    }
    
    // MARK: -
    @objc func didiHitSearch()  {
        
        let search = SNJobNewViewController()
        self.navigationController?.pushViewController(search)        
    }
    
    func musicPlayerControllerDidDismissByTap() {
        
    }
    
    func musicPlayerControllerDidDismissBySwipe() {
        
    }
    
    func musicPlayerControllerDidFail(controller: AMMusicPlayerController?, err: AMMusicPlayerError) {
        
    }
    
}
