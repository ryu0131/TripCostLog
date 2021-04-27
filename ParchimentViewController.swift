//
//  parchimentViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2021/01/02.

import UIKit

class ParchimentViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    private lazy var AttemptViewController: OverWriteViewController = {
        let storyborad = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyborad.instantiateViewController(withIdentifier: "AttemptViewController") as! OverWriteViewController
        add(asChildViewController: viewController)
        return viewController
    }()

    private lazy var SecondDetailViewContoroller: SecondDetailViewContoroller = {
        let storyborad = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyborad.instantiateViewController(withIdentifier: "SecondDetailViewContoroller") as! SecondDetailViewContoroller
        add(asChildViewController: viewController)
        return viewController
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        //print(passData)
        setupView()
    }


    private func setupView() {
        updateView()
    }

    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: AttemptViewController)
            add(asChildViewController: SecondDetailViewContoroller)
        } else {
            remove(asChildViewController: SecondDetailViewContoroller)
            add(asChildViewController: AttemptViewController)
        }
    }



    @IBAction func tapSegmentedControl(_ sender: UISegmentedControl) {
        updateView()
    }



    private func add(asChildViewController viewController: UIViewController) {
        // 子ViewControllerを追加
        addChild(viewController)
        // Subviewとして子ViewControllerのViewを追加
        view.addSubview(viewController.view)
        // 子Viewの設定
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // 子View Controllerへの通知
        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        // 子View Controllerへの通知
        viewController.willMove(toParent: nil)
        // 子ViewをSuperviewから削除
        viewController.view.removeFromSuperview()
        // 子View Controllerへの通知
        viewController.removeFromParent()
    }

}
