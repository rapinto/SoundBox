//
//  InterfaceController.swift
//  SoundW2 Extension
//
//  Created by rpinto on 20/07/2018.
//  Copyright © 2018 pepper. All rights reserved.
//

import WatchKit
import Foundation
import AVFoundation


class SoundRowController: NSObject {
    
    @IBOutlet var soundTitleLabel: WKInterfaceLabel!
    
}


class InterfaceController: WKInterfaceController {

    
    @IBOutlet var interfaceTable: WKInterfaceTable!
    
    var player: AVAudioPlayer?
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        self.interfaceTable.setNumberOfRows(16, withRowType: "SoundRowController")
        
        
        let soundItems = SoundItem.appSoundItems()
        
        for (item) in soundItems!
        {
            let index = soundItems?.index(of: item)
            
            let row = interfaceTable.rowController(at: index!) as! SoundRowController
            
            let soundItem : SoundItem = item as! SoundItem
            row.soundTitleLabel.setText(soundItem.title)
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
        let soundItems = SoundItem.appSoundItems()
        
        let item = soundItems?.object(at: rowIndex)
        let soundItem : SoundItem = item as! SoundItem
        
        self.playSound2(soundName: soundItem.soundName)
    }
    
    
    func playSound2(soundName: String) {
        let soundPath = Bundle.main.path(forResource: soundName, ofType: "wav")
        let soundPathURL = URL(fileURLWithPath: soundPath!)
        let audioFile = WKAudioFileAsset(url: soundPathURL)
        let audioItem = WKAudioFilePlayerItem(asset: audioFile)
        
        let audioPlayer = WKAudioFilePlayer.init(playerItem: audioItem)
        
        if audioPlayer.status == .readyToPlay
        {
            audioPlayer.play()
        }
        else
        {
            print("Not ready!!")
        }
    }
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
