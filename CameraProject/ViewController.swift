//
//  ViewController.swift
//  CameraProject
//
//  Created by shunya endoh on 2019/11/19.
//  Copyright © 2019 shunya endoh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func runCamera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = .camera
            cameraPicker.delegate = self
            present(cameraPicker, animated: true, completion: nil)
        } else {
            print("カメラが使用できません")
        }
    }
    
    @IBAction func runAlbum(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("フォトライブラリが使用できません")
        }
    }
    
    @IBAction func savePhoto(_ sender: UIButton) {
        let image = imageView.image
            
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(
            image!,
            self,
            #selector(didFinishSavePhoto(_:didFinishSavingWithError:contextInfo:)),
            nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            imageView.contentMode = .scaleAspectFit
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func didFinishSavePhoto(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print("写真の保存に失敗しました。")
            print(error.code)
        } else {
            print("写真を保存しました")
        }
    }
    
}

