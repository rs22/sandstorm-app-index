.PHONY: upstream/apps/index.json

update: upstream/apps upstream/packages upstream/images

upstream/packages: upstream/apps/index.json
	mkdir -p upstream/packages
	make -f Apps.mk upstream/packages

upstream/apps: upstream/apps/index.json
	mkdir -p upstream/apps
	make -f Apps.mk upstream/apps

upstream/images: upstream/apps/index.json
	mkdir -p upstream/images
	make -f Apps.mk upstream/images

upstream/apps/index.json:
	mkdir -p upstream/apps
	curl -s https://app-index.sandstorm.io/apps/index.json > $@
