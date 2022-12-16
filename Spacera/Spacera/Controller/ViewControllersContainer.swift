//
//  ViewControllersContainer.swift
//  Spacera
//
//  Created by Artem Bilyi on 16.12.2022.
//

import UIKit

final class CustomPageViewController: UIPageViewController {
    private var controllers = [UIViewController]()
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        for index in 0...3 {
            let rocketViewController = RocketViewController(index: index)
            controllers.append(rocketViewController)
        }
        setViewControllers([controllers[0]], direction: .forward, animated: false)
    }
    private func changeIndicatorColor() {
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [RocketViewController.self])
        appearance.pageIndicatorTintColor = .lightGray
        appearance.currentPageIndicatorTintColor = .black
    }
}

extension CustomPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageViewController = controllers.firstIndex(of: viewController) else { return nil }
        if indexOfCurrentPageViewController < 1 {
            return nil
        } else {
            return controllers[indexOfCurrentPageViewController - 1]
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndexOfPageViewController = controllers.firstIndex(of: viewController) else { return nil }
        if currentIndexOfPageViewController == controllers.count - 1 {
            return nil
        } else {
            return controllers[currentIndexOfPageViewController + 1]
        }
    }
}

extension CustomPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        changeIndicatorColor()
        return 4
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}