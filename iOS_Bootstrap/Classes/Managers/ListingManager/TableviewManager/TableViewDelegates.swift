//
//  TableViewDelegates.swift
//  iOS_Bootstrap
//
//  Created by Ahmad Mahmoud on 6/8/18.
//
//  Empty Dataset library URL : https://github.com/Xiaoye220/EmptyDataSet-Swift?files=1


public protocol TableViewDelegates : TableViewOptionalDelegates {
    func configureCell (tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

@objc public protocol TableViewOptionalDelegates : CommonListingDelegates {
    @objc optional func configureNumberOfRowsPerSection(section : Int) -> Int
    @objc optional func rowDidSelected(indexPath : IndexPath)
    @objc optional func configureAdditionalTableProperties (table : UITableView)
}
