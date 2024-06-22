/*
 See the LICENSE.txt file for this sample’s licensing information.
 
 Abstract:
 Examples for using scroll transitions for a view.
 */

import SwiftUI

class ParallaxProps: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var cornerRadius: CGFloat = 36
    @Published var contentMargins: CGFloat = 32
    @Published var xOffset: CGFloat = -200
    @Published var titleXOffset: CGFloat = 100
    @Published var spacing: CGFloat = 16
    @Published var showScrollIndicator = false
    @Published var modifiers = NSArray()
    var onEvent: ((NSDictionary) -> Void)?
}

struct ParallaxView: View {
    @ObservedObject var props: ParallaxProps
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: props.showScrollIndicator) {
            LazyHStack(spacing: props.spacing) {
                ForEach(props.photos) { photo in
                    VStack {
                        ZStack {
                            NativeScriptView(id: photo.dataId)
                                .scrollTransition(axis: .horizontal) { content, phase in
                                    content
                                        .offset(x: phase.isIdentity ? 0 : phase.value * props.xOffset)
                                }
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: props.cornerRadius))
                        
                        ItemLabel(photo)
                            .scrollTransition(axis: .horizontal) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .offset(x: phase.value * props.titleXOffset)
                            }
                        
                    }
                }
            }
        }
        .contentMargins(props.contentMargins)
        .scrollTargetBehavior(.paging)
    }
}

struct Photo: Identifiable {
    let id = UUID()
    var dataId: String
    var title: String

    init(_ dataId: String, title: String) {
        self.dataId = dataId
        self.title = title
    }
}

struct ItemLabel: View {
    var photo: Photo

    init(_ photo: Photo) {
        self.photo = photo
    }

    var body: some View {
        Text(photo.title)
            .font(.title)
    }
}

@objc
class ParallaxProvider: UIViewController, SwiftUIProvider {
    private var props = ParallaxProps()
    private var swiftUI: ParallaxView?
    
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
                if (key == "photos") {
                    props.photos = []
                    if let photos = v as? NSArray {
                        for photo in photos {
                            let id = (photo as AnyObject).object(forKey: "id")
                            let title = (photo as AnyObject).object(forKey: "title")
                            props.photos.append(Photo(id as! String, title: title as! String))
                        }
                    }
                } else if (key == "cornerRadius") {
                    props.cornerRadius = v as! CGFloat
                } else if (key == "contentMargins") {
                    props.contentMargins = v as! CGFloat
                } else if (key == "xOffset") {
                    props.xOffset = v as! CGFloat
                } else if (key == "spacing") {
                    props.spacing = v as! CGFloat
                } else if (key == "titleXOffset") {
                    props.titleXOffset = v as! CGFloat
                } else if (key == "showScrollIndicator") {
                    props.showScrollIndicator = v as! Bool
                } else if (key == "modifiers") {
                    props.modifiers = v as! NSArray
                }
            }
        }
        
        
        if (self.swiftUI == nil) {
            swiftUI = ParallaxView(props: props)
            setupSwiftUIView(content: swiftUI)
        } else {
            // engage data binding right away
            self.swiftUI?.props = props
        }
    }
    
    /// Send data to NativeScript
    var onEvent: ((NSDictionary) -> ())?
}

