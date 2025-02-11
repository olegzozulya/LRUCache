//
//  ViewController.swift
//  GitLessonTerminal
//
//  Created by Oleg Zozulia on 09.02.2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let cache = LRUCache<Int>(capacity: 5)
        cache.append(2)
        cache.append(3)
        cache.append(2)
        cache.append(3)
        cache.append(4)
        cache.append(5)
        cache.append(6)
        cache.append(7)
        cache.append(3)
        
        print("get \(String(describing: cache.getValue(5)?.value))")
        print("get \(String(describing: cache.getValue(4)?.value))")
        print("get \(String(describing: cache.getValue(11)?.value))")
        
        cache.clear()
        
        cache.append(3)
        cache.append(4)
        cache.append(5)
        cache.append(6)
        cache.append(7)
        cache.append(3)
    }
}

