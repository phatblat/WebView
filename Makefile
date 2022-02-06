#
# Makefile
# WebView
#

EXAMPLE_PROJECT = WebViewApp

################################################################################
#
# Targets
#

.DEFAULT_GOAL := help

.PHONY: help
help: MAKEFILE_FMT = "  \033[36m%-25s\033[0m%s\n"
help: ## (default) Displays this message
	@echo "Ditto main Makefile."
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z0-9_-]*:.*?##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?##"}; {printf $(MAKEFILE_FMT), $$1, $$2}'
	@echo ""
	@echo "Parameters:"
	@grep -E '^[A-Z0-9_-]* ?\?=.*?##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = " ?\\?=.*?##"}; {printf $(MAKEFILE_FMT), $$1, $$2}'
: # Hacky way to display a newline ##

.PHONY: build
build: ## Build package
	swift build $(SWIFTC_FLAGS) $(LINKER_FLAGS)

.PHONY: test
test: build ## Test package
	swift test

.PHONY: clean
clean: ## Clean build folders
	swift package clean
	rm -rf .build/
	rm -rf .swifpm/
	rm -rf Packages

.PHONY: resolve
resolve: ## Resolves SwiftPM package dependencies for example app
	# cd $(EXAMPLE_PROJECT)
	xcodebuild -resolvePackageDependencies
