//
//  GMSlideMenuViewController.swift
//  GMSlideMenuPageView
//
//  Created by Gina Mullins on 7/12/17.
//  Copyright © 2017 LittlePeculiar. All rights reserved.
//

import UIKit

class GMSlideMenuViewController: UIViewController {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerTextLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControlView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var slideMenuView: GMSlideMenuView!

    var currentViewController: UIViewController!
    var menuControllers = [UIViewController]()
    var segmentedControllers = [UIViewController]()
    var headerTitle: NSString?
    var headerText: NSString?
    var buttonTitles = [String]()
    var segmentedButtonTitles = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()

        if let title = headerTitle {
            headerTitleLabel.text = title as String
        }
        if let text = headerText {
            headerTextLabel.text = text as String
        }

        configureSlideMenu()
        configureSegmentedControl()

        currentViewController = childViewControllers.last
        loadViewControllerFor(index: 0)
    }

    func configureSlideMenu() {
        slideMenuView.configureWith(buttonTitles: buttonTitles)
        slideMenuView.slideDelegate = self
        slideMenuView.selectionBarColor = UIColor(red: 81/255.0, green: 160/255.0 , blue: 183/255.0, alpha: 1.0)
    }

    func configureSegmentedControl() {
        segmentedControl.layer.cornerRadius = segmentedControl.bounds.height / 2;
        segmentedControl.layer.borderColor =  UIColor.orange.cgColor
        segmentedControl.layer.borderWidth = 1
        segmentedControl.clipsToBounds = true
        segmentedControl.tintColor = .orange
        segmentedControl.removeAllSegments()

        for (index, title) in segmentedButtonTitles.enumerated() {
            segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
    }

    func loadViewControllerFor(index: Int) {
        let vc: UIViewController = menuControllers[index]
        if segmentedControllers.contains(vc) {
            segmentedControlView.isHidden = false
            loadViewControllerForSegmentedControl()
        } else {
            segmentedControlView.isHidden = true
            if currentViewController != vc {
                moveTo(newContoller: vc)
            }
        }
    }

    func loadViewControllerForSegmentedControl() {
        let index = segmentedControl.selectedSegmentIndex
        let vc: UIViewController = segmentedControllers[index]
        if currentViewController != vc {
            moveTo(newContoller: vc)
        }
    }

    func moveTo(newContoller: UIViewController) {
        self.addChildViewController(newContoller)
        newContoller.view.frame = self.containerView.bounds

        currentViewController.willMove(toParentViewController: nil)
        self.transition(from: self.currentViewController, to: newContoller, duration: 0.6, options: .curveEaseInOut, animations: nil) { [weak self] (finished) in
            self?.currentViewController.removeFromParentViewController()
            newContoller.didMove(toParentViewController: self)
            self?.currentViewController = newContoller
        }
    }
    
    @IBAction func segmentControlDidChange(_ sender: Any) {
        loadViewControllerForSegmentedControl()
    }
}

extension GMSlideMenuViewController: SlideMenuViewProtocol {
    func menuButtonSelectedAt(index: Int) {
        loadViewControllerFor(index: index)
    }
}
