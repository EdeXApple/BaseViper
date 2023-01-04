#!/bin/sh

set -e

UNIVERSAL_OUTPUTFOLDER=${PROJECT_DIR}/output/${PROJECT_NAME}-universal

rm -rf "${UNIVERSAL_OUTPUTFOLDER}"

# make sure the output directory exists

mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"


# Build Device and Simulator versions

xcodebuild -target "${PROJECT_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

xcodebuild -target "${PROJECT_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build


# Copy the framework structure (from iphoneos build) to the universal folder

cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/"


# Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory

SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/."

if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then

cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"

fi


# Remove the arm64 arch (simulator) for Xcode 12.3
lipo -remove arm64 "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" -o "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}"

# Create universal binary file using lipo and place the combined executable in the copied framework directory
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}"


# Overwrite generated -Swift.h file with combined headers -- Known Issue with Xcode 10.2
# https://developer.apple.com/documentation/xcode_release_notes/xcode_10_2_release_notes#3141454
COMBINED_FILE="${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Headers/${PROJECT_NAME}-Swift.h"
echo "#ifndef TARGET_OS_SIMULATOR\n#include <TargetConditionals.h>\n#endif\n#if TARGET_OS_SIMULATOR" > "${COMBINED_FILE}"
cat "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/Headers/${PROJECT_NAME}-Swift.h" >> "${COMBINED_FILE}"
echo "#else" >> "${COMBINED_FILE}"
cat "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework/Headers/${PROJECT_NAME}-Swift.h" >> "${COMBINED_FILE}"
echo "#endif" >> "${COMBINED_FILE}"


# Convenience step to copy the framework to the project's directory

cp -R "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework" "${PROJECT_DIR}"
