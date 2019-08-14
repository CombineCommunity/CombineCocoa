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
    
    // Set up some gesture recognizers
    let leftSwipe = UISwipeGestureRecognizer()
    leftSwipe.direction = .left
    view.addGestureRecognizer(leftSwipe)
    
    let longPress = UILongPressGestureRecognizer()
    longPress.minimumPressDuration = 2
    view.addGestureRecognizer(longPress)
    
    let doubleTap = UITapGestureRecognizer()
    doubleTap.numberOfTapsRequired = 2
    view.addGestureRecognizer(doubleTap)
    
    // Each merge can go up to 8 elements, so we have to chain a few of them ;-)
    Just("Debug Output:")
      .merge(with: segmented.selectedSegmentIndexPublisher.map { "Segmented at index \($0)" },
                   slider.valuePublisher.map { "Slider value is \($0)" },
                   textField.textPublisher.map { "Text Field text is \($0 ?? "")" },
                   button.tapPublisher.map { "Tapped Button" },
                   `switch`.isOnPublisher.map { "Switch is now \($0 ? "On" : "Off")" },
                   datePicker.datePublisher.map { "Date picker date is \($0)" },
                   rightBarButtonItem.tapPublisher.map { "Tapped Right Bar Button Item" })
      .merge(with: leftSwipe.swipePublisher.map { "Swiped Left with Gesture \($0.memoryAddress)" },
                   longPress.longPressPublisher.map { "Long Pressed with Gesture \($0.memoryAddress)" },
                   doubleTap.tapPublisher.map { "Double-tapped view with two fingers with Gesture \($0.memoryAddress)" },
                   console.reachedBottomPublisher().map { _ in "Reached the bottom of the UITextView" })
      .scan("") { $0 + "\n" + $1 }
      .handleEvents(receiveOutput: { [console] text in
        guard let console = console else { return }
        console.scrollRangeToVisible(console.selectedRange)
      })
      .assign(to: \.text, on: console)
      .store(in: &subscriptions)
  }
}

private extension NSObject {
  var memoryAddress: String {
    Unmanaged.passUnretained(self).toOpaque().debugDescription
  }
}
