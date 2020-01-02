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
import Chatto
import ChattoAdditions

class DemoChatViewController: BaseChatViewController {
    var shouldUseAlternativePresenter: Bool = false

    var messageSender: DemoChatMessageSender!
    let messagesSelector = BaseMessagesSelector()

    var dataSource: DemoChatDataSource! {
        didSet {
            self.chatDataSource = self.dataSource
            self.messageSender = self.dataSource.messageSender
        }
    }

    lazy private var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: self.messageSender, messagesSelector: self.messagesSelector)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Chat"
        self.messagesSelector.delegate = self
        self.chatItemsDecorator = DemoChatItemsDecorator(messagesSelector: self.messagesSelector)
//        self.collectionView?.showsVerticalScrollIndicator = false
    }

    var chatInputPresenter: AnyObject!
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
//        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.sendButtonAppearance.normalImage = UIImage(named: "ic_chat_dialogue_send_n")!
        appearance.sendButtonAppearance.selectedImage = UIImage(named: "ic_chat_dialogue_send_n")!
        appearance.sendButtonAppearance.highlightedImage = UIImage(named: "ic_chat_dialogue_send_n")!
        appearance.sendButtonAppearance.disabledImage = UIImage(named: "ic_chat_dialogue_send_p")!
        
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message...", comment: "")
//        appearance.tabBarAppearance.height = 0.0
        if self.shouldUseAlternativePresenter {
            let chatInputPresenter = ExpandableChatInputBarPresenter(
                inputPositionController: self,
                chatInputBar: chatInputView,
                chatInputItems: self.createChatInputItems(),
                chatInputBarAppearance: appearance)
            self.chatInputPresenter = chatInputPresenter
            self.keyboardEventsHandler = chatInputPresenter
            self.scrollViewEventsHandler = chatInputPresenter
        } else {
            let chatInputPresenter = BasicChatInputBarPresenter(
                chatInputBar: chatInputView,
//                chatInputItems: self.createChatInputItems(),
                chatInputBarAppearance: appearance)
            chatInputPresenter.textInputDefaultHandler = {[weak self] text in
                self?.dataSource.addTextMessage(text)
            }
            self.chatInputPresenter = chatInputPresenter
        }
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }

    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {

        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: self.createTextMessageViewModelBuilder(),
            interactionHandler: GenericMessageHandler(baseHandler: self.baseMessageHandler)
        )
        
        
        //设置气泡状态按钮样式
        let attchmentImages = BaseMessageCollectionViewCellDefaultStyle.BubbleAttachmentIconImages(failedNormal: UIImage(named: "ic_chat_warn_n")!, failedHighlighted: UIImage(named: "ic_chat_warn_p")!, sendingNormal: UIImage(named: "ic_chat_dialogue_load")!, sendingHighlighted: UIImage(named: "ic_chat_dialogue_load")!)
        //文字背景色
        let colors = BaseMessageCollectionViewCellDefaultStyle.Colors(incoming: UIColor.lightGray, outgoing: UIColor.orange)
        let attachmentSytle = BaseMessageCollectionViewCellDefaultStyle.AttachmentStyle(size: CGSize(width: 32, height: 32), margin:.zero, alignment: .right)
        //基本样式
        let baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle(colors:colors, bubbleAttachmentIconImages: attchmentImages, attachmentStyle:attachmentSytle)
        textMessagePresenter.baseMessageStyle = baseMessageStyle
        
        //设置气泡文字样式
        //气泡图片
        let bubbleImages = TextMessageCollectionViewCellDefaultStyle.BubbleImages(incomingTail: UIImage(named: "pic_chat_bubble_guest_1")!, incomingNoTail: UIImage(named: "pic_chat_bubble_guest_2")!, outgoingTail: UIImage(named: "pic_chat_bubble_master_1")!, outgoingNoTail: UIImage(named: "pic_chat_bubble_master_2")!)
        //气泡文字
        let textStyle = TextMessageCollectionViewCellDefaultStyle.TextStyle(font: UIFont.systemFont(ofSize: 16), incomingColor: UIColor(red: 24.0/255.0, green: 26.0/255.0, blue: 37.0/255.0, alpha: 1), outgoingColor: UIColor.white, incomingInsets: UIEdgeInsets(top: 10, left: 19, bottom: 10, right: 15), outgoingInsets: UIEdgeInsets(top: 10, left: 19, bottom: 10, right: 15))
        
        let baseStyle = baseMessageStyle
        //这里有个坑，初始化textCellStyle 必须赋值 baseStyle，否则默认值带气泡边框
        let textCellStyle = TextMessageCollectionViewCellDefaultStyle(bubbleImages: bubbleImages, textStyle: textStyle, baseStyle: baseStyle)
        textCellStyle.bubbleImageStatusStyle = .none
        textMessagePresenter.textCellStyle = textCellStyle

        let photoMessagePresenter = PhotoMessagePresenterBuilder(
            viewModelBuilder: DemoPhotoMessageViewModelBuilder(),
            interactionHandler: GenericMessageHandler(baseHandler: self.baseMessageHandler)
        )
        photoMessagePresenter.baseCellStyle = baseMessageStyle

        let compoundPresenterBuilder = CompoundMessagePresenterBuilder(
            viewModelBuilder: DemoCompoundMessageViewModelBuilder(),
            interactionHandler: GenericMessageHandler(baseHandler: self.baseMessageHandler),
            accessibilityIdentifier: nil,
            contentFactories: [
                .init(DemoTextMessageContentFactory()),
                .init(DemoImageMessageContentFactory()),
                .init(DemoDateMessageContentFactory())
            ],
            compoundCellDimensions: .defaultDimensions,
            baseCellStyle: baseMessageStyle
        )

        return [
            DemoTextMessageModel.chatItemType: [textMessagePresenter],
            DemoPhotoMessageModel.chatItemType: [photoMessagePresenter],
            SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()],
            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()],
            ChatItemType.compoundItemType: [compoundPresenterBuilder]
        ]
    }

    func createTextMessageViewModelBuilder() -> DemoTextMessageViewModelBuilder {
        return DemoTextMessageViewModelBuilder()
    }

    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        if self.shouldUseAlternativePresenter {
            items.append(self.customInputItem())
        }
        return items
    }

    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            self?.dataSource.addTextMessage(text)
        }
        return item
    }

    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { [weak self] image, _ in
            self?.dataSource.addPhotoMessage(image)
        }
        return item
    }

    private func customInputItem() -> ContentAwareInputItem {
        let item = ContentAwareInputItem()
        item.textInputHandler = { [weak self] text in
            self?.dataSource.addTextMessage(text)
        }
        return item
    }
}

extension DemoChatViewController: MessagesSelectorDelegate {
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didSelectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }

    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didDeselectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
}

extension CompoundBubbleLayoutProvider.Dimensions {
    static var defaultDimensions: CompoundBubbleLayoutProvider.Dimensions {
        return .init(spacing: 8, contentInsets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}

