//
//  ViewController.swift
//  MyLamp
//
//  Created by Larissa Cavalcante on 12/10/15.
//  Copyright © 2015 Larissa Cavalcante. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var presenceImageView: UIImageView!
    
    @IBOutlet weak var offSensorButton: UIButton!
    
    @IBOutlet weak var onSensorButton: UIButton!
    
    @IBOutlet weak var bedroomButton: UIButton!
    
    @IBOutlet weak var roomButton: UIButton!
    
    var bedroomOn =  true
    
    var roomOn = true
    
    var socket: TCPClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket = TCPClient(addr: "192.168.1.110", port: 5000)
        
        let (success, result) = socket.connect(timeout: 10)
        
        if success {
            
            print(result)
            
        } else {
                
            let alert = UIAlertController(title: result, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancel = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            
            alert.addAction(cancel)
            
            presentViewController(alert, animated: true, completion: nil)
        }
    
    }
    
    @IBAction func offSensor(sender: AnyObject) {
        
        let (success, result) = socket.send(str: "pird")
        
        if success {
            
            let offImage = UIImage(named: "sensor_off_selected")
            
            offSensorButton.setImage(offImage, forState: UIControlState.Normal)
            
            let onImage = UIImage(named: "sensor_on_unselected")
            
            onSensorButton.setImage(onImage, forState: UIControlState.Normal)
            
            presenceImageView.image = UIImage(named: "sensor_indicator_off")
            
        } else {
            
            print(result)
        }

    }
    
    @IBAction func onSensor(sender: AnyObject) {
        
        let (success, result) = socket.send(str: "pirl")
        
        if success {
            
            let offImage = UIImage(named: "sensor_off_unselected")
            
            offSensorButton.setImage(offImage, forState: UIControlState.Normal)
            
            let onImage = UIImage(named: "sensor_on_selected")
            
            onSensorButton.setImage(onImage, forState: UIControlState.Normal)
            
            presenceImageView.image = UIImage(named: "sensor_indicator_on")
            
        } else {
            
            print(result)
        }
        
    }
    
    
    @IBAction func bedroomMode(sender: AnyObject) {
        
        if(bedroomOn) {
            
            let (success, result) = socket.send(str: "quartod")
            
            if success {
                
                let image = UIImage(named: "quarto_button_off")
                
                bedroomButton.setImage(image, forState: UIControlState.Normal)
                
                bedroomOn = false
                
            } else {
                
                print(result)
            }
            
            
        } else {
            
            let (success, result) = socket.send(str: "quartol")
            
            if success{
                
                let image = UIImage(named: "quarto_button_on")
                
                bedroomButton.setImage(image, forState: UIControlState.Normal)
                
                bedroomOn = true
                
            } else {
                
                print(result)
            }
        }

    }
    
    @IBAction func roomMode(sender: AnyObject) {
        
        if(roomOn) {
            
            let (success, result) = socket.send(str: "salad")
            
            if success{
                
                let image = UIImage(named: "sala_button_off")
                
                roomButton.setImage(image, forState: UIControlState.Normal)
                
                roomOn = false
                
            } else {
                
                print(result)
            }
            
            
        } else {
            
            let (success, result) = socket.send(str: "salal")
            
            if success {
                
                let image = UIImage(named: "sala_button_on")
                
                roomButton.setImage(image, forState: UIControlState.Normal)
                
                roomOn = true
                
            } else {
                
                print(result)
            }
        }

    }

}

