//
//  LRUCache.swift
//  LRUCache
//
//  Created by Oleg Zozulia on 11.02.2025.
//

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
    
    func printDescription() {
        if dict.isEmpty {
            print("Empty")
        } else {
            head?.printDescription()
        }
        print("========================")
    }
    
    func clear() {
        dict.removeAll()
        head = nil
        tail = nil
        printDescription()
    }
    
    func append(_ value: T) {
        if dict.isEmpty {
            addToEmpty(value)
        } else if let node = dict[value] {
            moveToHead(node)
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
        moveToHead(node)
        return node
    }
    
    private func moveToHead(_ node: DoubleLinkedListNode) {
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
    
    private func addToEmpty(_ value: T) {
        let node = DoubleLinkedListNode(value: value)
        dict[value] = node
        head = node
        tail = head
    }
}
