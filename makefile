.PHONY: all js css build watch

BUILD_DIR = build
NODE_MODULES_PATH = ./node_modules
MAIN_STYLESHEET_FILE= main.styl


all: build css js


build:
	rm -rf        $(BUILD_DIR)
	mkdir         $(BUILD_DIR)
	mkdir         $(BUILD_DIR)/css
	mkdir         $(BUILD_DIR)/js
	cp index.html $(BUILD_DIR)
	cp beep.mp3   $(BUILD_DIR)
	cp beep.ogg   $(BUILD_DIR)


js:
	$(NODE_MODULES_PATH)/requirejs/bin/r.js -o js/build.js dir=$(BUILD_DIR)/js


css:
	$(NODE_MODULES_PATH)/stylus/bin/stylus  -c -I $(NODE_MODULES_PATH)/nib/lib/  stylus/main.styl -o $(BUILD_DIR)/css


watch:
	rm -rf css
	@mkdir css
	$(NODE_MODULES_PATH)/stylus/bin/stylus  -w -I $(NODE_MODULES_PATH)/nib/lib/  stylus/main.styl -o css &
	$(NODE_MODULES_PATH)/node-static/bin/cli.js -H '{"Cache-Control": "no-cache, must-revaliate"}' &




