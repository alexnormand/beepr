.PHONY: all js css build watch

BUILD_FOLDER = build
NODE_MODULES_PATH = ./node_modules
MAIN_STYLESHEET_FILE= main.styl


all: build css js


build:
	rm -rf        $(BUILD_FOLDER)
	mkdir         $(BUILD_FOLDER)
	mkdir         $(BUILD_FOLDER)/css
	mkdir         $(BUILD_FOLDER)/js
	cp index.html $(BUILD_FOLDER)
	cp beep.mp3   $(BUILD_FOLDER)
	cp beep.ogg   $(BUILD_FOLDER)


js:
	$(NODE_MODULES_PATH)/requirejs/bin/r.js -o js/build.js dir=$(BUILD_FOLDER)/js


css:
	$(NODE_MODULES_PATH)/stylus/bin/stylus  -c -I $(NODE_MODULES_PATH)/nib/lib/  stylus/main.styl -o $(BUILD_FOLDER)/css


watch:
	rm -rf css
	@mkdir css
	$(NODE_MODULES_PATH)/stylus/bin/stylus  -w -I $(NODE_MODULES_PATH)/nib/lib/  stylus/main.styl -o css &
	$(NODE_MODULES_PATH)/node-static/bin/cli.js -H '{"Cache-Control": "no-cache, must-revaliate"}' &




