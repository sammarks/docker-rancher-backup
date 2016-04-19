# Docker Rancher Backup

Gets a list of all containers running on the current rancher host and
backs them up to Amazon S3 every three days. With the following environment
variables:

- `AWS_ACCESS_KEY`
- `AWS_SECRET_KEY`
- `AWS_BUCKET`
- `TAR_OPTS`

Here's a healthy default for the `TAR_OPTS` environment variable that
has some nice exclusions:

```
--exclude=backup --exclude=*/Cache* --exclude=*/cache* --exclude=*/Log* --exclude=*/log* --exclude=*/backup* --exclude=*/export* --exclude=*/plugins-osgi-cache* --exclude=*/tmp* --exclude=*.log --exclude=*/artifacts* --exclude=*/builds* --exclude=*/build-dir* --exclude=/var/lib/docker*
```

Here's a test run command:

```
docker run --rm --name=backup -d \
    -e TAR_OPTS="--exclude=backup" \
    -e AWS_ACCESS_KEY=access_key \
    -e AWS_SECRET_KEY=secret_key \
    -e AWS_BUCKET="bucket-name" \
    docker-rancher-backup
```
