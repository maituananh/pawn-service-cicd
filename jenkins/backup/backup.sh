MSYS_NO_PATHCONV=1 docker run --rm \
  -v jenkins_jenkins_data:/data \
  -v $(pwd):/backup \
  busybox:1.37.0 \
  tar czf /backup/jenkins_backup_exclude.tar.gz \
  --exclude='./workspace' \
  --exclude='./caches' \
  --exclude='./logs' \
  -C /data .