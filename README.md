# kinvey-researchkit
ResearchKit wrapper for Kinvey

The kinvey-researchkit package can be used to develop [ResearchKit](http://researchkit.org/) applications on the Kinvey platform. It wraps the [Kinvey iOS SDK](devcenter.kinvey.com/ios-v3.0) with classes that allow easy mapping of ResearchKit objects to a Kinvey backend.

Please refer to the Kinvey [DevCenter](http://devcenter.kinvey.com/) for documentation on using Kinvey.

## Prerequisites
* iOS 9 or later
* XCode 8 or above
* Kinvey app ID and secret. If you have not created a Kinvey app yet, create one [here](https://console.kinvey.com).

## Getting Started

* Open `KinveyResearchKit.workspace`. The workspace contains two projects:
    * `KinveyResearchKit` - is a wrapper SDK that exposes classes to back ResearchKit objects with a Kinvey backend.
    * `ORKCatalog` - is a fork of the ResearchKit [sample (https://github.com/ResearchKit/ResearchKit/tree/master/samples/ORKCatalog), that shows how to use `KinveyResearchKit` in your app.

* Replace `appKey` and `appSecret` in the `AppDelegate` of `ORKCatalog` with values you obtain from [Kinvey](https://console.kinvey.com).

* Run `ORKCatalog`.

## License
See [LICENSE](LICENSE) for details.

## Contributing
We like to see contributions from the community! If you see a bug, want to add a new capability, or just want to give us feedback, we'd love to hear from you.
See [CONTRIBUTING.md](CONTRIBUTING.md) for details on reporting bugs and making contributions.
