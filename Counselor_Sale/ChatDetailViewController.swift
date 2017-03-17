//
//  ChatDetailViewController.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 3. 8..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit
import SDWebImage

class ChatDetailViewController: JSQMessagesViewController {

    var messages = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.senderId = "1"
        self.senderDisplayName = "Teddy"
        setupBackButton()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func backButtonTapped() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        
        print("didPressSend")
        print("\(text)")
        print("\(senderId)")
        print("\(senderDisplayName)")
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)!)
        collectionView.reloadData()
        
        print(messages)

    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
        let sheet = UIAlertController(title: "Media Messages", message: "Please Select a media", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소하기", style: .cancel, handler: nil)
        
        let photoLibrary = UIAlertAction(title: "photo Library", style: .default) { (alert: UIAlertAction) in
            self.getMediaFrom(type: kUTTypeImage)
        }
        
        let videoLibrary = UIAlertAction(title: "video Library", style: .default) { (alert: UIAlertAction) in
            self.getMediaFrom(type: kUTTypeMovie)
        }
        
        sheet.addAction(photoLibrary)
        sheet.addAction(videoLibrary)
        sheet.addAction(cancel)
        
        self.present(sheet, animated: true, completion: nil)
    }
    
    func getMediaFrom(type: CFString) {
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = self
        mediaPicker.mediaTypes = [type as String]
        self.present(mediaPicker, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        cell.textView.font = UIFont.AppleSDGothicNeoMedium(ofSize: 15)
        
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }

        return cell
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        print("didTapMessageBubbleAt: \(indexPath.item)")
        let message = messages[indexPath.row]
        if message.isMediaMessage {
            
            if let mediaItem = message.media as? JSQVideoMediaItem {
                let player = AVPlayer(url: mediaItem.fileURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true, completion: nil)
            }
        }
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        return bubbleFactory?.outgoingMessagesBubbleImage(with: .lightGray)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        return nil
    }

}

extension ChatDetailViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let photo = JSQPhotoMediaItem(image: picture)
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: photo))
            
            //            sendMedia(picture, video: nil)
            
        } else if let video = info[UIImagePickerControllerMediaURL] as? URL {
            
            let videoItem = JSQVideoMediaItem(fileURL: video, isReadyToPlay: true)
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: videoItem))
            //            sendMedia(nil, video: video)
            //
        }
        
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
}
