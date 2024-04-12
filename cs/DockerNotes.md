# Docker notes
- differs from VMs since it does NOT contain the OS Kernel within docker images
- Docker was originally developed to work with Linux machines only (i.e., uses Linux OS Kernel)
- later, Docker Desktop was designed to run on Windows / MAC OS

- base images:  have no parent image, usually they are an OS
- child images: are built on base images, usually adding functionality


## install
- need to install Docker Desktop first

## Common commands
- e.g., `docker pull nginx:1.23` : download docker image for nginx v1.23 (checks docker hub by default)

- `docker images` : list available images
  - `docker image rm imageName` : remove image

- `docker run nginx:1.23` : creates and starts a container from an image
  - using `docker run -d nginx:1.23` will create a new container and run it in the background (without blocking the terminal window) (e.g., -d for --detach)
  - if you start in the background, you can check logs by running:
    - `docker logs [id]` where [id] is available from `docker ps`
  - note:  docker will automatically create/assign a name for the container if you don't (e.g., 'zealous_antonelli')
    - can define a name using: `docker run --name myName nginx:1.23`
  - can use `docker run` without first doing `docker pull` : docker will check locally, and if it doesn't find an image, will dl it from docker hub automatically
  - `docker run -p 9000:80 nginx:1.23` : binds container port 80 to localhost port 9000
  - `docker run -it myContainer bash` : `it` runs an 'interactive terminal' in the container, `bash` defines the terminal
  - `docker run --rm ...` : removes container once it's exited from
  - `docker run --net netname ...` : runs a container with a network called `netname` specified

- `docker ps` : will show running containers
  - `docker ps -a` : will show ALL containers (not just running)

- `docker stop [id]`, where [id] is from `docker ps` : stops a running container
    - can also use `docker stop containerName`, where that name is defined with `--name` or auto-generated

- `docker start [id]`, where [id] is from `docker ps -a` : starts an existing (but stopped) container

- `docker rm [id]` : removes a container
  - `docker rm $(docker ps -a -q -f status=exited)` : removes all containers by numeric id (-q), filtered by status=exited (-f)
  - `docker container prune` : same as above (for newer versions of docker)

### Alternate commands
- from `https://docker-curriculum.com`

- `docker container stop containerName` : stop a running container called `containerName`
- `docker container rm containerName` : remove a running container called `containerName`
- e.g., `docker run -d --name es --net foodtrucks-net -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.3.2`

- `docker container logs containerName` : display logs for `containerName`
    - useful to see if there were errors in starting up a container

- `docker run -it --rm --net networkName yourusername/containerName bash`

- `docker push yourUserName/imageName` : publish image to DockerHub
    - Note:  this image must be built and available locally; and the names must match (i.e., built as `jjmchew/ft:1.0` and then pushed as `jjmchew/ft:1.0` :  if not built to a specific username, then it seems it cannot be pushed to a specific username library on DockerHub)


### Networking
- `docker network ls` : lists the various networks setup by docker
  - always have 3: bridge, host, none
    - containers are run by default in bridge
    - the bridge container is shared by every container by default (i.e., this network is not secure)

- `docker network inspect bridge` : lists details of the various containers and networks which are setup

- `docker network create myNetworkName` : creates an isolated network
- `docker network inspect myNetworkName` : allows you to see what containers are running within a particular network
    - good for double-checking that containers have been started appropriately

- `docker network rm myNetworkName` : removes a network


## Dockerfile
- can be used to create a new image

- `FROM` : indicates the "base image" - search on docker hub for basic requirements (e.g., `FROM node:19-alpine`)

- `COPY` : copies files from current (i.e., where Dockerfile is located) directory to a directory "inside" the container
  - e.g., `COPY package.json /app/` : note `/` at end of `/app/` - this indicates the folder `app` must be created in the container
  - e.g., `COPY index.js /app/`

  - could also use command `ADD`


- `WORKDIR` : sets the "working directory" for subsequent commands
  - e.g., `WORKDIR /app`

- `RUN` : used to run shell commands "inside" the container
  - e.g., `RUN npm install`

- `CMD` : always the last command to be executed when a Docker container starts
    - there can only be 1 CMD in a Dockerfile
    - e.g., `CMD ["node", "index.js"]

### Build
- `docker build -t myName:mytag .` : builds a container called myName with mytag in `.` (current directory)


## Docker Compose
- is used for setting-up multiple containers that are associated with 1 app

- create `docker-compose.yml` file : defines images / containers with various config options
- then run `docker-compose up` in the directory with the `docker-compose.yml` file : should spin up the app and run it
    - can run `docker-compose up -d` for 'detached' mode (background)

- `docker-compose down -v` : destroy cluster and data volumes

- `docker-compose run web bash` : runs a container with a bash terminal


## ECS
- install ecs-cli (follow instructions on the web)

- Create "Access key ID" and "Secret Access Key"
    - from AWS console > click on username in upper R > Security Credentials
    - scroll down to find Access keys
    - Keys can be created here (although not recommended)
      - (I followed tutorial and didn't create IAM access users)

- configure ecs-cli with access keys:
    - `ecs-cli configure profile --profile-name ecs-foodtrucks --access-key $AWS_ACCESS_KEY_ID --secret-key $AWS_SECRET_ACCESS_KEY`


- Need to create keypair to login to instances:
  - go to EC2 Dashboard > Key pairs > Create key pair
  - note the saved name name of the key pair (will be required to setup a cluster)
  - also need to download the keypair to a local directory


- `ecs-cli configure --region us-east-1 --cluster foodtrucks`
    - defines a cluster with name 'foodtrucks' in a specific region
    - Note:  this region must correspond with the region defined when creating a keypair


- `ecs-cli up --keypair ecs --capability-iam --size 1 --instance-type t2.medium`
    - sets up a CloudFormation (infrastructure as code)

- `docker-compose.yml` file is set-up to specify docker hub location for docker image (i.e., jjmchew/ft:1.0)

- created log group for cluster (to match what is in `docker-compose.yml`)


- `ecs-cli compose up` (needs to be run in folder with `docker-compose.yml` file)


- `ecs-cli ps` : will list available containers and the IP/ports being used
    - this port (e.g., `44.213.117.189:80` is the internet IP address that can be used in a browser to access the now deployed application)

- `ecs-cli down --force` : turn down deployed cluster