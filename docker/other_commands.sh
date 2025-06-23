#Creating the local tar image
	docker save -o artic-nf-muscle-arm54.tar artic-nf-muscle:arm64

# Ruuning tools inside docker
	docker run --rm -it

# Creating docker images
	docker buildx build --platform linux/arm64 -t artic-nf-arm64:latest .
	
# Push docker image to account
	docker tag artic-nf-arm64:v1.0 rage2025/artic-nf-arm64:v1.0
	docker login
	docker push rage2025/artic-nf-arm64:v1.0
	
