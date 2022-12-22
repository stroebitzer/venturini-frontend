IMAGE_REPOSITORY = ueber
APPLICATION_NAME = venturini-frontend
BUILD_VERSION = 0.0.2

.PHONY: lint
lint:
	ng lint

.PHONY: test
test: lint
	ng test

.PHONY: build
build:lint
	ng build

.PHONY: run
run:lint
	ng serve

.PHONY: docker-build
docker-build:
# docker-build: lint
	docker build -t ${IMAGE_REPOSITORY}/${APPLICATION_NAME}:${BUILD_VERSION} .

.PHONY: docker-run
docker-run: docker-build
	docker run -it -p 80:80 ${IMAGE_REPOSITORY}/${APPLICATION_NAME}:${BUILD_VERSION}

.PHONY: docker-push
docker-push: docker-build
	docker push ${IMAGE_REPOSITORY}/${APPLICATION_NAME}:${BUILD_VERSION}

.PHONY: k8s-patch
k8s-patch: export KUBECONFIG=/home/hubert/vault/hetzner/my-cluster-kubeconfig
k8s-patch: docker-push
	kubectl -n venturini-at rollout restart deployment venturini.at
