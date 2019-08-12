//
//  ViewController.swift
//  Example
//
//  Created by Shai Mishali on 03/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import UIKit
import Combine
import CombineCocoa

class ControlsViewController: UIViewController {
  @IBOutlet private var segmented: UISegmentedControl!
  @IBOutlet private var slider: UISlider!
  @IBOutlet private var textField: UITextField!
  @IBOutlet private var button: UIButton!
  @IBOutlet private var `switch`: UISwitch!
  @IBOutlet private var datePicker: UIDatePicker!
  @IBOutlet private var console: UITextView!
  @IBOutlet private var rightBarButtonItem: UIBarButtonItem!

  private var subscriptions = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()

    Just("Debug Output:")
      .merge(with: segmented.selectedSegmentIndexPublisher.map { "Segmented at index \($0)" },
                   slider.valuePublisher.map { "Slider value is \($0)" },
                   textField.textPublisher.map { "Text Field text is \($0 ?? "")" },
                   button.tapPublisher.map { "Tapped Button" },
                   `switch`.isOnPublisher.map { "Switch is now \($0 ? "On" : "Off")" },
                   datePicker.datePublisher.map { "Date picker date is \($0)" },
                   rightBarButtonItem.tapPublisher.map { "Tapped Right Bar Button Item" })
      .scan("") { $0 + "\n" + $1 }
      .handleEvents(receiveOutput: { [console] text in
        guard let console = console else { return }
        console.scrollRangeToVisible(console.selectedRange)
      })
      .assign(to: \.text, on: console)
      .store(in: &subscriptions)
  }
}
