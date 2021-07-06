//
//  ImageGestureVC.swift
//  ImaGestures
//
//  Created by MacBook Pro on 04/07/21.
//

import UIKit
import Foundation


class ImageGestureVC: UIViewController {

    private let imagepicker : UIImagePickerController = {
        let imagepicker = UIImagePickerController()
        imagepicker.allowsEditing = false
        return imagepicker
    } ()
    
    private let imageview : UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(systemName: "folder.badge.plus")
        
        return imageview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        title = "Image Gesture"
        view.addSubview(imageview)
        imagepicker.delegate = self
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(selectImg))
        tapgesture.numberOfTapsRequired = 1
        tapgesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapgesture)
        
        
        let pinchgesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchgst))
        view.addGestureRecognizer(pinchgesture)
        
        let rotationgesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationgst))
        view.addGestureRecognizer(rotationgesture)
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeleft.direction = .left
        view.addGestureRecognizer(swipeleft)
       
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swiperight.direction = .right
        view.addGestureRecognizer(swiperight)
        
        let swipeup = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeup.direction = .up
        view.addGestureRecognizer(swipeup)
        
        let swipedown = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipedown.direction = .down
        view.addGestureRecognizer(swipedown)
        
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(pangst))
        view.addGestureRecognizer(pangesture)
    }
    
 
    override func viewDidLayoutSubviews() {
        imageview.frame = CGRect(x: 140, y: view.safeAreaInsets.top + 170, width: 100, height: 100)
    }


}

extension ImageGestureVC {
 @objc private func selectImg( _ gesture:UITapGestureRecognizer)
 {
     print("function called")
     imagepicker.sourceType = .photoLibrary
     DispatchQueue.main.async {
         self.present(self.imagepicker, animated: true)
     }
    
 }
    @objc private func pinchgst(_ gesture:UIPinchGestureRecognizer)
    {
        imageview.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    
    @objc private func rotationgst( _ gesture:UIRotationGestureRecognizer)
    {
        imageview.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    @objc private func swipe(_ gesture:UISwipeGestureRecognizer)
    {
        if(gesture.direction == .left)
        {
            UIView.animate(withDuration: 0.5) {
                self.imageview.frame = CGRect(x: self.imageview.frame.origin.x - 40, y: self.imageview.frame.origin.y, width: 100, height: 100)
            }
            
        }
            
        else if(gesture.direction == .right)
        {
            UIView.animate(withDuration: 0.5) {
                self.imageview.frame = CGRect(x: self.imageview.frame.origin.x + 40, y: self.imageview.frame.origin.y, width: 100, height: 100)
            }
        }
        else if(gesture.direction == .up)
        {
            UIView.animate(withDuration: 0.5) {
                self.imageview.frame = CGRect(x: self.imageview.frame.origin.x, y: self.imageview.frame.origin.y - 40, width: 100, height: 100)
            }
        }
        else if(gesture.direction == .down)
        {
            UIView.animate(withDuration: 0.5) {
                self.imageview.frame = CGRect(x: self.imageview.frame.origin.x, y: self.imageview.frame.origin.y + 40, width: 100, height: 100)
            }
           
        }
        else
        {
            print("Could not detect")
        }
    }
    @objc private func pangst(_ gesture:UIPanGestureRecognizer)
    {
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        imageview.center = CGPoint(x: x, y: y)
    }
}

extension ImageGestureVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedimg = info[.originalImage] as? UIImage {
            imageview.image = selectedimg
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}

