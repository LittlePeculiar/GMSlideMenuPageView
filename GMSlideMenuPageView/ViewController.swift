//
//  ViewController.swift
//  GMSlideMenuPageView
//
//  Created by Gina Mullins on 7/12/17.
//  Copyright © 2017 LittlePeculiar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadSlideMenu()
    }

    func loadSlideMenu() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let firstVC = main.instantiateViewController(withIdentifier :"FirstVC")
        let secondVC = main.instantiateViewController(withIdentifier :"SecondVC")
        let thirdVC = main.instantiateViewController(withIdentifier :"ThirdVC")

        let slide = UIStoryboard(name: "GMSlideMenu", bundle: nil)
        guard let slideVC = slide.instantiateViewController(withIdentifier: "SlideVC") as? GMSlideMenuViewController else { return }

        slideVC.menuControllers = [firstVC, secondVC]
        slideVC.segmentedControllers = [secondVC, thirdVC]
        slideVC.buttonTitles = ["Thing 1", "Thing 2"]
        slideVC.segmentedButtonTitles = ["About", "Summary"]
        slideVC.headerTitle = "Check out my Menu"
        slideVC.headerText = "Tap a button or Tap a segmented button and see a different View appear.\nCool Slider too"

        let navC = UINavigationController.init(rootViewController: slideVC)
        present(navC, animated: true, completion: nil)
    }
}

