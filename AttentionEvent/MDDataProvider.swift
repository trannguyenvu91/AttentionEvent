//
//  MDDataProvider.swift
//  AttentionEvent
//
//  Created by VuVince on 1/18/18.
//  Copyright © 2018 VuVince. All rights reserved.
//

import UIKit

class MDDataProvider: NSObject, MDListProviderProtocol {
    var reloadNotification: (() -> Void)?
    var updatesNotification: (([IndexPath], [IndexPath], [IndexPath]) -> Void)?
    var items = [MDModelProtocol]()
    
    override init() {
        super.init()
        addData()
    }
    
    func model(at indexPath: IndexPath) -> MDModelProtocol? {
        return items[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return items.count
    }
    
    func addData() {
        let itemCount = items.count
        for i in itemCount..<itemCount + 20 {
            let model = MDModel(at: i)
            items.append(model)
        }
    }

}
