//
//  ViewController.swift
//  AttentionEvent
//
//  Created by VuVince on 1/18/18.
//  Copyright © 2018 VuVince. All rights reserved.
//

import UIKit

fileprivate struct UIConstant {
    let cellRatio = 0.3
    let cellInterSpace = 10.0
    let screenWidth = Double(UIScreen.main.bounds.size.width)
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: MDCollectionViewDataSource!
    let dataProvider = MDDataProvider()
    private let uiConstant = UIConstant()
    var isAdding = false
    
    @IBAction func invalidateClicked(_ sender: Any) {
        dataProvider.addData()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataSource = MDCollectionViewDataSource(collectionView: collectionView,
                                                owner: self,
                                                dataProvider: dataProvider,
                                                cellID: "Cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.collectionViewLayout = ReverseLayout()
        collectionView.collectionViewLayout.invalidateLayout()
        observeOffset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func observeOffset() {
        collectionView.addObserver(self, forKeyPath: "contentSize", options: [.new, .old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let _ = object as? UICollectionView,
            let old = change?[.oldKey] as? CGSize,
            let new = change?[.newKey] as? CGSize,
            new != old else {
            return
        }
        
        collectionView.setContentOffset(CGPoint(x: 0, y: collectionView.contentOffset.y + new.height - old.height + 1), animated: false)
    }
    
}

extension ViewController: MDCollectionViewDataSourceProtocol {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = uiConstant.cellRatio * uiConstant.screenWidth
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == dataProvider.items.count - 10 && !isAdding {
            isAdding = true
            perform(#selector(activeAdding), with: nil, afterDelay: 0.5)
        }
    }
    
    @objc func activeAdding() {
        dataProvider.addData()
        collectionView.reloadData()
        isAdding = false
    }
    
}
