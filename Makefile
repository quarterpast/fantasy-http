all: index.js

%.js: %.ls
	node_modules/.bin/lsc -pc $(LS_OPTS) "$<" > "$@"

.PHONY: clean
clean:
	rm index.js