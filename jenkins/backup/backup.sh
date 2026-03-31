MSYS_NO_PATHCONV=1 docker run --rm \
  -v jenkins_jenkins_data:/data \
  -v $(pwd):/backup \
  busybox:1.37.0 \
  tar -czf - \
  --exclude='workspace' \
  --exclude='logs' \
  --exclude='.cache' \
  --exclude='caches' \
  --exclude='tools' \
  --exclude='*.log' \
  --exclude='*.tmp' \
  -C /var/jenkins_home .