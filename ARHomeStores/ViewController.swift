//
//  ViewController.swift
//  ARHomeStores
//
//  Created by Gabriel Abraham on 10/09/2017.
//  Copyright © 2017 Gabriel Abraham. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var rightRotation: UIButton!
    @IBOutlet weak var leftRotation: UIButton!
    
    var chosenNode = SCNNode()
    let myItem  = ItemList()
    private var newAngleY :Float = 0.0
    private var currentAngleY :Float = 0.0
    
    //  var planes = [OverlayPlane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
      
        registerGestureRecognizer()
    }
    
    
    func registerGestureRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tap)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
        self.sceneView.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer){
        
        let sceneLocation = gestureRecognizer.view as! ARSCNView
        let touchLocation = gestureRecognizer.location(in: sceneLocation)
        let hitResult = self.sceneView.hitTest(touchLocation, types:[.existingPlaneUsingExtent, .estimatedHorizontalPlane])
        
        if hitResult.count > 0{
            guard let hitTestResult = hitResult.first else{
                return
            }
            addItem(hitTestResult: hitTestResult)
            
        }
    }
    
    @objc func panned(recognizer :UIPanGestureRecognizer) {
        
        if recognizer.state == .changed {
            
            guard let sceneView = recognizer.view as? ARSCNView else {
                return
            }
            
            let touch = recognizer.location(in: sceneView)
            let translation = recognizer.translation(in: sceneView)
            
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            
            if let hitTest = hitTestResults.first {
                let chosenNode = hitTest.node
                
                self.newAngleY = Float(translation.x) * (Float) (Double.pi)/180
                self.newAngleY += self.currentAngleY
                chosenNode.eulerAngles.y = self.newAngleY
                
            }
            
        }
            
        else if recognizer.state == .ended {
            self.currentAngleY = self.newAngleY
            
            
        }
        
    }
    
    @objc func pinched(recognizer :UIPinchGestureRecognizer){
        
        if recognizer.state == .changed {
            
            guard let sceneView = recognizer.view as? ARSCNView else {
                return
            }
            
            let touch = recognizer.location(in: sceneView)
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            
            if let hitTest = hitTestResults.first {
                
                let chosenNode = hitTest.node
                
                let pinchScaleX = Float(recognizer.scale) * chosenNode.scale.x
                let pinchScaleY = Float(recognizer.scale) * chosenNode.scale.y
                let pinchScaleZ = Float(recognizer.scale) * chosenNode.scale.z
                
                chosenNode.scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
                
                recognizer.scale = 1 
            }
        }
        
    }
    

    func addItem(hitTestResult: ARHitTestResult){
        
        let itemNode = chosenNode
        let worldPos = hitTestResult.worldTransform
        itemNode.position = SCNVector3(x: worldPos.columns.3.x,y: worldPos.columns.3.y,z: worldPos.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(itemNode)
        deleteBtn.isHidden = false
    }
    
    
    func hiddenButtons(){
        deleteBtn.isHidden = false
   //     leftRotation.isHidden = false
     //   rightRotation.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    @IBAction func chairBtn(_ sender: Any) {
        chosenNode = myItem.addChair()
        hiddenButtons()
    }
    
    @IBAction func tableBtn(_ sender: Any) {
        chosenNode = myItem.addTable()
        hiddenButtons()
    }
    
    @IBAction func vaseBtn(_ sender: Any) {
        chosenNode = myItem.addVase()
        hiddenButtons()
    }
    
    @IBAction func lampBtn(_ sender: Any) {
        chosenNode = myItem.addLamp()
        hiddenButtons()
    }
    @IBAction func cupBtn(_ sender: Any) {
        chosenNode = myItem.addCup()
          hiddenButtons()
    }
    
   
    
    
    @IBAction func deleteButton(_ sender: Any) {
        chosenNode.removeFromParentNode()
        deleteBtn.isHidden = true
        
       
    }
    
    
    
    
    
}
