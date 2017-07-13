//
//  GMSlideMenuView.swift
//  GMSlideMenuPageView
//
//  Created by Gina Mullins on 7/12/17.
//  Copyright © 2017 LittlePeculiar. All rights reserved.
//

import UIKit

protocol SlideMenuViewProtocol: class {

    func menuButtonSelectedAt(index: Int)
}

struct ButtonAttributes {
    static let PADDING: CGFloat = 20.0
    static let HEIGHT: CGFloat = 30.0
    static let BOUNCE_BUFFER: CGFloat = 10.0
    static let ANIMATION_SPEED: CGFloat = 0.4
    static let SELECTOR_Y_BUFFER: CGFloat = 5.0
    static let SELECTOR_HEIGHT: CGFloat = 4.0
    static let X_OFFSET: CGFloat = 8.0
}

class GMSlideMenuView: UIView {

    weak var slideDelegate: SlideMenuViewProtocol?
    var selectionBarColor: UIColor!

    func configureWith(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        self.buttonCount = buttonTitles.count
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        setupSegmentedButtons()
    }

    private var selectionBar: UIView!
    private var buttonTitles = [String]()
    private var currentButtonIndex = 0
    private var buttonCount = 0

    private func setupSegmentedButtons() {
        for (index, title) in buttonTitles.enumerated() {
            let posX: CGFloat = CGFloat(index) * frame.size.width/CGFloat(buttonCount) + ButtonAttributes.PADDING
            let posY: CGFloat = frame.size.height/2 - ButtonAttributes.HEIGHT/2
            let width: CGFloat = frame.size.width/CGFloat(buttonCount) - 2*ButtonAttributes.PADDING
            let buttonFrame = CGRect(x: posX, y: posY, width: width, height: ButtonAttributes.HEIGHT)
            let button = UIButton(frame: buttonFrame)
            addSubview(button)

            button.tag = index
            button.backgroundColor = .clear
            button.setTitle(title, for: .normal)
            button.addTarget(self, action:#selector(tapSegmentedButtonAction(button:)), for: .touchUpInside)

            let buttonTextColor: UIColor = (index == 0) ? .darkText : .lightGray
            button.setTitleColor(buttonTextColor, for: .normal)
        }

        setupSelector()
    }

    private func updateSegmentedButtons() {
        for subview in subviews {
            if subview is UIButton {
                let button = subview as? UIButton ?? UIButton()
                let buttonTextColor: UIColor = (button.tag == currentButtonIndex) ? .darkText : .lightGray
                button.setTitleColor(buttonTextColor, for: .normal)
            }
        }
    }

    private func setupSelector() {
        let width = frame.size.width/CGFloat(buttonCount) - 2*ButtonAttributes.PADDING
        let posY = frame.size.height - ButtonAttributes.SELECTOR_Y_BUFFER
        let barFrame = CGRect(x: ButtonAttributes.PADDING, y: posY, width: width, height: ButtonAttributes.SELECTOR_HEIGHT)
        selectionBar = UIView(frame: barFrame)
        selectionBar.backgroundColor = selectionBarColor
        selectionBarColor.withAlphaComponent(0.8)
        selectionBar.layer.cornerRadius = ButtonAttributes.SELECTOR_HEIGHT/2
        selectionBar.layer.masksToBounds = true
        addSubview(selectionBar)
    }

    private func updateSelector() {
        UIView.animate(withDuration: TimeInterval(ButtonAttributes.ANIMATION_SPEED)) { 
            let posX = CGFloat(self.currentButtonIndex) * self.frame.size.width/CGFloat(self.buttonCount) + ButtonAttributes.PADDING
            self.selectionBar.frame = CGRect(x: posX, y: self.selectionBar.frame.origin.y, width: self.selectionBar.frame.size.width, height: self.selectionBar.frame.size.height)
        }
    }

    private func updateCurrent(pageIndex: Int) {
        currentButtonIndex = pageIndex
        updateSegmentedButtons()
        updateSelector()
        slideDelegate?.menuButtonSelectedAt(index: pageIndex)
    }

    func tapSegmentedButtonAction(button: UIButton) {

        // check right to left
        if button.tag > currentButtonIndex {
            var index = currentButtonIndex+1
            while (index <= button.tag) {
                updateCurrent(pageIndex: index)
                index += 1
            }
        }
        // else reverse
        else if (button.tag < currentButtonIndex) {
            var index = currentButtonIndex-1
            while (index >= button.tag) {
                updateCurrent(pageIndex: index)
                index -= 1
            }
        }

    }

}
