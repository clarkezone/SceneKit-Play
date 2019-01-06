import SpriteKit
import UIKit
import PlaygroundSupport

final class SceneController : UIViewController {
    var myScene : SKScene
    var hasPresented : Bool
    init() {
        myScene = SKScene(size: CGSize(width:1024, height: 768))
        hasPresented = false
        super.init(nibName: nil, bundle: nil)
    }
    override required init?(coder aDecoder: NSCoder) {
        fatalError("This method has not been implemented.")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view = SKView()
    }
    var skView: SKView {
        return view as! SKView
    }
    override func viewWillAppear(_ animated: Bool) {
        if (!hasPresented) {
            buildScene()
            skView.presentScene(myScene)
            hasPresented=true
        }
    }
    func buildScene() {
        //Text
        let label = SKLabelNode(text: "Hello Harriet!!")
        label.position = CGPoint(x: myScene.size.width / 2, y: myScene.size.height / 2)
        label.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 20))
        label.physicsBody?.mass = 1
        myScene.addChild(label)
        //Image
        
        let Image = #imageLiteral(resourceName: "avatar2.png")
        let jcTexture = SKTexture(cgImage: Image.cgImage!)
        let pic = SKSpriteNode(texture: jcTexture)
        pic.position = CGPoint(x:200, y:200)
        pic.physicsBody = SKPhysicsBody(rectangleOf: (pic.texture?.size())!)
        myScene.addChild(pic)
        // ground::
        var splinePoints = [
            CGPoint(x:0, y: 0),
            CGPoint(x:0, y: 150),
            CGPoint(x:250, y:100),
                            CGPoint(x:400, y:50),
                            CGPoint(x:500, y:100),
                            CGPoint(x:525, y:0),
                            CGPoint(x:2000, y:10)
                            ]
        let ground = SKShapeNode(splinePoints: &splinePoints, count: splinePoints.count)
        ground.lineWidth = 5
        ground.strokeColor = UIColor.blue
        ground.fillColor = UIColor.blue
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.restitution = 0.75
        ground.physicsBody?.isDynamic = false
        myScene.addChild(ground)
    }
    func moveText() {
        let moveNodeUp = SKAction.moveBy(x: 0.0, y: 300.0, duration: 3.0)
        moveNodeUp.timingMode = SKActionTimingMode.easeInEaseOut
        //label.run(moveNodeUp)
        
    }
}

let viewController = SceneController()
PlaygroundPage.current.liveView = viewController
