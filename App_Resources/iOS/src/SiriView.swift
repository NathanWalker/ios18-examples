//
//  ContentView.swift
//  SiriAnimationPrototype
//
//  Created by Siddhant Mehta on 2024-06-13.
//  Adapted by Nathan Walker on 2024-06-17 for NativeScript.
//

import SwiftUI

struct SiriView: View {
    @ObservedObject var props: SiriViewProps
    
    enum SiriState {
        case none
        case thinking
    }
    @State var state: SiriState = .none
    
    @State var origin: CGPoint = .init(x: 0.5, y: 0.5)
    @State var timer: Timer?
    @State private var maskTimer: Float = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Colorful animated gradient
                MeshGradientView(maskTimer: $maskTimer, gradientSpeed: $props.gradientSpeed)
                    .scaleEffect(1.3) // avoids clipping
                    .opacity(containerOpacity)
                
                // Brightness rim on edges
                if state == .thinking {
                    RoundedRectangle(cornerRadius: 52, style: .continuous)
                        .stroke(Color.white, style: .init(lineWidth: 4))
                        .blur(radius: 4)
                }
                
                // Phone background mock, includes button
                PhoneBackground(props: props, state: $state, origin: $origin, counter: $props.counter)
                    .mask {
                        AnimatedRectangle(size: geometry.size, cornerRadius: 48, t: CGFloat(maskTimer))
                            .scaleEffect(computedScale)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .blur(radius: animatedMaskBlur)
                    }
            }
        }
        .ignoresSafeArea()
        .modifier(RippleEffect(at: origin, trigger: props.counter))
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                DispatchQueue.main.async {
                    maskTimer += rectangleSpeed
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private var computedScale: CGFloat {
        switch state {
        case .none: return 1.2
        case .thinking: return 1
        }
    }
    
    private var rectangleSpeed: Float {
        switch state {
        case .none: return 0
        case .thinking: return 0.03
        }
    }
    
    private var animatedMaskBlur: CGFloat {
        switch state {
        case .none: return 8
        case .thinking: return 28
        }
    }
    
    private var containerOpacity: CGFloat {
        switch state {
        case .none: return 0
        case .thinking: return 1.0
        }
    }
}


#Preview {
    SiriView(props: SiriViewProps())
}

class SiriViewProps: ObservableObject {
    @Published var counter: Int = 0
    
    // Gradient and masking vars
    @Published var gradientSpeed: Float = 0.03
    
    @Published var modifiers = NSArray()
    var onEvent: ((NSDictionary) -> Void)?
}


@objc
class SiriViewProvider: UIViewController, SwiftUIProvider {
    private var props = SiriViewProps()
    private var swiftUI: SiriView?
    
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
        let enumerator = data.keyEnumerator()
        while let k = enumerator.nextObject() {
            let key = k as! String
            let v = data.object(forKey: key)
            if (v != nil) {
                if (key == "counter") {
                    props.counter = v as! Int
                } else if (key == "gradientSpeed") {
                    props.gradientSpeed = Float(v as! CGFloat)
                }
            }
        }
        
        if (self.swiftUI == nil) {
            swiftUI = SiriView(props: props)
            setupSwiftUIView(content: swiftUI)
        } else {
            // engage data binding right away
            self.swiftUI?.props = props
        }
    }
    
    /// Send data to NativeScript
    var onEvent: ((NSDictionary) -> ())?
}
