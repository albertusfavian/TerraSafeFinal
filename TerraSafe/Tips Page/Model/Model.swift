//
//  Model.swift
//  pageController
//
//  Created by Mac-albert on 15/06/21.
//

import Foundation
import UIKit

public struct TipDetail{
    var titleTips: String
    var imageTips : String
    var bodyTips: String
    
    init(title:String, image:String, body:String){
        titleTips = title
        imageTips = image
        bodyTips = body
    }
}

public struct Tip{
    var id: Int
    var title: String
    var category: [TipDetail]
    var image : String
}

public var Tips = [
    Tip(id: 0, title: "Determining Direction", category: DeterminingDirection, image: "img_DeterminingDirection"),
    Tip(id: 1, title: "Terrain Conditions", category: TerrainConditions, image: "img_TerrainConditions"),
    Tip(id: 2, title: "Sign For Lost", category: SignForLost, image: "img_SignForLost"),
    Tip(id: 3, title: "Lensatic Compass", category: LensaticCompass, image: "img_LensaticCompass"),
]



public var DeterminingDirection = [
    TipDetail(title: "Observing plants or grasses", image: "DeterminingDirection.1", body: "Observe nearby grasses or plants available and define their sprout’s orientation. Plants or trees will grow according to sunrise because of phototropism. Sun will always rise from the East."),
    TipDetail(title: "Examining nearby trees", image: "DeterminingDirection.2", body: "Check for mosses growing on a tree. Moss can only grow when supplied with the sun's energy, which always rises from the east. Part of the tree with many mosses indicates it is heading to the east."),
    TipDetail(title: "Navigate the sun’s rising", image: "DeterminingDirection.3", body: "Pay attention to the sun when hiking. When facing where the sun rises, our left represents north and the right represents south. Similarly, when facing where the sun goes down, our left represents south and the right represents north."),
    TipDetail(title: "Star patterns", image: "DeterminingDirection.4", body: "Ursa Major is one of the star constellations frequently used for navigation and represents north. The Ursa Major is the most distinct pattern. Its pattern resembles a scoop with a handle. (North)")
]

public var TerrainConditions = [
    TipDetail(title: "Class 1", image: "TerrainConditions.1", body: "Class 1 hike is a low-risk hike on a well-marked trail. Class 1 hikes are often found on mountains with high popularity. Example: Mountain Papandayan in West Java"),
    TipDetail(title: "Class 2", image: "TerrainConditions.2", body: "Class 2 hike is a medium-risk hike that usually uses the most common trails left by hikers. Class 2 hike trails aren’t as developed as Class 1 trails and might need the hands to provide extra balance. Proceed these trails with caution. Example: Mountain Ciremai in West Java"),
    TipDetail(title: "Class 3", image: "TerrainConditions.3", body: "Class 3 hikes are similar to class 2 hike trails but with additional rugged sections. Almost all body parts must coordinate to provide maximum balance when scrambling across large rocks, steep slopes, or both. Additional safety tools such as ropes can provide extra safety. Make sure to meet the physical requirements before hiking on Class 3 Example: Mountain Salak in West Java"),
    TipDetail(title: "Class 4", image: "TerrainConditions.4", body: "Class 4 trails are considered to be more of a climbing or mountaineering route than a hiking trail. These types of trails are not recommended for beginners or casuals. Safety tools are required to navigate through these trails. Ropes, harnesses, and belay devices are a must on these trails. Example: Gunung Parang in West Java"),
    TipDetail(title: "Class 5", image: "TerrainConditions.5", body: "Class 5 trails are known as rock climbing routes. There are high-level mountains that need climbing as the means to reach the summit. Full safety equipment is needed. Mistakes along climbing the route can result in instant death. Never hike on these mountains unless full preparations and risks-understanding are met, because full preparation does not diminish the chance of death. Example: Mountain Cartenz in Papua")
]

public var SignForLost = [
    TipDetail(title: "Fire", image: "SignForLost.1", body: "Fire is an effective signal to call for help. SAR Team can easily find fire visuals in the night. The international sign for difficulties while hiking or mountaineering is creating three fires separately in the shape of a triangle. When alone, opt to start one fire only. Beware when creating fire visuals so the fire won’t spread and create massive forest fires."),
    TipDetail(title: "Aluminium Foil Blanket", image: "SignForLost.2", body: "Aluminium blankets (commonly known as emergency blankets) can help to create SOS visuals. In the morning, find an open field and point the aluminium blanket against the sun. This will help to reflect sunlight which makes it easy for the SAR Team to find your location."),
    TipDetail(title: "Branches on open field", image: "SignForLost.3", body: "When navigating alone or lost, use nearby branches to create an arrow sign to notify other hikers about your location. Don’t stray too far from the sign, unless you need to find an open field. If an open field is too far, create multiple signs."),
    TipDetail(title: "Smoke", image: "SignForLost.4", body: "Smoke works great to notify the SAR Team or nearby people when you are lost. Mind the smoke color. Black smoke is used when in a bright open field and can be created by burning plastics, cloths, or rubbers. Meanwhile, white smoke is used when in a dark field and can be created by burning nearby dead plants."),
    TipDetail(title: "Whistle tool", image: "SignForLost.5", body: "Whistles used to create sound to notify others of your presence. Some special whistles can produce sound with up to 1.6 kilometers reach. Blow the whistles according to the SOS signal which you can learn on the internet.")
]

public var LensaticCompass = [
    TipDetail(title: "Introduction", image: "LensaticCompass.1", body: "Lensatic compass (known as “kompas tembak” in Indonesian) is a special compass used for navigation outdoors. It is a powerful tool to determine one’s location without using any telecommunication signals, using the help of topographic maps and other navigation tools."),
    TipDetail(title: "Anatomy", image: "LensaticCompass.2", body: "The lensatic compass is divided into two main sections, the base and the cover. The cover is needed to aim for certain natural objects while the base is for determining its information."),
    TipDetail(title: "Initial Usage", image: "LensaticCompass.3", body: "To start using the lensatic compass, first open the cover perpendicularly, then Aim the sighting wire to the nature objects available. Nature objects can be anything, but if it’s available on the topographic map, the better. Remember to aim steadily, or you can use the help of a flat surface. "),
    TipDetail(title: "Aiming with the compass", image: "LensaticCompass.4", body: "While aiming the sighting wire to the nature objects, slowly bring the compass closer to the eye. Peek the number in the compass through the lens, while still aiming for the object. The number written is the azimuth number."),
    TipDetail(title: "Determine the location", image: "LensaticCompass.5", body: "Make sure the compass’ needle stops reacting. Slowly lower the compass, and see the number written in the inner circle. The inner circle’s number that matches with the yellow line’s position represents the object's location, in accordance with our current location. "),
    TipDetail(title: "Repeat", image: "LensaticCompass.5", body: "Repeat step 3 until step 5 as you navigate closer to the object. This will help to point our location in the topographic map. Make sure to learn about resection and intersection of land navigation to help pinpoint your current location in the map.")
    
]
