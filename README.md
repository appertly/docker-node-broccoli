# docker-node-broccoli
Docker image for continuous builds using Broccoli 1.x.

This image uses a fork of `broccoli-timepiece` to poll a project directory for changes. If any modifications occur, a Broccoli build runs.

My use case (that is, why I originally put this image together):
* Write JavaScript in ES6/Harmony.
* Use Broccoli to run a Babel transpile if any files change.
* I can point my browser to a local application server instead of the one used by `broccoli serve`.

## Volumes

By default, this image sets up a volume at `/opt/broccoli/project`. You can either use the `-v` flag of `docker run` to mount your project, or you could build your own Docker image that checks out your project from source.

Regardless of how you attach your project files, the `/opt/broccoli/project` folder needs a `package.json` and `Brocfile.js` to do any builds.

## Arguments

Any arguments after the `docker run` command will be passed along to `broccoli-timepiece`. Namely, you'll want to supply the destination directory, which is `dist` by default.

## User / Group

It's probably a good idea to run the container using your own UID and GID with the `--user` option of `docker run`.

## Example 

Say you have a project folder at `/home/foobar/my-project`. Within, you have a `Brocfile.js` that reads from `app` and you want the build output to `html`. Also, you want all files to be owned by you.

```shell
docker run -d -v /home/foobar/my-project:/opt/broccoli/project --user $(id -u):$(id -g) appertly/node-broccoli html
```

## NPM 

This image also has Node.js and `npm` installed. You can use this container to update your project dependencies in case your local system doesn't have `npm`.

```shell
mkdir -p $HOME/.npm
docker run --rm --entrypoint npm -v $HOME/.npm:/.npm -v /path/to/my/project:/opt/broccoli/project appertly/node-broccoli update
```
You can also run `npm update` from a running container.

```shell
docker exec -it your-container-name npm update
```
