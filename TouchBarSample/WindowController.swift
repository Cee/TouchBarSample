//
//  WindowController.swift
//  TouchBarSample
//
//  Created by Cee on 10/28/16.
//  Copyright © 2016 Cee. All rights reserved.
//

import Cocoa

fileprivate extension NSTouchBarCustomizationIdentifier {
    static let touchBar = NSTouchBarCustomizationIdentifier("io.Cee.TouchBarSample.touchBar")
}

fileprivate extension NSTouchBarItemIdentifier {
    static let smaller = NSTouchBarItemIdentifier("io.Cee.TouchBarSample.smaller")
    static let equal = NSTouchBarItemIdentifier("io.Cee.TouchBarSample.equal")
    static let bigger = NSTouchBarItemIdentifier("io.Cee.TouchBarSample.bigger")
}


class WindowController: NSWindowController {

    @IBOutlet weak var numberA: NSTextField!
    @IBOutlet weak var numberB: NSTextField!
    @IBOutlet weak var resultLabel: NSTextField!
    
    override var windowNibName: String? {
        return "WindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        reset()
    }
    
    // MARK: - NSTouchBar
    
    @available(OSX 10.12.1, *)
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .touchBar
        touchBar.defaultItemIdentifiers = [.smaller, .equal, .bigger]
        touchBar.customizationAllowedItemIdentifiers = [.smaller, .equal, .bigger]
        
        return touchBar
    }
    
    // MARK: - Button Action
    
    @IBAction func randomize(_ sender: NSButton) {
        reset()
    }
    
    // MARK: - Private Method

    func compare(with symbol: NSButton) {
        let number1 = numberA.intValue
        let number2 = numberB.intValue
        var result: Bool
        switch symbol.title {
            case "<": result = (number1 < number2)
            case "=": result = (number1 == number2)
            case ">": result = (number1 > number2)
            default: result = false
        }
        resultLabel.stringValue = (result == true) ? "Correct" : "Wrong"
    }
    
    func reset() {
        numberA.intValue = randomAInt()
        numberB.intValue = randomAInt()
        resultLabel.stringValue = ""
    }
    
    func randomAInt() -> Int32 {
        return Int32(arc4random_uniform(10))
    }
    
}


extension WindowController: NSTouchBarDelegate {
    @available(OSX 10.12.1, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        let touchBarItem = NSCustomTouchBarItem(identifier: identifier)
        
        var title: String
        switch identifier {
            case NSTouchBarItemIdentifier.smaller: title = "<"
            case NSTouchBarItemIdentifier.equal: title = "="
            case NSTouchBarItemIdentifier.bigger: title = ">"
            default: title = ""
        }
        
        let touchBarButton = NSButton(title: title, target: self, action: #selector(compare(with:)))
        touchBarItem.view = touchBarButton

        return touchBarItem;
    }
}
