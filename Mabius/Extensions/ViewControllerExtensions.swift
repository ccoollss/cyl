//
//  ViewControllerExtensions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 12.05.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation
import UIKit
import Localize

extension NSError
{
    override open var description: String { return self.localizedDescription }
}

protocol ErrorPresenting
{
    func showError(_ error: Error, completion: @escaping () -> ())
}

extension UIViewController: ErrorPresenting
{
    func showError(_ error: Error, completion: @escaping () -> ())
    {
        let str = String(describing: error)
        alert("Errors.error".localize(), message: str, cancel: "OK")
    }
}

extension UINavigationController
{
    func viewController(_ vc: AnyClass) -> UIViewController?
    {
        for obj in self.viewControllers {
            if obj.isKind(of: vc) {
                return obj
            }
        }
        return nil
    }
}

extension UIViewController
{
    /*!
     * Title with message and 'Done' button
     */
    func alert(_ title: String?, message: String?) {
        alert(title, message: message, cancel: nil, buttons: nil, completion: nil)
    }
    /*!
     * Title with message, 'Done' button and completion block
     */
    func alert(_ title: String?, message: String?, completion: (() -> Void)?) {
        alert(title, message: message, cancel: nil, buttons: nil, completion: { _ in
            if completion != nil {
                completion!()
            }
        })
    }
    /*!
     * Title with message and button title
     */
    func alert(_ title: String?, message: String?, cancel: String?) {
        alert(title, message: message, cancel: cancel, buttons: nil, completion: nil)
    }
    /*!
     * Title with message, cancel button title and completion block
     */
    func alert(_ title: String?, message: String?, cancel: String?, completion: (() -> Void)?) {
        alert(title, message: message, cancel: cancel, buttons: nil, completion: { _ in
            if completion != nil {
                completion!()
            }
        })
    }
    /*!
     * Title with message, cancel button title, others buttons titles array and completion block
     */
    func alert(_ title: String?, message: String?, cancel: String?, buttons: [String]?, completion: ((UIAlertAction) -> Void)?) {
        if presentingViewController != nil { return }

        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var cancelTitle: String = NSLocalizedString("Done", comment:"")
        if cancel != nil {
            cancelTitle = cancel!
        }
        let action: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (alertAction) in
            if completion != nil {
                completion!(alertAction)
            }
        })
        alert.addAction(action)
        
        if buttons != nil {
            for buttonTitle in buttons! {
                let action: UIAlertAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (alertAction) in
                    if completion != nil {
                        completion!(alertAction)
                    }
                })
                alert.addAction(action)
            }
        }
        
        present(alert, animated: true, completion: nil)
    }
    /*!
     * Title with message, cancel button title, others buttons titles array and completion block
     */
    func actionSheet(_ title: String?, message: String?, cancel: String?, buttons: [String]?, completion: ((_ title: String) -> Void)?) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        var cancelTitle: String = NSLocalizedString("Cancel", comment:"")
        if cancel != nil {
            cancelTitle = cancel!
        }
        let action: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (alertAction) in
            
        })
        alert.addAction(action)
        
        if buttons != nil {
            for buttonTitle in buttons! {
                let action: UIAlertAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (alertAction) in
                    if completion != nil {
                        completion!(buttonTitle)
                    }
                })
                alert.addAction(action)
            }
        }
        
        let presenter: UIViewController = (self.navigationController != nil) ? self.navigationController! : self
        presenter.present(alert, animated: true, completion: nil)
    }
}


import ObjectiveC

private var pickerDataAssociationKey: UInt8 = 0
private var pickerTagAssociationKey: UInt8 = 0

