# Dockerfile Maven with Oracle JDK8 on CentOS 7

This repository contains **Dockerfile** of [Java](https://www.java.com/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/r/karumien/centos-maven-jdk8/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [centos](https://hub.docker.com/_/centos/)


### Versions

* CentOS 7
* Oracle JDK 8u152-b16-linux-x64
* Maven 3.5.2


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/r/karumien/centos-maven-jdk8/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull karumien/centos-maven-jdk8`

   (alternatively, you can build an image from Dockerfile: `docker build -t="docker pull karumien/centos-maven-jdk8" github.com/karumien/docker-maven-jdk8`)


### Usage

    docker run -it --rm karumien/centos-maven-jdk8


### License

karumien/docker-maven-jdk8 is **licensed** under the **[MIT License]**. The terms of the license are as follows:

    The MIT License (MIT)

    Copyright (c) 2016 Leandro Kersting de Freitas

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
