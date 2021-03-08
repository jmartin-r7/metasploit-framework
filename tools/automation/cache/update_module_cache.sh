#/bin/sh -ex

if [ ! -f "msfconsole" ]; then
  echo "Missing 'msfconsole' the tool should only be run from the root of the repository.'"
  exit 1
fi

if [ -f "waitForStore.rc" ]; then
  echo "'waitForStore.rc' already exists the tool should only be run in a clean checkout.'"
  exit 1
fi

if [ -f "buildNewStore.sh" ]; then
  echo "'buildNewStore.sh' already exists the tool should only be run in a clean checkout.'"
  exit 1
fi

DOCKER_EXEC=`which docker`

if [ -z "$DOCKER_EXEC" ]; then
  echo "Docker is required to run this tool."
  exit 1
fi

IMG='metasploitframework/metasploit-framework:latest'

docker run --rm=true --tty \
  --volume=`pwd`:/r7-source \
  --workdir=/r7-source ${IMG} \
  /bin/sh -l -c ./tools/automation/cache/buildNewCache.sh
