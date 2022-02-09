#!/bin/bash

home-docker() {
    docker run --rm -u $(id -u):$(id -g) \
        -h $(hostname) \
        -v $(pwd):/Home -w /Home \
        -v $HOME/Workdir/docker-apps/.home:/home/xundaoxd \
        -v $HOME/Downloads:/home/xundaoxd/Downloads:ro \
        -v $HOME/Pictures:/home/xundaoxd/Pictures:ro \
        -v $HOME/Documents:/home/xundaoxd/Documents:ro \
        -v $HOME/Desktop:/home/xundaoxd/Desktop:ro \
        -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e LANG=en_US.UTF-8 -e GTK_IM_MODULE=xim -e XMODIFIERS \
        "$@"
}

app-docker() {
    alias node="home-docker --network host -ti node:latest node"
    alias npx="home-docker --network host -ti node:latest npx"
    alias npm="home-docker --network host -ti node:latest npm"
    alias yarn="home-docker --network host -ti node:latest yarn"

    alias go="home-docker -ti xundaoxd/go:latest go"

    alias javac="home-docker -ti openjdk:latest javac"
    alias java="home-docker -ti openjdk:latest java"

    alias nvcc="home-docker -ti --gpus all xundaoxd/cuda-cmake:latest nvcc"
    alias cuda-cmake="home-docker -ti --gpus all xundaoxd/cuda-cmake:latest cmake"

    alias obsidian="home-docker \
        --gpus all \
        -d xundaoxd/obsidian:latest \
        /opt/obsidian/obsidian --no-sandbox"
    alias octave="home-docker \
        --gpus all \
        -d xundaoxd/octave:latest \
        octave --gui"
    alias vlc="home-docker \
        -e PULSE_SERVER=unix:/run/user/1000/pulse/native \
        -v /run/user/1000/pulse:/run/user/1000/pulse \
        -d xundaoxd/vlc:latest \
        vlc"
    alias gimp="home-docker \
        -d xundaoxd/gimp:latest \
        gimp"

    alias xelatex="home-docker \
        -ti texlive/texlive:latest \
        xelatex"
    alias doxygen="home-docker \
        -ti xundaoxd/doxygen:latest \
        doxygen"
    alias you-get="home-docker \
        -ti xundaoxd/you-get:latest \
        you-get"
}

app-docker
