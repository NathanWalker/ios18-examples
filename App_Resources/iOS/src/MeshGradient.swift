/*
 See the LICENSE.txt file for this sample’s licensing information.
 
 Abstract:
 Examples for using scroll transitions for a view.
 */

import SwiftUI

class MeshGradientProps: ObservableObject {
    @Published var modifiers = NSArray()
    var onEvent: ((NSDictionary) -> Void)?
}

struct MeshGradientAnimatedView: View {
    @ObservedObject var props: MeshGradientProps
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let x = (sin(timeline.date.timeIntervalSince1970) + 1) / 2
    
            MeshGradient(width: 3, height: 3, points: [
                [0, 0], [0.5, 0], [1, 0],
                [0, 0.5], [Float(x), 0.5], [1, 0.5],
                [0, 1], [0.5, 1], [1, 1]
            ], colors: [
                .black, .orange, .green,
                .blue, .purple, .green,
                .purple, .purple, .black
            ])
        }
    }
}

@objc
class MeshGradientProvider: UIViewController, SwiftUIProvider {
    private var props = MeshGradientProps()
    private var swiftUI: MeshGradientAnimatedView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        props.onEvent = { data in
            self.onEvent!(data)
        }
    }
    
    /// Receive data from NativeScript
    func updateData(data: NSDictionary) {        
        if (self.swiftUI == nil) {
            swiftUI = MeshGradientAnimatedView(props: props)
            setupSwiftUIView(content: swiftUI)
        } else {
            // engage data binding right away
            self.swiftUI?.props = props
        }
    }
    
    /// Send data to NativeScript
    var onEvent: ((NSDictionary) -> ())?
}

