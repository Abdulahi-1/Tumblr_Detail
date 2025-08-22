# TumblrDetail

Submitted by: Abdulahi Abdi

Tumblr Detail  is an app that builds upon a Tumblr feed interface by allowing users to tap on a post to view more details, such as the full image and description, on a new screen. It demonstrates navigation, UI construction, and data passing between view controllers in iOS using Swift and Storyboard.

Time spent: 6 hours spent in total

## Required Features

The following **required** functionality is completed:

- [X] Setup navigation to the Detail Screen
- [X] Created the Detail View UI
- [X] Add the ability to pass data to the Detail View Controller
- [X] Made personal finishing touches to the UI


The following **additional** features are implemented:

- [X] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

https://www.loom.com/share/bfc0555a17f34ba691613889228c9a53?sid=cfcb3d27-9619-4bce-be7a-4d5c84fe70c7

## Notes

A challenge I faced was ensuring the Detail View Controller received the correct data and displayed it accurately.  
I resolved this by carefully setting up the `prepare(for:sender:)` method to pass the selected post’s data to the Detail View Controller and double-checking that the IBOutlets were properly connected to the Storyboard. The outcome was that the correct image and description appeared consistently in the detail view, which improved both the functionality and the user experience of the app.

## License

    Copyright 2025 Abdulahi Abdi

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
