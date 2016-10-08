all:
	cd Carthage/Checkouts/ios-library/Kinvey/Carthage/Checkouts/PromiseKit/Extensions; \
	ls -A | awk '{system("cd " $$1 "; pwd; carthage bootstrap")}'
