//
//  TrackingManager.swift
//  Ritual
//
//  Created by Namrata Bandekar on 2018-03-18.
//  Copyright © 2018 Namrata Bandekar. All rights reserved.
//

import Mixpanel

class TrackingManager {
  
  static func initializeMixpanel() {
    #if DEBUG
      Mixpanel.initialize(token: "YOUR_DEBUG_MIXPANEL_TOKEN_HERE")
    #else
      Mixpanel.initialize(token: "YOUR_RELEASE_MIXPANEL_TOKEN_HERE")
    #endif
    Mixpanel.mainInstance().loggingEnabled = true
    
    identifyUser()
  }
  
  static func trackEvent(name: String, eventProperties: [String: MixpanelType]? = nil) {
    Mixpanel.mainInstance().track(event: name,
                                  properties: eventProperties)
  }
  
  static func startTrackingTimedEvent(name: String) {
    Mixpanel.mainInstance().time(event: name)
  }
  
  static func identifyUser() {
    Mixpanel.mainInstance().identify(distinctId: Mixpanel.mainInstance().distinctId)
  }
  
  static func storeUserProperties(userProperties: [String: MixpanelType]) {
    Mixpanel.mainInstance().people.set(properties: userProperties)
  }
}
