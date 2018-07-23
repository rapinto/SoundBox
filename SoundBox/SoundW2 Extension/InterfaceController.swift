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
    
    
    var _audioPlayer : AVAudioPlayerNode!
    var _audioEngine : AVAudioEngine!
    
    
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
        
        self.playAudio(soundName: soundItem.soundName)
    }

    
    func playAudio(soundName: String)
    {
        if (_audioPlayer==nil) {
            _audioPlayer = AVAudioPlayerNode()
            _audioEngine = AVAudioEngine()
            _audioEngine.attach(_audioPlayer)
            
            let stereoFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 2)
            _audioEngine.connect(_audioPlayer, to: _audioEngine.mainMixerNode, format: stereoFormat)
            
            do {
                
                if !_audioEngine.isRunning {
                    try _audioEngine.start()
                }
                
            } catch {}
            
        }
        
        
        if let path = Bundle.main.path(forResource: soundName, ofType: "wav") {
            
            let fileUrl = URL(fileURLWithPath: path)
            
            do {
                let asset = try AVAudioFile(forReading: fileUrl)
                
                _audioPlayer.scheduleFile(asset, at: nil, completionHandler: nil)
                _audioPlayer.play()
                
            } catch {
                print ("asset error")
            }
            
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
