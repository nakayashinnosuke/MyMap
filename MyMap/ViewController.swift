//
//  ViewController.swift
//  MyMap
//
//  Created by macuser on 2019/04/16.
//  Copyright © 2019 Swift-Beginners. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    // Text Fieldのdelegate通知先を設定する
    Txt_Input.delegate = self
    }

    
    @IBOutlet weak var Map_Display: MKMapView!
    @IBOutlet weak var Txt_Input: UITextField!
    
    // 入力された文字の取得
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        // 入力された文字列を取り出す
        if let searchKey = Txt_Input.text {
        
            // 入力された文字列をデバックエリアに表示
            print(searchKey)
        
            // CLGeocoderインスタンスをする
            let geocoder = CLGeocoder()
            
            // 入力された文字から位置情報を取得する
            geocoder.geocodeAddressString(searchKey, completionHandler: { (Placemarks , Error)
                in
                
                // 位置情報が存在する場合はunwrapPlacemarksに代入する
                if let unwrapPlacemarks = Placemarks{
                    
                    // １件目の情報をfirstPlacemarkにf代入する
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        
                        // 位置情報をlocationに代入する
                        if let location = firstPlacemark.location {
                            
                            // 位置情報から緯度経度をtargetCoordinateに代入する
                            let targetCoordinate = location.coordinate
                            
                            // 緯度経度をデバックエリアに表示
                            print(targetCoordinate)
                            
                            // MKPointAnnotationインスタンスを取得しおピンを生成する
                            let pin = MKPointAnnotation()
                            
                            // ピンを配置する位置に経度緯度情報を設定する
                            pin.coordinate = targetCoordinate
                            
                            // ピンのタイトルに住所名を設定する
                            pin.title = firstPlacemark.name
                            
                            //ピンを地図に配置する
                            self.Map_Display.addAnnotation(pin)
                            
                            // 緯度経度を中心に５００m範囲を表示する
                            self.Map_Display.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        
                    } } } } )
                
            }
        
        // デフォルト動作のためTrueで返却する
        return true
        }
    
    
    @IBAction func Btn_ChangeMap(_ sender: Any) {
        // MapTypeプロパティをトグル
        // 標準　→ 航空写真　→ 航空写真＋標準　→ 3D FFloyover → 3D FFloyover＋標準　→ 交通機関
        if Map_Display.mapType == .standard {
            Map_Display.mapType = .satellite
        }else if Map_Display.mapType == .satellite{
            Map_Display.mapType = .hybrid
        }else if Map_Display.mapType == .hybrid{
            Map_Display.mapType = .satelliteFlyover
        }else if Map_Display.mapType == .satelliteFlyover{
            Map_Display.mapType = .hybridFlyover
        }else if Map_Display.mapType == .hybridFlyover{
            Map_Display.mapType = .mutedStandard
        }else{
            Map_Display.mapType = .standard
        }
        
    }
    
}
    
    
    


