all: build

clean:
	rm -Rf Carthage

checkout:
	carthage checkout --no-use-binaries

build-only:
	xcodebuild -workspace KinveyResearchKit.xcworkspace -scheme KinveyResearchKit

build: checkout build-ios

build-ios:
	carthage build --no-skip-current --platform ios
