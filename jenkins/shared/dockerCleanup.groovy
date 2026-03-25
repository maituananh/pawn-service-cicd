def call(String dockerRepo) {
    sh """
      # Authenticate to Docker Hub API
      TOKEN=\$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'\${DOCKER_USER}'", "password": "'\${DOCKER_PASS}'"}' "https://hub.docker.com/v2/users/login/" | grep -Eo '"token": ?"[^"]+"' | awk -F'"' '{print \$4}' | head -n 1)
      
      if [ -z "\$TOKEN" ]; then
        echo "Failed to get Docker Hub token"
        exit 0
      fi

      # Fetch tags, filter numeric (timestamps), sort descending, keep top 5, and delete the rest
      TAGS=\$(curl -s -H "Authorization: JWT \${TOKEN}" "https://hub.docker.com/v2/repositories/${dockerRepo}/tags/?page_size=100" | grep -Eo '"name": ?"[^"]+"' | awk -F'"' '{print \$4}' | grep -E '^[0-9]+\$' | sort -r | tail -n +6)
      
      for TAG in \$TAGS; do
        if [ -n "\$TAG" ]; then
          echo "Deleting old tag \$TAG from Docker Hub..."
          curl -s -X DELETE -H "Authorization: JWT \${TOKEN}" "https://hub.docker.com/v2/repositories/${dockerRepo}/tags/\$TAG/"
        fi
      done
    """
}

return this
