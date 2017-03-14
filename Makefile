APP := vsftpd
VERSIONS := $(shell cat VSFTPD_VERSIONS)

# macro to build specific version
define docker_build
	docker build --build-arg VSFTPD_VERSION=$1 \
	--tag penkit/$(APP):$(shell echo "$1" | sed 's/-r[0-9]*$$//') .
endef

# macro to pull specific version
define docker_pull
	docker pull penkit/$(APP):$(shell echo "$1" | sed 's/-r[0-9]*$$//')
endef

# macro to push specific version
define docker_push
	docker push penkit/$(APP):$(shell echo "$1" | sed 's/-r[0-9]*$$//')
endef

# targets for building specific (or all) versions
docker-build: docker-pull-base $(addprefix docker-build-,$(VERSIONS)) ;
docker-build-%:
	$(call docker_build,$*)

# targets for pulling specific (or all) versions
docker-pull: $(addprefix docker-pull-,$(VERSIONS)) ;
docker-pull/%:
	$(call docker_pull,$*)

# target for pulling base image
docker-pull-base:
	docker pull penkit/alpine:3.5

docker-push: $(addprefix docker-push-,$(VERSIONS)) ;
docker-push-%:
	$(call docker_push,$*)
