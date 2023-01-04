#!/bin/sh

ARCHIVE_DIR="$HOME/archives"
XCFRAMEWORK_DIR="$HOME/Frameworks"
FRAMEWORK_NAME=BaseVIPER

rm -rf $ARCHIVE_DIR
rm -rf $XCFRAMEWORK_DIR

xcodebuild archive \
    -scheme $FRAMEWORK_NAME \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "$ARCHIVE_DIR/$FRAMEWORK_NAME-iOS_Simulator" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -scheme $FRAMEWORK_NAME \
    -destination "generic/platform=iOS" \
    -archivePath "$ARCHIVE_DIR/$FRAMEWORK_NAME-iOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

#xcodebuild archive \
#    -scheme $FRAMEWORK_NAME \
#    -destination "generic/platform=macOS,variant=Mac Catalyst" \
#    -archivePath "$ARCHIVE_DIR/$FRAMEWORK_NAME-Catalyst" \
#    SKIP_INSTALL=NO \
#    BUILD_LIBRARY_FOR_DISTRIBUTION=YES
#
#xcodebuild archive \
#    -scheme $FRAMEWORK_NAME \
#    -destination "generic/platform=macOS" \
#    -archivePath "$ARCHIVE_DIR/$FRAMEWORK_NAME-macOS" \
#    SKIP_INSTALL=NO \
#    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework -framework $ARCHIVE_DIR/$FRAMEWORK_NAME-iOS.xcarchive/Products/Library/Frameworks/$FRAMEWORK_NAME.framework -framework $ARCHIVE_DIR/$FRAMEWORK_NAME-iOS_Simulator.xcarchive/Products/Library/Frameworks/$FRAMEWORK_NAME.framework -output $XCFRAMEWORK_DIR/$FRAMEWORK_NAME.xcframework

rm -rf $ARCHIVE_DIR
