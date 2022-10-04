.PHONY: versio% ta% push-ta% ja% instal% deplo% tes% nuk% clea%

__check_defined = $(if $(value $(strip $(1))),,\
					$(error Undefined $(strip $(1))))

$(call __check_defined, version-number)
$(call __check_defined, group-id)
$(call __check_defined, artifact-id)

description     := $(if $(description),"\"$(description)\"",nil)
license         := $(if $(license),$(license),nil)
url             := $(if $(url),"\"$(url)\"",nil)

git-branch      = $(shell git rev-parse --abbrev-ref HEAD)
git-sha         = $(shell git rev-parse --short HEAD)
revision        = $(git-branch)-$(git-sha)
version         = $(version-number)$(if $(release),,-SNAPSHOT)

project-config  = :lib $(group-id)/$(artifact-id) :version "\"$(version)\""
pom-config      = :description $(description) :license $(license) :url $(url)

.SECONDEXPANSION:

#version
versio%:
	@echo "$(group-id)/$(artifact-id)-$(version)"

#tag
ta%:
	@git tag $(version)
	@echo "Created tag $(version)"

#push-tag
push-ta%:
	@git push origin $(version)

#jar
ja%: clean
	clojure -T:build jar $(project-config) $(pom-config)

target/%.jar:
	@$(MAKE) jar

#install
instal%: target/$$(artifact-id)-$$(version).jar
	clojure -T:build install $(project-config)

#deploy
deplo%:
	clojure -T:build deploy $(project-config)
	@mv *.pom.asc target/

#test
tes%:
	clojure -M:test

#nuke
nuk%: clean
	@echo "Nuking everything"
	@rm -rf .cpcache

#clean
clea%:
	@echo "Cleaning target and resources"
	@rm -rf target
	@rm -rf resources
