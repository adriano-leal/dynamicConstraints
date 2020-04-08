//
//  ViewController.swift
//  DynamicConstraints
//
//  Created by Adriano Ramos on 08/04/20.
//  Copyright © 2020 Adriano Ramos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let customView = CustomView()
    private let disposeBag = DisposeBag()
    override func loadView() {
        view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.slider.rx.value.asDriver()
            .map { CGFloat($0)}
            .map { $0 > 0.5 ? true : false}
//            .map { $0 == false ? 0 : 100 }
            .debug()
            .drive(customView.testView.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

class CustomView: UIView {
    let slider: UISlider = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UISlider())
    let testView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .blue
        return $0
    }(UIView())
    let test2View: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .yellow
        return $0
    }(UIView())
    let testViewHeightConstraint: NSLayoutConstraint!
    init(){
        testViewHeightConstraint =
            NSLayoutConstraint(item: testView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100)
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubviews(){
        addSubview(slider)
        addSubview(testView)
        addSubview(test2View)
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.heightAnchor.constraint(equalToConstant: 50),
            testView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 100),
            testView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            testView.centerXAnchor.constraint(equalTo: centerXAnchor),
            testViewHeightConstraint,
            test2View.topAnchor.constraint(equalTo: testView.bottomAnchor, constant: 100),
            test2View.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            test2View.centerXAnchor.constraint(equalTo: centerXAnchor),
            test2View.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
