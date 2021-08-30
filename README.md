# SwiftUI Twitter Bootstrap



## Icons

You can use any [Bootstrap icon](https://icons.getbootstrap.com/#usage) as well.

```swift
VStack {
    BootstrapIcon(name: "check-circle")
}
```

If your code is being compiled for both WASM and native destinations (such as iOS), you can use `ImageOrBI` to support both SF Symbols and Bootstrap icons.

```swift
ImageOrBI(systemName: "checkmark.circle" bi: "circle-circle")
```
