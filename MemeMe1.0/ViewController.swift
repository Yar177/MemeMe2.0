//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Yar Sher on 1/28/19.
//  Copyright © 2019 Yar Sher. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraPickerButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var buttomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    let textFieldDeleget = TextFieldDelegate()
    
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
        
    }
    
    
    let textAttributes:[NSAttributedString.Key: Any] = [
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -4.0]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraPickerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
        topTextField.text = "TOP"
        buttomTextField.text = "Bottom"
        setStyle(toTextField: topTextField)
        setStyle(toTextField: buttomTextField)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyoardNotifications()
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        
       if buttomTextField.isFirstResponder{
            view.frame.origin.y = -getKeyboardHeight(notification)
       }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        if view.frame.origin.y != 0{
            view.frame.origin.y = 0
        }
        
    }
    
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyoardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    @IBAction func pickAnImage(_ sender: Any) {
        openImagePicker(.photoLibrary)
    }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        openImagePicker(.camera)
    }
    
    
    
    func openImagePicker(_ type: UIImagePickerController.SourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = type
        present(pickerController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func shareMeme(_ sender: Any) {
        let image = generateMemeImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed){
                self.save(image: image)
            }
            //Dismiss the shareActivityViewController
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.isEnabled = true
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func save(image: UIImage) -> UIImage{
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: buttomTextField.text!, originalImage: imagePickerView.image!, memedImage: image)
        return meme.memedImage
    }
    
    func generateMemeImage() -> UIImage{
        hideToolbars(true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideToolbars(false)
        return memedImage
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        imagePickerView.image = nil
        topTextField.text = "Top"
        buttomTextField.text = "Bottom"
        shareButton.isEnabled = false
    }
    
    
    func setStyle(toTextField textField: UITextField) {
        textField.delegate = textFieldDeleget
        textField.defaultTextAttributes = textAttributes
        textField.textAlignment = .center
            }
    
    
    
    func hideToolbars(_ hide: Bool) {
        topToolbar.isHidden = hide ? true : false
        bottomToolbar.isHidden = hide ? true : false        
    }

}

