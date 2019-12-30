//
// The MIT License (MIT)
//
// Copyright (c) 2015-present Badoo Trading Limited.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit

open class BaseMessageBubbleAttachmentView: UIView {
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    let activityImageView = UIImageView()
    fileprivate let attachmentButton = UIButton()
    var margins: UIEdgeInsets = .zero
    var attachmentAlignment: Alignment = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var onBubbleAttachmentTapped: ((_ attachment: BaseMessageBubbleAttachmentView) -> Void)?
    
    var status = MessageStatus.success {
        didSet {
            switch status {
            case .success:
                activityIndicator.stopAnimating()
                attachmentButton.isHidden = true
            case .failed:
                activityIndicator.stopAnimating()
                attachmentButton.isHidden = false
            case .sending:
                activityIndicator.startAnimating()
                attachmentButton.isHidden = true
            }
        }
    }
    
    public var onAttachmentTapped: (() -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        addSubview(activityImageView)
        addSubview(activityIndicator)
        addSubview(attachmentButton)
        
        attachmentButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.clipsToBounds = true
    }
    
    @objc
    func buttonAction() {
        onBubbleAttachmentTapped?(self)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
//        attachmentButton.frame = bounds.inset(by: margins)
        attachmentButton.frame = bounds
        activityImageView.bounds = CGRect(origin: .zero, size: activityImageView.image?.size ?? .zero)
        switch self.attachmentAlignment {
        case .center:
            activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
            activityImageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        case .left:
            activityIndicator.center = CGPoint(x: activityIndicator.bounds.midX, y: bounds.midY)
            activityImageView.center = CGPoint(x: activityImageView.bounds.midX, y: bounds.midY)
        case .right:
            activityIndicator.center = CGPoint(x: bounds.width - activityIndicator.bounds.midX, y: bounds.midY)
            activityImageView.center = CGPoint(x: bounds.width - activityImageView.bounds.midX, y: bounds.midY)
        case .top:
            activityIndicator.center = CGPoint(x: bounds.midX, y: activityIndicator.bounds.midY)
            activityImageView.center = CGPoint(x: bounds.midX, y: activityImageView.bounds.midY)
        case .bottom:
            activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.height - activityIndicator.bounds.midY)
            activityImageView.center = CGPoint(x: bounds.midX, y: bounds.height - activityImageView.bounds.midY)
        }
    }

}
