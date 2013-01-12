.PHONY: all js css build watch install

BUILD_DIR = build
JS_LIBS_PATH = js/libs
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


install:
	rm -rf $(JS_LIBS_PATH)
	mkdir -p $(JS_LIBS_PATH)/requirejs
	curl -L https://bitbucket.org/mckamey/countdown.js/raw/tip/countdown.js > $(JS_LIBS_PATH)/countdown.js
	curl -L https://raw.github.com/ftlabs/fastclick/master/lib/fastclick.js > $(JS_LIBS_PATH)/fastclick.js
	curl -L https://raw.github.com/jashkenas/coffee-script/master/extras/coffee-script.js > $(JS_LIBS_PATH)/coffee-script.js
	curl -L http://requirejs.org/docs/release/2.1.2/minified/require.js > $(JS_LIBS_PATH)/requirejs/require.js
	curl -L https://raw.github.com/jrburke/require-cs/latest/cs.js > $(JS_LIBS_PATH)/requirejs/cs.js
	npm install


watch:
	rm -rf css
	@mkdir css
	$(NODE_MODULES_PATH)/stylus/bin/stylus  -w -I $(NODE_MODULES_PATH)/nib/lib/  stylus/main.styl -o css &
	$(NODE_MODULES_PATH)/node-static/bin/cli.js -H '{"Cache-Control": "no-cache, must-revaliate"}' &


