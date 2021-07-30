//
//  SNSearchViewController.swift
//  SNMusic
//
//  Created by Darcy on 2021/7/18.
//

import Foundation
import YiCore

class SNSearchViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: UIScreenWidth, height: 200), style: UITableView.Style.plain)
    let searchBar = UISearchBar()
    
    var items : [SNYoutube]?
    
    let presenter = SNMusicNewJobPresenter<NoUse>()
    let searchPresenter  = SNSearchPresenter.presenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup()  {
        
        self.view.backgroundColor = .pageBgColor
        
        self.searchBar.frame = CGRect.init(x: 0, y: 0, width: UIScreenWidth - 150, height: 50)
        self.searchBar.placeholder = "搜索Youtube"
        self.searchBar.delegate = self
        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white

        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.lightGray
        self.navigationItem.titleView = self.searchBar
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(SNYoutubeCell.self, forCellReuseIdentifier: SNYoutubeCellID)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {

        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.request(keyword: text)
        }
        self.view.endEditing(true)
        self.searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SNYoutubeCellID, for: indexPath) as! SNYoutubeCell
        let ytb = self.items![indexPath.row]
        cell.fillWithData(music: ytb)        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ytb = self.items![indexPath.row]
        self.create(ytb: ytb)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if self.searchBar.isFirstResponder {
            self.searchBar.resignFirstResponder()
        }
        
    }
    
    func create(ytb : SNYoutube) {
        
        self.presenter.searchMusic(title: ytb.title, name: ytb.channelTitle, url: ytb.url)
            .done { success in
                UIUtils.showToast(message: "提交成功", duration: 2, level: .info)
        }.catch { err in
            if case SNError.commonError(let str) = err {
                UIUtils.showToast(message: str, duration: 2, level: .info)
            } else {
                UIUtils.showToast(message: "提交失败")
            }
        }
        
    }
    
    func request(keyword : String)  {
        
        self.searchPresenter
            .searchYoutube(keyWord: keyword).done { items in
                
                self.items = items
                self.tableView.reloadData {
                
                }
                            
        }.catch { err in
            if case SNError.commonError(let errStr ) = err {
                UIUtils.showToast(message: errStr)
            }
        }
        
    }
    
}
