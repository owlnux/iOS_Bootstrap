//
//  CollectionViewAdapter.swift
//  iOS_Bootstrap
//
//  Created by Ahmad Mahmoud on 6/12/18.
//

import UIKit


open class CollectionViewAdapter : NSObject {
    
    
    private final var mCollectionview : UICollectionView!
    private final var collectionViewDataSource: [Any]!
    private final var mNibClass : BaseCollectionViewCell.Type!
    fileprivate final var mDelegate : CollectionViewDelegates!
    
    public final func configureCollectionviewWithXibCell (collectionView: UICollectionView,
                                                 dataSource: [Any]!,
                                                 nibClass : BaseCollectionViewCell.Type!,
                                                 delegate : CollectionViewDelegates) {
        //
        self.mNibClass = nibClass
        mCollectionview?.register(cellClass: mNibClass.self)
        configureCollectionView(collectionView: collectionView, dataSource: dataSource, delegate: delegate)
    }
    
    public final func configureCollectionviewWithStoryboardCell (collectionView: UICollectionView,
                                                        dataSource: [Any],
                                                        nibClass : BaseCollectionViewCell.Type!,
                                                        delegate : CollectionViewDelegates) {
        //
        configureCollectionView(collectionView: collectionView, dataSource: dataSource, delegate: delegate)
    }
    
    private final func configureCollectionView (collectionView: UICollectionView,
                                       dataSource: [Any],
                                       delegate : CollectionViewDelegates) {
        self.collectionViewDataSource = dataSource
        self.mCollectionview = collectionView
        self.mDelegate = delegate
        //
        mCollectionview?.register(cellClass: mNibClass.self)
        mCollectionview?.dataSource = self
        mCollectionview?.delegate = self
        //
        mCollectionview.emptyDataSetDelegate = self
        mCollectionview.emptyDataSetSource = self
        //
        mDelegate.configureAdditionalCollectionViewProperties?(collectionView: collectionView)
    }
    // Pull to refresh configuration
    public func configurePullToRefresh(refreshControl : UIRefreshControl) {
        mDelegate?.configurePullToRefresh?(refreshcontrole: refreshControl)
        refreshControl.addTarget(self, action:
            #selector(self.pullToRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        mCollectionview?.addSubview(refreshControl)
    }
    // Pull to refresh action
    @objc private func pullToRefresh (_ refreshControl: UIRefreshControl) {
        mDelegate?.pullToRefresh?(refreshcontrole: refreshControl)
    }
    
    public final func reloadCollectionView(dataSource:[Any]) {
        self.collectionViewDataSource = dataSource
        mCollectionview?.reloadData()
    }
}

extension CollectionViewAdapter : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // CollectionView callbacks
    //
    // Configure number of rows/sections
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (mDelegate?.configureNumberOfItemsInSection?(section: section)) != nil {
            return (mDelegate?.configureNumberOfItemsInSection!(section: section))!
        }
        else if (collectionViewDataSource != nil && (collectionViewDataSource?.count)! > 0) {
            return (collectionViewDataSource?.count)!
        }
        return 0
    }
    // Configure number of sections
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (mDelegate?.configureNumberOfSections?()) ?? 1
    }
    // Configure cell dimensions (width & height)
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (mDelegate?.sizeForItemAtIndexPath?(collectionViewLayout: collectionViewLayout)) != nil {
            return(mDelegate?.sizeForItemAtIndexPath?(collectionViewLayout: collectionViewLayout))! }
        // 2 cells per row
        let cellWidth = Float(UIScreen.main.bounds.size.width / 2.0)
        // Replace the divisor with the column count requirement. Make sure to have it in float.
        return CGSize(width: CGFloat(cellWidth), height: CGFloat(cellWidth))
    }
    // Configure cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (mDelegate?.configureCell(cellForRowAt: indexPath))!
    }
    // item did selected at index
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mDelegate?.itemDidSelected?(indexPath: indexPath)
    }
    // Pagination
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        mDelegate?.loadMore?(indexPath: indexPath)
    }
}

extension CollectionViewAdapter : EmptyDataSetSource, EmptyDataSetDelegate {
    //
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return (mDelegate?.emptyDataSetShouldDisplay?()) ?? false
    }
    
    public func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return (mDelegate?.emptyDataSetTitleText?())
    }
    
    public func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return (mDelegate?.emptyDataSetDescriptionText?())
        
    }
    public func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return (mDelegate?.emptyDataSetImage?())
    }
    
    public func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        mDelegate?.emptyDataSetClicked?(didTap: view)
    }
    
    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return (mDelegate?.emptyDataSetAllowTouch?()) ?? true
    }
    
    public func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        return (mDelegate?.emptyDataSetCustomView?())
    }
    
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return (mDelegate?.emptyDataSetBackgroundColor?())
    }
    
    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView) -> CAAnimation? {
        return (mDelegate?.emptyDataSetAnimatedImage?())
    }
    
    public func buttonImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> UIImage? {
        return (mDelegate?.emptyDataSetButtonImage?())
    }
    
    public func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> UIImage? {
        return (mDelegate?.emptyDataSetButtonBackgroundImage?())
    }
    
    public func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
        return (mDelegate?.emptyDataSetButtonLabel?())
    }
    
    public func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        mDelegate?.emptyDataSetButtonTapped?(didTapButton: button)
    }
}

