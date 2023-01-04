#!/bin/sh

set -e

OUTPUT_PATH="${PROJECT_DIR}/Output"
IPHONE_FRAMERWORK_PATH="${OUTPUT_PATH}/${PROJECT_NAME}-iphone"
IPHONESIMULATOR_FRAMERWORK_PATH="${OUTPUT_PATH}/${PROJECT_NAME}-iphonesimulator"
XCFRAMEWORK_PATH="${OUTPUT_PATH}/${PROJECT_NAME}.xcframework"
SCHEME_NAME="${PROJECT_NAME}"
FRAMEWORK_PATH="Products/Library/Frameworks/${SCHEME_NAME}.framework"

rm -rf "${OUTPUT_PATH}"

xcodebuild archive \
    -scheme "${SCHEME_NAME}" \
    -configuration ${CONFIGURATION} \
    -archivePath "${IPHONE_FRAMERWORK_PATH}" \
    -sdk iphoneos \
    ONLY_ACTIVE_ARCH=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -scheme "${SCHEME_NAME}" \
    -configuration ${CONFIGURATION} \
    -archivePath "${IPHONESIMULATOR_FRAMERWORK_PATH}" \
    -sdk iphonesimulator \
    ONLY_ACTIVE_ARCH=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES


xcodebuild -create-xcframework \
    -framework "${IPHONE_FRAMERWORK_PATH}.xcarchive/${FRAMEWORK_PATH}" \
    -framework "${IPHONESIMULATOR_FRAMERWORK_PATH}.xcarchive/${FRAMEWORK_PATH}" \
    -output "${XCFRAMEWORK_PATH}"
