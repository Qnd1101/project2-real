# Makefile for Flutter project with multi-platform builds

# Variables
FLUTTER=flutter
PROJECT_NAME=project2-real

# Android APK Build
.PHONY: apk_debug apk_profile apk_release
apk_debug:
	@echo "---> Building Android APK (Debug)"
	$(FLUTTER) build apk --debug
	@echo "---> APK Debug Build Complete"

apk_profile:
	@echo "---> Building Android APK (Profile)"
	$(FLUTTER) build apk --profile
	@echo "---> APK Profile Build Complete"

apk_release:
	@echo "---> Building Android APK (Release)"
	$(FLUTTER) build apk --release
	@echo "---> APK Release Build Complete"

# iOS IPA Build (Requires MacOS)
.PHONY: ipa_debug ipa_profile ipa_release
ipa_debug:
	@echo "---> Building iOS IPA (Debug)"
	$(FLUTTER) build ipa --debug
	@echo "---> IPA Debug Build Complete"

ipa_profile:
	@echo "---> Building iOS IPA (Profile)"
	$(FLUTTER) build ipa --profile
	@echo "---> IPA Profile Build Complete"

ipa_release:
	@echo "---> Building iOS IPA (Release)"
	$(FLUTTER) build ipa --release
	@echo "---> IPA Release Build Complete"

# Web Build
.PHONY: web_debug web_profile web_release
web_debug:
	@echo "---> Building Web (Debug)"
	$(FLUTTER) build web --debug
	@echo "---> Web Debug Build Complete"

web_profile:
	@echo "---> Building Web (Profile)"
	$(FLUTTER) build web --profile
	@echo "---> Web Profile Build Complete"

web_release:
	@echo "---> Building Web (Release)"
	$(FLUTTER) build web --release
	@echo "---> Web Release Build Complete"

# Windows Build
.PHONY: windows_debug windows_profile windows_release
windows_debug:
	@echo "---> Building Windows (Debug)"
	$(FLUTTER) build windows --debug
	@echo "---> Windows Debug Build Complete"

windows_profile:
	@echo "---> Building Windows (Profile)"
	$(FLUTTER) build windows --profile
	@echo "---> Windows Profile Build Complete"

windows_release:
	@echo "---> Building Windows (Release)"
	$(FLUTTER) build windows --release
	@echo "---> Windows Release Build Complete"

# macOS Build
.PHONY: macos_debug macos_profile macos_release
macos_debug:
	@echo "---> Building macOS (Debug)"
	$(FLUTTER) build macos --debug
	@echo "---> macOS Debug Build Complete"

macos_profile:
	@echo "---> Building macOS (Profile)"
	$(FLUTTER) build macos --profile
	@echo "---> macOS Profile Build Complete"

macos_release:
	@echo "---> Building macOS (Release)"
	$(FLUTTER) build macos --release
	@echo "---> macOS Release Build Complete"

# Linux Build
.PHONY: linux_debug linux_profile linux_release
linux_debug:
	@echo "---> Building Linux (Debug)"
	$(FLUTTER) build linux --debug
	@echo "---> Linux Debug Build Complete"

linux_profile:
	@echo "---> Building Linux (Profile)"
	$(FLUTTER) build linux --profile
	@echo "---> Linux Profile Build Complete"

linux_release:
	@echo "---> Building Linux (Release)"
	$(FLUTTER) build linux --release
	@echo "---> Linux Release Build Complete"

# Clean project
.PHONY: clean
clean:
	@echo "---> Cleaning Project"
	$(FLUTTER) clean
	@echo "---> Clean Complete"

# Get dependencies
.PHONY: get
get:
	@echo "---> Getting Dependencies"
	$(FLUTTER) pub get
	@echo "---> Dependencies Fetched"

# Default target to build all release versions
.PHONY: all_release
all_release: apk_release ipa_release web_release windows_release macos_release linux_release
	@echo "---> All Release Builds Complete"

