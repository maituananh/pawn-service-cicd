MSYS_NO_PATHCONV=1 docker run --rm \
  -v jenkins_data_1:/data \
  -v "$(pwd):/backup" \
  busybox:1.37.0 \
  sh -c "tar xzf /backup/jenkins_backup.tar.gz -C /data --strip-components=1"