//
//  ItemList.swift
//  ARHomeStores
//
//  Created by Gabriel Abraham on 10/09/2017.
//  Copyright © 2017 Gabriel Abraham. All rights reserved.
//

import Foundation
import SceneKit


class ItemList{
    
    func addChair() -> SCNNode{
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/rug1.dae")
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray{
            node.addChildNode(childNode as SCNNode)
        }
        return node
    }
    
    func addCup() -> SCNNode{
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/Rug2.dae")
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray{
            node.addChildNode(childNode as SCNNode)
        }
        return node
    }
    func addLamp() -> SCNNode{
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/Rug4.dae")
        let lamp = scene?.rootNode.childNode(withName: "Rug4", recursively: true)
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray{
            node.addChildNode(childNode as SCNNode)
        }
        return lamp!
    }
    func addTable() -> SCNNode{
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/Rug2.dae")
        let table = scene?.rootNode.childNode(withName:"Rug2", recursively: true)
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray{
            node.addChildNode(childNode as SCNNode)
        }
        return table!
    }
    func addVase() -> SCNNode{
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/Rug3.dae")
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray{
            node.addChildNode(childNode as SCNNode)
        }
        return node
    }
    
    
    
    
    
}
