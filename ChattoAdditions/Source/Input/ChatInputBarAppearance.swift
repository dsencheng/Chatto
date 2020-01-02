/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import UIKit

public struct ChatInputBarAppearance {
    
    public struct SendButtonAppearance {
        public var font = UIFont.systemFont(ofSize: 16)
        public var insets = UIEdgeInsets.zero
        public var title = ""
        public var titleColors: [UIControlStateWrapper: UIColor] = [
            UIControlStateWrapper(state: .disabled): UIColor.bma_color(rgb: 0x9AA3AB),
            UIControlStateWrapper(state: .normal): UIColor.bma_color(rgb: 0x007AFF),
            UIControlStateWrapper(state: .highlighted): UIColor.bma_color(rgb: 0x007AFF).bma_blendWithColor(UIColor.white.withAlphaComponent(0.4))
        ]
        public let accessibilityIdentifier = "chatto.inputbar.button.send"
        public var backgroundColor = UIColor.clear
        public var normalImage:  UIImage = UIImage()
        public var highlightedImage:  UIImage = UIImage()
        public var disabledImage:  UIImage = UIImage()
        public var selectedImage:  UIImage = UIImage()
    }

    public struct TabBarAppearance {
        public var interItemSpacing: CGFloat = 10
//        public var height: CGFloat = 44
        public var contentInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

    public struct TextInputAppearance {
        public var font = UIFont.systemFont(ofSize: 16)
        public var textColor = UIColor.black
        public var tintColor: UIColor?
        public var borderColor = UIColor.clear
        public var borderWidth: CGFloat = 1
        public var placeholderFont = UIFont.systemFont(ofSize: 16)
        public var placeholderColor = UIColor.gray
        public var placeholderText = ""
//        public var textInsets = UIEdgeInsets(top: 9, left: 15, bottom: -9, right: -15)
//        public var height: CGFloat = 38
        public let accessibilityIdentifier = "chatto.inputbar.inputfield.text"
    }

    public var sendButtonAppearance = SendButtonAppearance()
    public var tabBarAppearance = TabBarAppearance()
    public var textInputAppearance = TextInputAppearance()

    public init() {}
}

// Workaround for SR-2223
public struct UIControlStateWrapper: Hashable {

    public let controlState: UIControl.State

    public init(state: UIControl.State) {
        self.controlState = state
    }

    public var hashValue: Int {
        return self.controlState.rawValue.hashValue
    }
}

public func == (lhs: UIControlStateWrapper, rhs: UIControlStateWrapper) -> Bool {
    return lhs.controlState == rhs.controlState
}
