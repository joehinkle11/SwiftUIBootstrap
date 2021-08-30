# SwiftUI Twitter Bootstrap

This is a set of useful [SwiftUI](https://developer.apple.com/xcode/swiftui/) components to generate decent [Bootstrap](https://getbootstrap.com) styled HTML components via [TokamakUI](https://github.com/TokamakUI/Tokamak). The project is aiming to be useful for those who already have SwiftUI projects who wish to add Tokamak as another build option. So you will find many helper types which will allow each platform (iOS vs. Web) to work with the same code. See `ImageOrBI`'s ability to support Boostrap Icons and SF Symbols as an example.


## Icons

You can use any [Bootstrap icon](https://icons.getbootstrap.com/#usage) as well.

```swift
VStack {
    BootstrapIcon(name: "check-circle")
}
```

If your code is being compiled for both WASM and native destinations (such as iOS), you can use `ImageOrBI` to support both SF Symbols and Bootstrap icons.

```swift
ImageOrBI(systemName: "checkmark.circle", bi: "check-circle")
```
