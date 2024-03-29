## Archive
Take a gander at my early days of code and open source! This code is no longer maintained, but this repository certainly has historical utility.

---

![Guitarparty Logo](http://guitarparty-static-media.s3.amazonaws.com/images/v3/body/logo.6329ffbed64d.png)

# Welcome.
Welcome to the **Guitarparty iOS and OS X Client Library**. This library enables developers to access the plethora of chords and tabs in the [Guitarparty.com](http://www.guitarparty.com) database.

I wrote this library in the midst of my exploration of the new Swift language developed by Apple. So enjoy, catch bugs, submit pull requests, and make use of this library as much as you need.

## Requirements
- **Xcode 6.3** (*works beautifully with Swift 1.2; I will update whenever Swift changes and recompile to make sure everything works.*)


- **iOS 8+** (*Dynamic frameworks will not compile on anything lower.*)

	*or:*
- **OS X 10.9+** (*Swift is compatible with as early as Mavericks*)

## Installation
Use CocoaPods:
```ruby
pod 'Guitarparty-Cocoa'
```

Run `pod install` and then import using `import Guitarparty` in Swift or `@import Guitarparty;` in Objective-C.

## API Key
**Before you do anything else with this library,** you need to grab an API key from http://www.guitarparty.com/developers/api-key/

Then call the Guitarparty class's setAPIKey() method to set the API Key for all requests:

**Swift**

```swift
Guitarparty.setAPIKey("{API_KEY}")
```

**Objective-C**

```obj-c
[Guitarparty setAPIKey:@"{API_KEY}"];
```

## How to use

This library contains **4 Object Categories**:

- [Songs](http://www.guitarparty.com/developers/api-docs/api-resources/songs/)
- [Artists](http://www.guitarparty.com/developers/api-docs/api-resources/artists/)
- [Parties](http://www.guitarparty.com/developers/api-docs/api-resources/parties/)
- [Chords](http://www.guitarparty.com/developers/api-docs/api-resources/chords/)

Each category contains the **object** itself, a **list** object, and a **fetcher** object with the possible ways to query the object category.

For example, here's how to search for songs with a query string:

**Swift:**

```swift
SongFetcher.searchForSongs(query: "Jolene") { (results: SongList?, error: NSError?) in
            if error != nil {
                // Handle error here
            } else {
                if results != nil { // Check to make sure there is in fact a song list
                    self.songList = results!
                }
            }
        }
```

**Objective-C**

```obj-c
[SongFetcher searchForSongsWithQuery:@"Jolene" completionHandler:^(SongList *results, NSError *error) {
        if (error) {
            // Handle error here
        } else {
            if (results) { // Check to make sure there is in fact a song list
                self.songList = results
            }
        }
    }];
```

## Documentation

This library is well-documented using the standard in-line documentation methods. So quick-looking any symbol in this SDK will give you documentation for that item.

## License
Copyright 2014 Matthew Wyskiel

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
