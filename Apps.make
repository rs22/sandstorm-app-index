APPS     := $(shell cat upstream/apps/index.json | jq -rc '.apps[] | "upstream/apps/" + .appId + ".json"')
PACKAGES := $(shell cat upstream/apps/index.json | jq -rc '.apps[] | "upstream/packages/" + .packageId')
IMAGES   := $(shell cat upstream/apps/index.json | jq -rc '.apps[] | "upstream/images/" + .imageId')

upstream/apps: $(APPS)
upstream/apps/%.json:
	curl -s https://app-index.sandstorm.io/$@ > $@

# upstream/apps/versions/%.json:
# 	mkdir -p upstream/apps/versions
# 	touch $@

upstream/packages: $(PACKAGES)
upstream/packages/%:
	curl -s https://app-index.sandstorm.io/$@ > $@

upstream/images: $(IMAGES)
upstream/images/%:
	curl -s https://app-index.sandstorm.io/$@ > $@
