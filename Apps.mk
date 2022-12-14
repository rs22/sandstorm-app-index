APPS     := $(shell cat upstream/apps/index.json | jq -rc '.apps[] | "upstream/apps/" + .appId + ".json"')
PACKAGES := $(shell cat upstream/apps/index.json | jq -rc '.apps[] | "upstream/packages/" + .packageId')
IMAGES   := $(shell cat upstream/apps/index.json | jq -rc '.apps[] | "upstream/images/" + .imageId')

upstream/apps: $(APPS)
upstream/apps/%.json:
	curl -s https://app-index.sandstorm.io/apps/$*.json > $@
	sh -c "cat $@ | jq -rc '.screenshots[] | .imageId' | while read imageId; do \
   curl -s https://app-index.sandstorm.io/images/\$$imageId > upstream/images/\$$imageId ; \
  done"

upstream/packages: $(PACKAGES)
upstream/packages/%:
	curl -s https://app-index.sandstorm.io/packages/$* > $@

upstream/images: $(IMAGES)
upstream/images/%:
	curl -s https://app-index.sandstorm.io/images/$* > $@
