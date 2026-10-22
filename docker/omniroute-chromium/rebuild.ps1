# Pulls the latest upstream OmniRoute image, rebuilds the local Chromium image
# and recreates the container. Data lives in the omniroute-data volume.
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

docker pull diegosouzapw/omniroute:next
if ($LASTEXITCODE -ne 0) { throw "pull failed" }
docker build -t omniroute-chromium:local $here
if ($LASTEXITCODE -ne 0) { throw "build failed; existing container left untouched" }

docker rm -f omniroute
docker run -d --name omniroute `
  --init `
  --restart unless-stopped `
  -p 20128:20128 `
  -v omniroute-data:/app/data `
  --shm-size=1g `
  --label com.centurylinklabs.watchtower.enable=false `
  omniroute-chromium:local
if ($LASTEXITCODE -ne 0) { throw "run failed" }
docker exec omniroute sh -c 'test -x "$CHROME_PATH" && /usr/bin/chromium --version'
