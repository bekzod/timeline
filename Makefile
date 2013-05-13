REPORTER = dot

build: remove-js generate-js

deps:
	./node_modules/bower/bin/bower install

generate-js:
	./node_modules/coffee-script/bin/coffee -c --bare -o lib src

generate-w-js:
	./node_modules/coffee-script/bin/coffee -wc --bare -o lib src

remove-js:
	@rm -fr lib/

.PHONY: generate-js test
