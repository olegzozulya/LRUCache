//
//  ViewController.swift
//  GitLessonTerminal
//
//  Created by Oleg Zozulia on 09.02.2025.
//

import UIKit
import Foundation

class LRUCache<T: Hashable> {
    class DoubleLinkedListNode {
        var value: T
        var next: DoubleLinkedListNode?
        weak var prev: DoubleLinkedListNode?
        
        init(value: T, next: DoubleLinkedListNode? = nil, prev: DoubleLinkedListNode? = nil) {
            self.value = value
            self.next = next
            self.prev = prev
        }
        
        func printDescription() {
            print(value)
            next?.printDescription()
        }
        
        deinit {
            print ("deinit \(value)")
        }
    }
    
    var dict: [T: DoubleLinkedListNode] = [:]
    var head: DoubleLinkedListNode?
    var tail: DoubleLinkedListNode?
    var capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity > 0 ? capacity : 1
        printDescription()
        
    }
    
    func clear() {
        dict.removeAll()
        head = nil
        tail = nil
        printDescription()
    }
    
    func append(_ value: T) {
        if dict.isEmpty {
            let node = DoubleLinkedListNode(value: value)
            dict[value] = node
            head = node
            tail = head
        } else if let node = dict[value] {
            moveToead(node)
        } else {
            if dict.count == capacity {
                guard let tailValue = tail?.value else { return }
                dict.removeValue(forKey: tailValue)
                tail = tail?.prev
                tail?.next = nil
            }
            
            let node = DoubleLinkedListNode(value: value)
            dict[value] = node
            node.next = head
            head?.prev = node
            head = node

            
            
        }
        printDescription()
        
        
    }
    
    func getValue(_ value: T) -> DoubleLinkedListNode? {
        guard let node = dict[value] else { return nil }
        moveToead(node)
        return node
    }
    
    func moveToead(_ node: DoubleLinkedListNode) {
        if node === tail {
            tail = node.prev
        }
        
        let prev: DoubleLinkedListNode? = node.prev
        let next: DoubleLinkedListNode? = node.next
        prev?.next = next
        next?.prev = prev
        
        node.prev = nil
        node.next = head
        head?.prev = node
        head = node
        
    }
    
    func printDescription() {
        if dict.isEmpty {
            print("Empty")
        } else {
            head?.printDescription()
        }
        print("========================")
    }
    
}

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

