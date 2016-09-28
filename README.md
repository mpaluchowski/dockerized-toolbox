# Dockerized Toolbox

A set of development tools configured to run inside [Docker][docker-home] containers, with code mounted from the host machine. This ensures each one is running in a clean environment, there are no conflicting dependencies, and also makes upgrading to newer versions trivial.

## Installation

1. If you're using Docker in a VirtualBox machine, check your [Shared Folders configuration](#configuring-shared-folders).
2. Open a *nix-compatible shell where the `docker` command is available and configured.
3. Run the `./toolbox.sh build` to build all the tool containers.
4. Run the `./toolbox.sh install` script to create all individual running scripts in `~/bin/` for easy launching.

## Running

After installing the running scripts, can run any tool with its usual command, eg.

```shell
$ composer --version
Composer version 1.1.0 2016-05-10 15:21:19
```

which is the same as running:

```shell
$ docker run \
	--rm \
	-v $(pwd):/app \
	dockerized-toolbox/composer:latest \
	--version
Composer version 1.1.0 2016-05-10 15:21:19
```

The command will start the Docker container, mount your current directory to it, run the tool inside the container, then quit and clean up the container remains, while results will be output to your working directory.

## Customization

### Image Prefix

You can change the prefix of the Docker images, from the default being the __name of the working directory__ to anything else via:

```shell
$ ./toolbox.sh -p myprefix
```

which will build images with names ie. `myprefix/phpunit`.

### Custom `docker run` Parameters

If you need to add custom parameters to the `docker run` commands in the generated running scripts, create a `run-params.conf` file inside the tool's directory and add one parameter per line, ie:

```shell
-v ~/.ssh:/root/.ssh
```

## Configuring Shared Folders

When using Docker inside VirtualBox (the usual case in Windows), you may need to add some Shared Folders and mount them inside the virtual machine where Docker is running. By default, only `C:\Users\` is mapped.

Without it, the `-v $(pwd):/app` parameters to `docker run` will not work and sadly will _not report any errors_. Only the tool inside the container will complain that it cannot find any source files and leave you scratching your head.

1. Open the VirtualBox Manager, right-click the `default` machine and choose `Settings`.
2. Go to the `Shared Folders` section, click `Add new shared folder` on the right-hand side.
3. Choose the root directory you want to be able to mount inside containers, ie. `C:\Code`, give it a name, ie. `c/Code` (following the convention for `Users`), check `Auto-mount` and `Make Permanent`.
4. SSH into the `default` machine. Create, or edit the file `/var/lib/boot2docker/bootlocal.sh` to contain:

    ```shell
    #!/bin/sh
    mkdir -p /c/Code
    mount -t vboxsf c/Code /c/Code
    ```

    This ensures the directory is mounted after the virtual machine restarts.

[docker-home]: https://www.docker.com/
