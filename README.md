# apkToJava
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/ajitsing/apkToJava/graphs/commit-activity)
[![Gem Version](https://badge.fury.io/rb/apkToJava.svg)](https://badge.fury.io/rb/apkToJava)
[![HitCount](http://hits.dwyl.io/ajitsing/apkToJava.svg)](http://hits.dwyl.io/ajitsing/apkToJava)
![Gem Downloads](http://ruby-gem-downloads-badge.herokuapp.com/apkToJava?type=total)
[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT)
[![Twitter Follow](https://img.shields.io/twitter/follow/Ajit5ingh.svg?style=social)](https://twitter.com/Ajit5ingh)

A ruby gem to view android apk as java code in GUI

Before starting the process it checks wether the env is setup or not.
If not it downloads the required tools and continues with the process.

## Documentation
http://www.singhajit.com/convert-apk-file-to-java-code/

## Demo Video
[![IMAGE ALT TEXT](http://img.youtube.com/vi/YDWg-bgsAfc/0.jpg)](https://www.youtube.com/watch?v=YDWg-bgsAfc "Demo")

## Installation

```shell
gem install apkToJava
```

## Usage

Below command will install the required tools for ```apkToJava``` to work

```shell
apkToJava setup
```

Below command will process the apk file and open the code in jadx gui

```shell
apkToJava path/to/apk/file.apk
```

## Supported Operatiing Systems
- Mac
- Linux

## Todo
Add Windows support

## License
```LICENSE
The MIT License (MIT)

Copyright (c) 2016 Ajit Singh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