extension UIViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    var pickerData: [String:Int]?
    {
        get
        {
            return objc_getAssociatedObject(self, &pickerDataAssociationKey) as? [String:Int]
        }
        set(newValue)
        {
            objc_setAssociatedObject(self, &pickerDataAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            picker()?.reloadAllComponents()
        }
    }
    
    var pickerTag: Int!
        {
        get
        {
            return objc_getAssociatedObject(self, &pickerTagAssociationKey) as? Int
        }
        set(newValue)
        {
            objc_setAssociatedObject(self, &pickerTagAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
//    func pickerView(delegate: UIPickerViewDelegate?, dataSource: UIPickerViewDataSource?, done: Selector)
//    {
//        let view = UIView(frame: UIScreen.mainScreen().bounds)
//        view.backgroundColor = UIColor.blackColor()
//        view.alpha = 0
//        view.tag = 123321
//        
//        let container = UIView(frame: CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), 200))
//        container.tag = 123322
//        container.backgroundColor = UIColor.whiteColor()
//        
//        let toolbar = UIToolbar(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40))
//        toolbar.barStyle = .Default
//        let b1 = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
//        let b2 = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: done)
//        toolbar.setItems([b1, b2], animated: false)
//        
//        let picker = UIPickerView(frame: CGRectMake(0, 40, CGRectGetWidth(container.frame), CGRectGetHeight(container.frame) - 40))
//        picker.dataSource = self
//        picker.delegate = self
//        picker.tag = 123323
//        container.addSubview(picker)
//        container.addSubview(toolbar)
//        
//        self.view.addSubview(view)
//        self.view.addSubview(container)
//    }
    
    func setupPickerView(_ data: [String:Int], done: Selector)
    {
        pickerData = data
        
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black
        view.alpha = 0
        view.tag = 123321
        
        let container = UIView(frame: CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 200))
        container.tag = 123322
        container.backgroundColor = UIColor.white
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40))
        toolbar.barStyle = .default
        let b1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let b2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: done)
        toolbar.setItems([b1, b2], animated: false)
        
        let picker = UIPickerView(frame: CGRect(x: 0, y: 40, width: container.frame.width, height: container.frame.height - 40))
        picker.dataSource = self
        picker.delegate = self
        picker.tag = 123323
        picker.isHidden = true
        container.addSubview(picker)
        container.addSubview(toolbar)
        
        let datepicker = UIDatePicker(frame: CGRect(x: 0, y: 40, width: container.frame.width, height: container.frame.height - 40))
        datepicker.datePickerMode = .dateAndTime
        datepicker.minimumDate = Date()
        datepicker.tag = 223323
        datepicker.isHidden = true
        container.addSubview(datepicker)
        
        self.view.addSubview(view)
        self.view.addSubview(container)
    }
    
    func showPicker()
    {
        showPicker(false)
    }
    
    func showDatePicker()
    {
        showPicker(true)
    }
    
    func showPicker(_ datePicker: Bool)
    {
        let fade = self.view.viewWithTag(123321)
        let container = self.view.viewWithTag(123322)
        let picker = self.view.viewWithTag(123323)
        let datepicker = self.view.viewWithTag(223323)
        picker?.isHidden = datePicker
        datepicker?.isHidden = !datePicker
        var rect = container?.frame
        rect?.origin.y = self.view.bounds.height - 200;
        UIView.animate(withDuration: 0.3) {
            fade?.alpha = 0.4
            container?.frame = rect!
        }
    }
    
    func hidePicker()
    {
        let fade = self.view.viewWithTag(123321)
        let container = self.view.viewWithTag(123322)
        var rect = container?.frame
        rect?.origin.y = self.view.bounds.height
        UIView.animate(withDuration: 0.3) {
            fade?.alpha = 0
            container?.frame = rect!
        }
    }
    
    func picker() -> UIPickerView?
    {
        return self.view.viewWithTag(123323) as? UIPickerView
    }
    
    func datePicker() -> UIDatePicker?
    {
        return self.view.viewWithTag(223323) as? UIDatePicker
    }
    
    func pickerSelectedValue() -> Int?
    {
        let picker = self.view.viewWithTag(123323) as? UIPickerView
        guard let row = picker?.selectedRow(inComponent: 0), let values = pickerData?.values, !Array(values).isEmpty else { return nil }
        return Array(values)[row]
    }
    
    func pickerSelectedTitle() -> String?
    {
        let picker = self.view.viewWithTag(123323) as? UIPickerView
        
        guard let row = picker?.selectedRow(inComponent: 0), let keys = pickerData?.keys, !Array(keys).isEmpty else { return nil }
        return Array(keys)[row]
    }
    
    func pickerSelectedDate() -> Date
    {
        let datepicker = self.view.viewWithTag(223323) as? UIDatePicker
        return (datepicker?.date)!
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let count = pickerData?.count else { return 0 }
        return count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let keys = pickerData?.keys else { return nil }
        return Array(keys)[row]
    }
    
    func setDatePickerMinimumDate(with date: Date) {
        let datepicker = self.view.viewWithTag(223323) as? UIDatePicker
        datepicker?.minimumDate = date
    }
}

