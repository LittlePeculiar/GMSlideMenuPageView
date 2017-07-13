# GMSlideMenuPageView
Cool little menu with slider and segmented control

setup the slide menu in your main ViewController as so:

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
