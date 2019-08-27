//
//  DetailViewController.swift
//  Homepwner
//
//  Created by xionghao on 2019/8/23.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate,
    UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet var itemImageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - 生命周期方法
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        // 显示图片
        itemImageView.image = imageStore.image(forKey: item.itemKey)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    // MARK: - Action方法
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        // 这里的View是DetailViewController的root view, view会检查每一个subview
        // 是否是first responder，如果是，则调用view的resignFirstResponder()方法
        view.endEditing(true)
        print("backgroundTapped")
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 从Info字典中选取图片
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageStore.setImage(image, forKey: item.itemKey)
        itemImageView.image = image
        dismiss(animated: true, completion: nil)
        
        print("save image: \(item.itemKey)")
    }
}
