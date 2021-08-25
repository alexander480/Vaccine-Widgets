import SwiftUI

private struct TextViewSizeKey: PreferenceKey {
	static var defaultValue: [CGSize] { [] }
	static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
		value.append(contentsOf: nextValue())
	}
}

private struct PropagateSize<V: View>: View {
	var content: () -> V
	var body: some View {
		content()
			.background(GeometryReader { proxy in
				Color.clear.preference(key: TextViewSizeKey.self, value: [proxy.size])
			})
	}
}

private struct IdentifiableCharacter: Identifiable {
	var id: String { "\(index) \(character)" }
	
	let index: Int
	let character: Character
}

extension IdentifiableCharacter {
	var string: String { "\(character)" }
}

extension Array {
	subscript(safe index: Int) -> Element? {
		indices.contains(index) ? self[index] : nil
	}
}

// MARK: - Curved Text

public struct CurvedText: View {
	
	public var text: String
	public var radius: CGFloat
	
	internal var textModifier: (Text) -> Text = { $0 }
	internal var spacing: CGFloat = 0
	
	@State private var sizes: [CGSize] = []
	
	private func textRadius(at index: Int) -> CGFloat {
		radius - size(at: index).height / 2
	}
	
	public var body: some View {
		VStack {
			ZStack {
				ForEach(textAsCharacters()) { item in
					PropagateSize {
						self.textView(char: item)
					}
					.frame(width: self.size(at: item.index).width,
						   height: self.size(at: item.index).height)
					.offset(x: 0,
							y: -self.textRadius(at: item.index))
					.rotationEffect(self.angle(at: item.index))
				}
			}
			.frame(width: radius * 2, height: radius * 2)
			.onPreferenceChange(TextViewSizeKey.self) { sizes in
				self.sizes = sizes
			}
		}
		.accessibility(label: Text(text))
	}
	
	private func textAsCharacters() -> [IdentifiableCharacter] {
		let string = String(text.reversed())
		return string.enumerated().map(IdentifiableCharacter.init)
	}
	
	private func textView(char: IdentifiableCharacter) -> some View {
		textModifier(Text(char.string))
			.rotationEffect(.degrees(180))
	}
	
	private func size(at index: Int) -> CGSize {
		sizes[safe: index] ?? CGSize(width: 1000000, height: 0)
	}
	
	private func angle(at index: Int) -> Angle {
		let arcSpacing = Double(spacing / radius)
		let letterWidths = sizes.map { $0.width }
		
		let prevWidth =
		index < letterWidths.count ?
		letterWidths.dropLast(letterWidths.count - index).reduce(0, +) :
		0
		let prevArcWidth = Double(prevWidth / radius)
		let totalArcWidth = Double(letterWidths.reduce(0, +) / radius)
		let prevArcSpacingWidth = arcSpacing * Double(index)
		let arcSpacingOffset = -arcSpacing * Double(letterWidths.count - 1) / 2
		let charWidth = letterWidths[safe: index] ?? 0
		let charOffset = Double(charWidth / 2 / radius)
		let arcCharCenteringOffset = -totalArcWidth / 2
		let charArcOffset = prevArcWidth + charOffset + arcCharCenteringOffset + arcSpacingOffset + prevArcSpacingWidth
		return Angle(radians: charArcOffset)
	}
}

extension CurvedText {
	public func kerning(_ kerning: CGFloat) -> CurvedText {
		var copy = self
		copy.spacing = kerning
		return copy
	}
	
	public func italic() -> CurvedText {
		var copy = self
		copy.textModifier = {
			self.textModifier($0)
				.italic()
		}
		return copy
	}
	
	public func bold() -> CurvedText {
		fontWeight(.bold)
	}
	
	public func fontWeight(_ weight: Font.Weight?) -> CurvedText {
		var copy = self
		copy.textModifier = {
			self.textModifier($0)
				.fontWeight(weight)
		}
		return copy
	}
}


struct CurvedText_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			CurvedText(text: "Hello World!", radius: 200)
			
			CurvedText(text: "Hello World!", radius: 100)
				.kerning(5)
				.italic()
				.fontWeight(.heavy)
		}
		.previewLayout(.sizeThatFits)
	}
}
