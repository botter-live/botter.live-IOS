//
//  VoiceRecognition.swift
//  Botter
//
//  Created by Nora on 10/13/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import Speech
import Accelerate

extension b_ChatViewController : SFSpeechRecognizerDelegate {
    
    
    @IBAction func miceButtonTapped(_ sender: UIButton) {
        if isRecording == true {
            //                cancelRecording()
            //                isRecording = false
            //////                startButton.backgroundColor = UIColor.gray
            ////                miceBtn.alpha = 0.5
            
        } else {
            self.view.endEditing(true)
            self.recordAndRecognizeSpeech()
            isRecording = true
            miceBtn.alpha = 1.0
            keyBoardBtn.alpha = 0.5
            //                startButton.backgroundColor = UIColor.red
            micView.isHidden = false
            self.recordingTs = NSDate().timeIntervalSince1970
            self.silenceTs = 0
            detectedStr = ""
        }
    }
    
    
    @IBAction func keyboardButtonTapped(_ sender: UIButton) {
        if isRecording == true {
            cancelRecording()
            isRecording = false
            miceBtn.alpha = 0.5
            keyBoardBtn.alpha = 1.0
            micView.isHidden = true
            //                startButton.backgroundColor = UIColor.gray
        }
    }
    
    func cancelRecording() {
        recognitionTask?.finish()
        recognitionTask = nil
        
        // stop audio
        request.endAudio()
        request = SFSpeechAudioBufferRecognitionRequest()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        isRecording = false
    }
    
    //MARK: - Recognize Speech
    func recordAndRecognizeSpeech() {
        //            audioEngine = AVAudioEngine()
        configureAudioSession()
        audioEngine.inputNode.removeTap(onBus: 0)
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.audioGraphUpdate(buffer: buffer)
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
            //                audioEngine.inputNode.
        } catch {
            self.sendAlert(title: "Speech Recognizer Error", message: "There has been an audio engine error.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                
                //                    var lastString: String = ""
                //                    for segment in result.bestTranscription.segments {
                //                        let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                //                        lastString = String(bestString[indexTo...])
                //                    }
                //
                self.detectedStr = bestString
                if self.speechTimer != nil
                {
                    if (self.speechTimer?.isValid)!
                    {
                        self.speechTimer?.invalidate()
                    }
                    self.speechTimer = nil;
                }
                print(result.bestTranscription.formattedString as Any)
                
                self.speechTimer = Timer.scheduledTimer(withTimeInterval: 1 , repeats: false, block: { [self] (timer) in
                    if self.detectedStr != "" && !result.isFinal{
                        if BotterSettingsManager.language == .arabic{
                            self.detectedStr = detectedStr.stripDiacritics
                        }
                        print(self.detectedStr)
                        self.presenter.sendMessage(text: self.detectedStr)
                    }
                    self.keyBoardBtn.sendActions(for: .touchUpInside)
                   
                    print("Recognition task restart")
                })
                
//                if result.isFinal {
//                    self.presenter.sendMessage(text: bestString)
//                }
                
                
            } else if let error = error {
                //                    self.sendAlert(title: "Speech Recognizer Error", message: "There has been a speech recognition error.")
                //                    self.keyBoardBtn.sendActions(for: .touchUpInside)
                print(error)
            }
        })
    }
    
    
    //MARK: - Check Authorization Status
    func requestSpeechAuthorization() {
        speechRecognizer = SFSpeechRecognizer.init(locale: NSLocale.init(localeIdentifier: (BotterSettingsManager.language == .arabic) ? "ar" : "en-US") as Locale)
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.miceBtn.isEnabled = true
                case .denied:
                    self.miceBtn.isEnabled = false
                //                    self.detectedTextLabel.text = "User denied access to speech recognition"
                case .restricted:
                    self.miceBtn.isEnabled = false
                //                    self.detectedTextLabel.text = "Speech recognition restricted on this device"
                case .notDetermined:
                    self.miceBtn.isEnabled = false
                //                    self.detectedTextLabel.text = "Speech recognition not yet authorized"
                @unknown default:
                    return
                }
            }
        }
    }
    
    func sendAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { }
    }
    
    func audioGraphUpdate(buffer : AVAudioPCMBuffer){
        let level: Float = -50
        let length: UInt32 = 1024
        buffer.frameLength = length
        let channels = UnsafeBufferPointer(start: buffer.floatChannelData, count: Int(buffer.format.channelCount))
        var value: Float = 0
        vDSP_meamgv(channels[0], 1, &value, vDSP_Length(length))
        var average: Float = ((value == 0) ? -100 : 20.0 * log10f(value))
        if average > 0 {
            average = 0
        } else if average < -100 {
            average = -100
        }
        let silent = average < level
        let ts = NSDate().timeIntervalSince1970
        if ts - self.renderTs > 0.1 {
            let floats = UnsafeBufferPointer(start: channels[0], count: Int(buffer.frameLength))
            let frame = floats.map({ (f) -> Int in
                return Int(f * Float(Int16.max))
            })
            DispatchQueue.main.async { [self] in
                let seconds = (ts - self.recordingTs)
                //                self.timeLabel.text = seconds.toTimeString
                self.renderTs = ts
                let len = self.audioGraphView.waveforms.count
                for i in 0 ..< len {
                    let idx = ((frame.count - 1) * i) / len
                    let f: Float = sqrt(1.5 * abs(Float(frame[idx])) / Float(Int16.max))
                    self.audioGraphView.waveforms[i] = min(49, Int(f * 50))
                }
                self.audioGraphView.active = !silent
//                if silent{
//                    cancelRecording()
//                    miceBtn.sendActions(for: .touchUpInside)
//                }
                self.audioGraphView.setNeedsDisplay()
            }
        }
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if !available{
            if isRecording{
                keyBoardBtn.sendActions(for: .touchUpInside)
            }
        }
    }
}
extension String {
    /// strip combining marks (accents or diacritics)
    var stripDiacritics: String {
        let vowels : [Character] = ["َ", "ِ", "ّ", "ْ", "ُ", "ٌ", "ً", "ٍ" , "\u{200f}"]
        var str = self
        for i in vowels{
            str = self.replacingOccurrences(of: "\(i)", with: "")
        }
        return str
    }
}
