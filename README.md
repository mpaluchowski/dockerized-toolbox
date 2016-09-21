# Dockerized Toolbox

A set of development tools configured to run inside [Docker][docker-home] containers, with code mounted from the host machine. This ensures each one is running in a clean environment, there are no conflicting dependencies, and also makes upgrading to newer versions trivial.

## Installation

1. Open a *nix-compatible shell where the `docker` command is available and configured.
2. Run the `build.sh` script to build all the tool containers.
3. Run the `install-all.sh` script to copy all individual `*/run.sh` scripts to `~/bin/` for easy running.

## Running

You can run any tool with its usual command, eg.

```shell
$ composer --version
Composer version 1.1.0 2016-05-10 15:21:19
```

which is the same as running:

```shell
$ composer/run.sh --version
Composer version 1.1.0 2016-05-10 15:21:19
```

The command will start the Docker container, mount your current directory to it, run the tool inside the container, then quit and clean up the container remains, while results will be output to your working directory.

## Customization

You can change the prefix of the Docker images, from the default being the __name of the working directory__ to anything else via:

```shell
$ ./build.sh -p myprefix
```

which will build images with names ie. `myprefix/phpunit`.

[docker-home]: https://www.docker.com/
