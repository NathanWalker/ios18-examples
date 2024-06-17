/*
All credit to the original author: Mark View (@MarkBuildin)
https://gist.github.com/asir2004/f749a54738bdf11a321960766d47fbfc
*/
import SwiftUI

struct WWDC24AnimatedTextView: View {
    var text = "Hello, World!"
    var animation: Animation = .easeInOut
    var targetFontSize: CGFloat = 40
    var minimumFontSize: CGFloat = 30
    var targetFontWeight: Font.Weight = .semibold
    var minimumFontWeight: Font.Weight = .ultraLight
    var targetFontWidth: Font.Width = .expanded
    var minimumFontWidth: Font.Width = .compressed
    var delayBetweenSwitch: Double = 3
    var delayBetweenCharacter: Double = 2
    
    var toggle: Bool = false // Animation is triggered when this value is changed
    
    @StateObject private var fontSettings: FontSettings // Uses the FontSettings class
    
    init(_ text: String, toggle: Bool, animation: Animation = .easeInOut, targetFontSize: CGFloat = 40, minimumFontSize: CGFloat = 30, targetFontWeight: Font.Weight = .semibold, minimumFontWeight: Font.Weight = .ultraLight, targetFontWidth: Font.Width = .expanded, minimumFontWidth: Font.Width = .compressed, delayBetweenSwitch: Double = 3, delayBetweenCharacter: Double = 2) {
        self.text = text
        self.toggle = toggle
        self.animation = animation
        self.targetFontSize = targetFontSize
        self.minimumFontSize = minimumFontSize
        self.targetFontWeight = targetFontWeight
        self.minimumFontWeight = minimumFontWeight
        self.targetFontWidth = targetFontWidth
        self.minimumFontWidth = minimumFontWidth
        self.delayBetweenSwitch = delayBetweenSwitch
        self.delayBetweenCharacter = delayBetweenCharacter
        _fontSettings = StateObject(wrappedValue: FontSettings(text: text, targetFontSize: targetFontSize, targetFontWeight: targetFontWeight, targetFontWidth: targetFontWidth))
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(characterIndices(text: text), id: \.index) { item in
                    Text(item.character)
                        .font(.system(size: fontSettings.fontSizes[item.index]))
                        .fontWidth(fontSettings.fontWidths[item.index])
                        .fontWeight(fontSettings.fontWeights[item.index])
                }
                .geometryGroup() // Make sure the characters are aligned when animation is playing
            }
        }
        .onChange(of: toggle) {
            toggleWholeAnimation()
        }
    }
    
    // Helper function to get characters and their indices
    func characterIndices(text: String) -> [(character: String, index: Int)] {
        var result: [(character: String, index: Int)] = []
        for (index, character) in text.enumerated() {
            result.append((String(character), index))
        }
        return result
    }
    
    // Whole bold-thin-bold animation toggle
    func toggleWholeAnimation() {
        Task {
            // First part of animation, the text will go thinner
            toggleAnimation()
            
            // Delay between two animations
            try? await Task.sleep(nanoseconds: 0_100_000_000 * UInt64(delayBetweenSwitch))
            
            // Second part of animation, the text will go to the original state
            toggleAnimation()
        }
    }
    
    // Toggle text to the opposite state
    func toggleAnimation() {
        Task {
            for index in fontSettings.fontWidths.indices {
                // Delay between each character
                try? await Task.sleep(nanoseconds: 0_100_000_000 * UInt64(delayBetweenCharacter) / UInt64(text.count))
                
                // Make text size, width and weight to the opposite
                withAnimation(animation) {
                    fontSettings.fontSizes[index] = fontSettings.fontSizes[index] == minimumFontSize ? targetFontSize : minimumFontSize
                    fontSettings.fontWidths[index] = fontSettings.fontWidths[index] == minimumFontWidth ? targetFontWidth : minimumFontWidth
                    fontSettings.fontWeights[index] = fontSettings.fontWeights[index] == minimumFontWeight ? targetFontWeight : minimumFontWeight
                }
            }
        }
    }
}

class WWDC24AnimatedTextViewProps: ObservableObject {
    @Published var text = "HELLO WORLD!"
    
    // Animation parameters
    @Published var animation: Animation = .bouncy
    @Published var targetFontSize: CGFloat = 30
    @Published var minimumFontSize: CGFloat = 30
    @Published var targetFontWeight: Font.Weight = .semibold
    @Published var minimumFontWeight: Font.Weight = .ultraLight
    @Published var targetFontWidth: Font.Width = .expanded
    @Published var minimumFontWidth: Font.Width = .compressed
    @Published var delayBetweenSwitch: Double = 3
    @Published var delayBetweenCharacter: Double = 2

    // Trigger the animation
    @Published var toggle = true

    @Published var modifiers = NSArray()
    var onEvent: ((NSDictionary) -> Void)?
}

struct WWDC24AnimatedView: View {
    @ObservedObject var props: WWDC24AnimatedTextViewProps

    var body: some View {
        ZStack {
            WWDC24AnimatedTextView(props.text, toggle: props.toggle, animation: props.animation, targetFontSize: props.targetFontSize, minimumFontSize: props.minimumFontSize, targetFontWeight: props.targetFontWeight, minimumFontWeight: props.minimumFontWeight, targetFontWidth: props.targetFontWidth, minimumFontWidth: props.minimumFontWidth, delayBetweenSwitch: props.delayBetweenSwitch, delayBetweenCharacter: props.delayBetweenCharacter)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


@objc
class WWDC24AnimatedViewProvider: UIViewController, SwiftUIProvider {
    private var props = WWDC24AnimatedTextViewProps()
    private var swiftUI: WWDC24AnimatedView?
    
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
                if (key == "text") {
                    props.text = v as! String
                } else if (key == "toggle") {
                    props.toggle = v as! Bool
                } else if (key == "targetFontSize") {
                    props.targetFontSize = v as! CGFloat
                } else if (key == "delayBetweenCharacter") {
                    props.delayBetweenCharacter = v as! CGFloat
                } else if (key == "delayBetweenSwitch") {
                    props.delayBetweenSwitch = v as! CGFloat
                } else if (key == "minimumFontSize") {
                    props.minimumFontSize = v as! CGFloat
                }
                
            }
        }
        
        
        if (self.swiftUI == nil) {
            swiftUI = WWDC24AnimatedView(props: props)
            setupSwiftUIView(content: swiftUI)
        } else {
            // engage data binding right away
            self.swiftUI?.props = props
        }
    }
    
    /// Send data to NativeScript
    var onEvent: ((NSDictionary) -> ())?
}