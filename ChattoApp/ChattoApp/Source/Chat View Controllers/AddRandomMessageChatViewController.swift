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

class AddRandomMessagesChatViewController: DemoChatViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelectionButton()
    }

    @objc
    private func addRandomMessage() {
//        self.dataSource.addRandomIncomingMessage()
        self.dataSource.addCustomPhotoMessage(UIImage(named: "pic-test-2")!)
    }
    
    // MARK: - Selection

    private func setupSelectionButton() {
        let button = UIBarButtonItem(
            title: "Select",
            style: .plain,
            target: self,
            action: #selector(handleSelectionButtonTap)
        )
        self.navigationItem.rightBarButtonItems = [button]
    }

    @objc
    private func handleSelectionButtonTap() {
        self.setupCancellationButton()
        self.messagesSelector.isActive = true
        self.enqueueModelUpdate(updateType: .normal)
    }

    // MARK: - Cancellation

    private func setupCancellationButton() {
        let cancel = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(handleCancellationButtonTap)
        )
        let delete = UIBarButtonItem(
            title: "Delete",
            style: .plain,
            target: self,
            action: #selector(handleDeleteButtonTap)
        )
        let add = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(handleAddActionButtonTap)
        )
        self.navigationItem.rightBarButtonItems = [cancel,delete,add]
    }

    @objc
    private func handleCancellationButtonTap() {
        self.setupSelectionButton()
        self.messagesSelector.isActive = false
        self.enqueueModelUpdate(updateType: .normal)
    }
    
    @objc
    private func handleDeleteButtonTap() {
        self.setupSelectionButton()
        self.messagesSelector.isActive = false
        for item in self.messagesSelector.selectedMessages() {
            self.dataSource.removeMessage(withUID: item.uid)
        }
        self.enqueueModelUpdate(updateType: .normal)
    }
    
    @objc
    private func handleAddActionButtonTap() {
        self.setupSelectionButton()
        self.messagesSelector.isActive = false
        self.dataSource.addRandomIncomingMessage()
        self.enqueueModelUpdate(updateType: .pagination)
    }
}
