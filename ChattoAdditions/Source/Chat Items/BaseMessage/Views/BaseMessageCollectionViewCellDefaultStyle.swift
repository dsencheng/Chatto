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

open class BaseMessageCollectionViewCellDefaultStyle: BaseMessageCollectionViewCellStyleProtocol {

    typealias Class = BaseMessageCollectionViewCellDefaultStyle

    public struct Colors {
        let incoming: () -> UIColor
        let outgoing: () -> UIColor
        public init(
            incoming: @autoclosure @escaping () -> UIColor,
            outgoing: @autoclosure @escaping () -> UIColor) {
                self.incoming = incoming
                self.outgoing = outgoing
        }
    }

    public struct BubbleBorderImages {
        public let borderIncomingTail: () -> UIImage
        public let borderIncomingNoTail: () -> UIImage
        public let borderOutgoingTail: () -> UIImage
        public let borderOutgoingNoTail: () -> UIImage
        public init(
            borderIncomingTail: @autoclosure @escaping () -> UIImage,
            borderIncomingNoTail: @autoclosure @escaping () -> UIImage,
            borderOutgoingTail: @autoclosure @escaping () -> UIImage,
            borderOutgoingNoTail: @autoclosure @escaping () -> UIImage) {
                self.borderIncomingTail = borderIncomingTail
                self.borderIncomingNoTail = borderIncomingNoTail
                self.borderOutgoingTail = borderOutgoingTail
                self.borderOutgoingNoTail = borderOutgoingNoTail
        }
    }

    public struct BubbleAttachmentIconImages {
        let failedNormal: () -> UIImage
        let failedHighlighted: () -> UIImage
        let sendingNormal: () -> UIImage
        let sendingHighlighted: () -> UIImage
        public init(
            failedNormal: @autoclosure @escaping () -> UIImage,
            failedHighlighted: @autoclosure @escaping () -> UIImage,
            sendingNormal: @autoclosure @escaping () -> UIImage,
            sendingHighlighted: @autoclosure @escaping () -> UIImage) {
                self.failedNormal = failedNormal
                self.failedHighlighted = failedHighlighted
                self.sendingNormal = sendingNormal
                self.sendingHighlighted = sendingHighlighted
        }
    }

    public struct DateTextStyle {
        let font: () -> UIFont
        let color: () -> UIColor
        public init(
            font: @autoclosure @escaping () -> UIFont,
            color: @autoclosure @escaping () -> UIColor) {
                self.font = font
                self.color = color
        }
    }

    public struct AvatarStyle {
        let size: CGSize
        let alignment: VerticalAlignment
        public init(size: CGSize = .zero, alignment: VerticalAlignment = .bottom) {
            self.size = size
            self.alignment = alignment
        }
    }

    public struct SelectionIndicatorStyle {
        let margins: UIEdgeInsets
        let selectedIcon: () -> UIImage
        let deselectedIcon: () -> UIImage
        public init(margins: UIEdgeInsets,
                    selectedIcon: @autoclosure @escaping () -> UIImage,
                    deselectedIcon: @autoclosure @escaping () -> UIImage) {
            self.margins = margins
            self.selectedIcon = selectedIcon
            self.deselectedIcon = deselectedIcon
        }
    }
    
    public struct AttachmentStyle {
        let size: CGSize
        let margin: UIEdgeInsets
        let alignment: Alignment
        public init(size: CGSize = .zero, margin: UIEdgeInsets = .zero, alignment: Alignment = .center) {
            self.size = size
            self.margin = margin
            self.alignment = alignment
        }
    }

    let colors: Colors
    let bubbleBorderImages: BubbleBorderImages?
    let bubbleAttachmentIconImages: BubbleAttachmentIconImages
    let layoutConstants: BaseMessageCollectionViewCellLayoutConstants
    let dateTextStyle: DateTextStyle
    let incomingAvatarStyle: AvatarStyle
    let outgoingAvatarStyle: AvatarStyle
    let selectionIndicatorStyle: SelectionIndicatorStyle
    let attachmentStyle: AttachmentStyle

