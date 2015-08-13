# docker-node-broccoli
Docker image for continuous builds using Broccoli.

This image uses `inotifywait` to poll a project directory for changes. If modifications, creations, or deletions occur, `broccoli build` is run.

## Volumes

By default, this image sets up a volume at `/opt/broccoli/project`. You can either use the `-v` flag of `docker run` to mount your project, or you could build your own Docker image that checks out your project from source.

Regardless of how you attach your project files, the `/opt/broccoli/project` folder needs a `Brocfile.js` to do any builds.

## Environment variables

You can configure source and destination folders as well as the user and group IDs of the built files.

* `SRC_DIR` – This is the folder in your project to watch for changes. It's set to `src` by default.
* `DIST_DIR` – This is the folder in your project where the build will be exported. It's set to `dist` by default.
* `OUID` – This is the UID of the owner. It's the `$UID` of the user running Broccoli by default, in this image, that's root.
* `OGID` – This is the GID of the owner. It's the `$GID` of the user running Broccoli by default, in this image, that's root.

## Example 

Say you have a project folder at `/home/foobar/my-project`. Within, you've got `app` and you want it generated to `html`. Also, you want all files to be owned by you.

```shell
docker run -d -v /home/foobar/my-project:/opt/broccoli/project -e SRC_DIR='app' -e DIST_DIR='html' -e OUID=`id -u` -e OGID=`id -g` appertly/node-broccoli
```
