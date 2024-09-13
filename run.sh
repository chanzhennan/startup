
#创建容器时候不要用nvidia/cudaxx的基础镜像，用dockerfile build一下，这样有环境

#export build_image="cuda11.6:latest"
export build_image="cuda118cudnn8:latest"
#export build_image="nvidia/cuda:12.1.0-devel-ubuntu20.04"
#export build_image="cuda113cudnn8:latest"
#export build_image="torch2cuda117:latest"
#export build_image="cuda9cudnn7:latest"
#export build_image="cuda10cudnn7:latest"
#export build_image="docker.io/oneflowinc/oneflow:0.9.1.dev20230626-cuda11.7"


docker run -tid --gpus all --ulimit memlock=-1:-1 \
	--net=host --cap-add=IPC_LOCK \
	--ipc=host --privileged \
	-v /dev/snd:/dev/snd \
	-v /etc/localtime:/etc/localtime:ro \
	-e http_proxy=http://127.0.0.1:8118 \
	-e https_proxy=http://127.0.0.1:8118 \
	-v /localdata:/localdata  \
	-e AUDIO_GID=`getent group audio | cut -d: -f3` \
	-e VIDEO_GID=`getent group video | cut -d: -f3` \
	-v "$HOME/.Xauthority:/root/.Xauthority:rw" \
	-e=DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /home/zhennanc/.bashrc:/root/.bashrc \
	--name=$1 $build_image





#-e GID=`id -g` \
#-e UID=`id -u` \
