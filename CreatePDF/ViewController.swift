//
//  ViewController.swift
//  CreatePDF
//
//  Created by 縣美早 on 2019/06/10.
//  Copyright © 2019 縣美早. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    
    let pdfData = NSMutableData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewWillAppear(true)
        self.createPdfFromView(aView: self.view)
        return true
    }
    
    // pdfファイルの出力
    func createPdfFromView(aView: UIView) {
        
        UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil)
        UIGraphicsBeginPDFPage()
        
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        
        aView.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
    
    }
    
    @IBAction func showPDF() {
        
        let activityItems = [pdfData]
        
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
        
    }
}