    public convenience init(
        colors: Colors = BaseMessageCollectionViewCellDefaultStyle.createDefaultColors(),
        bubbleBorderImages: BubbleBorderImages? = BaseMessageCollectionViewCellDefaultStyle.createDefaultBubbleBorderImages(),
        bubbleAttachmentIconImages: BubbleAttachmentIconImages = BaseMessageCollectionViewCellDefaultStyle.createDefaultBubbleAttachmentIconImages(),
        layoutConstants: BaseMessageCollectionViewCellLayoutConstants = BaseMessageCollectionViewCellDefaultStyle.createDefaultLayoutConstants(),
        dateTextStyle: DateTextStyle = BaseMessageCollectionViewCellDefaultStyle.createDefaultDateTextStyle(),
        avatarStyle: AvatarStyle = AvatarStyle(),
        selectionIndicatorStyle: SelectionIndicatorStyle = BaseMessageCollectionViewCellDefaultStyle.createDefaultSelectionIndicatorStyle(),
        attachmentStyle: AttachmentStyle = AttachmentStyle()) {
        self.init(colors: colors,
                  bubbleBorderImages: bubbleBorderImages,
                  bubbleAttachmentIconImages: bubbleAttachmentIconImages,
                  layoutConstants: layoutConstants,
                  dateTextStyle: dateTextStyle,
                  incomingAvatarStyle: avatarStyle,
                  outgoingAvatarStyle: avatarStyle,
                  selectionIndicatorStyle: selectionIndicatorStyle,
                  attachmentStyle: attachmentStyle)
    }

    public init(
        colors: Colors = BaseMessageCollectionViewCellDefaultStyle.createDefaultColors(),
        bubbleBorderImages: BubbleBorderImages? = BaseMessageCollectionViewCellDefaultStyle.createDefaultBubbleBorderImages(),
        bubbleAttachmentIconImages: BubbleAttachmentIconImages = BaseMessageCollectionViewCellDefaultStyle.createDefaultBubbleAttachmentIconImages(),
        layoutConstants: BaseMessageCollectionViewCellLayoutConstants = BaseMessageCollectionViewCellDefaultStyle.createDefaultLayoutConstants(),
        dateTextStyle: DateTextStyle = BaseMessageCollectionViewCellDefaultStyle.createDefaultDateTextStyle(),
        incomingAvatarStyle: AvatarStyle = AvatarStyle(),
        outgoingAvatarStyle: AvatarStyle = AvatarStyle(),
        selectionIndicatorStyle: SelectionIndicatorStyle = BaseMessageCollectionViewCellDefaultStyle.createDefaultSelectionIndicatorStyle(),
        attachmentStyle: AttachmentStyle = AttachmentStyle()
    ) {
        self.colors = colors
        self.bubbleBorderImages = bubbleBorderImages
        self.bubbleAttachmentIconImages = bubbleAttachmentIconImages
        self.layoutConstants = layoutConstants
        self.dateTextStyle = dateTextStyle
        self.incomingAvatarStyle = incomingAvatarStyle
        self.outgoingAvatarStyle = outgoingAvatarStyle
        self.selectionIndicatorStyle = selectionIndicatorStyle
        self.attachmentStyle = attachmentStyle
        self.dateStringAttributes = [
            NSAttributedString.Key.font: self.dateTextStyle.font(),
            NSAttributedString.Key.foregroundColor: self.dateTextStyle.color()
        ]
    }

    public lazy var baseColorIncoming: UIColor = self.colors.incoming()
    public lazy var baseColorOutgoing: UIColor = self.colors.outgoing()

    public lazy var borderIncomingTail: UIImage? = self.bubbleBorderImages?.borderIncomingTail()
    public lazy var borderIncomingNoTail: UIImage? = self.bubbleBorderImages?.borderIncomingNoTail()
    public lazy var borderOutgoingTail: UIImage? = self.bubbleBorderImages?.borderOutgoingTail()
    public lazy var borderOutgoingNoTail: UIImage? = self.bubbleBorderImages?.borderOutgoingNoTail()

    
    

    private let dateStringAttributes: [NSAttributedString.Key: AnyObject]

    open func attributedStringForDate(_ date: String) -> NSAttributedString {
        return NSAttributedString(string: date, attributes: self.dateStringAttributes)
    }

    open func borderImage(viewModel: MessageViewModelProtocol) -> UIImage? {
        switch (viewModel.isIncoming, viewModel.decorationAttributes.isShowingTail) {
        case (true, true):
            return self.borderIncomingTail
        case (true, false):
            return self.borderIncomingNoTail
        case (false, true):
            return self.borderOutgoingTail
        case (false, false):
            return self.borderOutgoingNoTail
        }
    }

    public func attachmentIcon(viewModel: MessageViewModelProtocol, for state: UIControl.State) -> UIImage? {
        var image : UIImage? = nil
        switch viewModel.status {
        case .failed:
            if state == .highlighted {
                image = self.bubbleAttachmentIconImages.failedHighlighted()
            } else if state == .normal {
                image = self.bubbleAttachmentIconImages.failedNormal()
            }
        case .sending:
            if state == .highlighted {
                image = self.bubbleAttachmentIconImages.sendingHighlighted()
            } else if state == .normal {
                image = self.bubbleAttachmentIconImages.sendingNormal()
            }
        case .success:
            break
        }
        return image
    }
    
