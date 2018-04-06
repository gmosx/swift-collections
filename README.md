# Collections

![Build status](https://travis-ci.org/reizu/swift-collections.svg?branch=master)

A library of useful collection protocols and implementations.

## Usage

### RingBuffer

A `RingBuffer` retains the last `n` appended values, where `n` is equal to the
`capacity` of the buffer.

```
var buffer = RingBuffer<Int>(repeating: 0, count: 2)
buffer.count                  // == 2
buffer.append(2)
buffer.append(3)
buffer.append(4)
buffer.count                  // == 5
let sum = buffer.reduce(0, +) // == 7
buffer.first                  // == 3
```

## License

The software and all related files are licensed under the MIT license.

(c) 2018 Reizu.
