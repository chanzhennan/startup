#!/bin/bash

XPU_NUM=8
DOCKER_DEVICE_CONFIG=""  # 初始化为空字符串，注意这里用双引号

# 使用更清晰的for循环语法
if [ $XPU_NUM -gt 0 ]; then
    for idx in $(seq 0 $((XPU_NUM-1))); do
        DOCKER_DEVICE_CONFIG="${DOCKER_DEVICE_CONFIG} --device=/dev/xpu${idx}:/dev/xpu${idx}"
    done
    DOCKER_DEVICE_CONFIG="${DOCKER_DEVICE_CONFIG} --device=/dev/xpuctrl:/dev/xpuctrl"
fi

export build_image="registry.baidubce.com/aihc-aiak/aiak-inference-llm:ubuntu22.04-xpurt10.2-torch2.0.1-py3.8_kunlun_p800_1.3.2.9"

docker run -itd ${DOCKER_DEVICE_CONFIG} \
    --net=host \
    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
    --tmpfs /dev/shm:rw,nosuid,nodev,exec,size=32g \
    --cap-add=SYS_PTRACE \
    -v /ssd0/zhennanc:/home/zhennanc \
    --name "$1" \
    -w /workspace \
    "$build_image" /bin/bash