    public func attachmentIconSize(viewModel: MessageViewModelProtocol) -> CGSize {
        return self.attachmentStyle.size
    }
    
    public var attachmentIconMargins: UIEdgeInsets {
        return self.attachmentStyle.margin
    }
    
    public var attachmentAlignment: Alignment {
        return self.attachmentStyle.alignment
    }
    
    open func avatarSize(viewModel: MessageViewModelProtocol) -> CGSize {
        return self.avatarStyle(for: viewModel).size
    }

    open func avatarVerticalAlignment(viewModel: MessageViewModelProtocol) -> VerticalAlignment {
        return self.avatarStyle(for: viewModel).alignment
    }

    public var selectionIndicatorMargins: UIEdgeInsets {
        return self.selectionIndicatorStyle.margins
    }

    public func selectionIndicatorIcon(for viewModel: MessageViewModelProtocol) -> UIImage {
        return viewModel.decorationAttributes.isSelected ? self.selectionIndicatorStyle.selectedIcon() : self.selectionIndicatorStyle.deselectedIcon()
    }

    open func layoutConstants(viewModel: MessageViewModelProtocol) -> BaseMessageCollectionViewCellLayoutConstants {
        return self.layoutConstants
    }

    private func avatarStyle(for viewModel: MessageViewModelProtocol) -> AvatarStyle {
        return viewModel.isIncoming ? self.incomingAvatarStyle : self.outgoingAvatarStyle
    }
}

public extension BaseMessageCollectionViewCellDefaultStyle { // Default values

    private static let defaultIncomingColor = UIColor.bma_color(rgb: 0xE6ECF2)
    private static let defaultOutgoingColor = UIColor.bma_color(rgb: 0x3D68F5)

    static func createDefaultColors() -> Colors {
        return Colors(incoming: self.defaultIncomingColor, outgoing: self.defaultOutgoingColor)
    }

    static func createDefaultBubbleBorderImages() -> BubbleBorderImages {
        return BubbleBorderImages(
            borderIncomingTail: UIImage(named: "bubble-incoming-border-tail", in: Bundle(for: Class.self), compatibleWith: nil)!,
            borderIncomingNoTail: UIImage(named: "bubble-incoming-border", in: Bundle(for: Class.self), compatibleWith: nil)!,
            borderOutgoingTail: UIImage(named: "bubble-outgoing-border-tail", in: Bundle(for: Class.self), compatibleWith: nil)!,
            borderOutgoingNoTail: UIImage(named: "bubble-outgoing-border", in: Bundle(for: Class.self), compatibleWith: nil)!
        )
    }

    static func createDefaultBubbleAttachmentIconImages() -> BubbleAttachmentIconImages {
        let normal = {
            return UIImage(named: "base-message-failed-icon", in: Bundle(for: Class.self), compatibleWith: nil)!
        }
        let sending = {
            return UIImage(named: "base-message-unchecked-icon", in: Bundle(for: Class.self), compatibleWith: nil)!
        }
        return BubbleAttachmentIconImages(
            failedNormal: normal(),
            failedHighlighted: normal().bma_blendWithColor(UIColor.black.withAlphaComponent(0.10)),
            sendingNormal: sending(),
            sendingHighlighted: sending().bma_blendWithColor(UIColor.black.withAlphaComponent(0.10))
        )
    }

    static func createDefaultDateTextStyle() -> DateTextStyle {
        return DateTextStyle(font: UIFont.systemFont(ofSize: 12), color: UIColor.bma_color(rgb: 0x9aa3ab))
    }

    static func createDefaultLayoutConstants() -> BaseMessageCollectionViewCellLayoutConstants {
        return BaseMessageCollectionViewCellLayoutConstants(horizontalMargin: 12,
                                                            horizontalInterspacing: 8,
                                                            horizontalTimestampMargin: 12,
                                                            maxContainerWidthPercentageForBubbleView: 0.73)
    }

    private static let selectionIndicatorIconSelected = UIImage(named: "base-message-checked-icon", in: Bundle(for: Class.self), compatibleWith: nil)!.bma_tintWithColor(BaseMessageCollectionViewCellDefaultStyle.defaultOutgoingColor)
    private static let selectionIndicatorIconDeselected = UIImage(named: "base-message-unchecked-icon", in: Bundle(for: Class.self), compatibleWith: nil)!.bma_tintWithColor(UIColor.bma_color(rgb: 0xC6C6C6))

    static func createDefaultSelectionIndicatorStyle() -> SelectionIndicatorStyle {
        return SelectionIndicatorStyle(
            margins: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
            selectedIcon: self.selectionIndicatorIconSelected,
            deselectedIcon: self.selectionIndicatorIconDeselected
        )
    }
}
