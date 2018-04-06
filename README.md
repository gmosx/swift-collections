# Collections
![Build status](https://travis-ci.org/reizu/swift-collections.svg?branch=master)

A library of useful collection protocols and corresponding implementations.

## Usage

### RingBuffer

```
var buffer = RingBuffer<Int>(count: 2)
buffer.append(2)
buffer.append(3)
buffer.append(4)
buffer.count                  // == 2
buffer.totalCount             // == 3
let sum = buffer.reduce(0, +) // == 7
```

## License

The software and all related files are licensed under the MIT license.

(c) 2018 Reizu
