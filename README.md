# jetson-ros-dockers: jetson-builder_cv
A docker container to be used as base builder image for L4T/arm64
Based on Jetson_builder it adds opencv compiled with cuda
To build the repository on an amd64 workstation you can use the following script.


```bash
#Configure docker for Nvidia
# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker

# Configure aarch64 emulation
sudo apt-get install qemu binfmt-support qemu-user-static # Install the qemu packages  

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes # This step will execute the registering scripts  

```

To run interactively the builder image you can use the following sintax:

```bash
docker run -it --rm --net=host --runtime nvidia -e DISPLAY=$DISPLAY alessiomorale/jetson-builder-jp-r32.4.2-cv-4.3.0-py3
```
Check the blog post [Running Docker Containers for the NVIDIA Jetson Nano](https://dev.to/caelinsutch/running-docker-containers-for-the-nvidia-jetson-nano-5a06) for more info.

Images are based on [mdegans/l4t-base](https://github.com/mdegans/docker-tegra-ubuntu/tree/l4t-base) 