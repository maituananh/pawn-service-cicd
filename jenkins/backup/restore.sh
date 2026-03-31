MSYS_NO_PATHCONV=1 docker run --rm \
  -v jenkins_jenkins_data_backup:/data \
  -v "$(pwd):/backup" \
  busybox:1.37.0 \
  sh -c "tar xzf /backup/jenkins-backup.tar.gz -C /data --strip-components=1"