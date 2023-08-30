# =============================================================================
#   Dev Container Configuration

# Which image are we using for development environment?
DEV_DOCKER_IMAGE="node:18.17.1-slim"

# What additional Docker flags should we use (if any)?
ADDITIONAL_DOCKER_CONFIG='--cpus 2 -p 3000:3000 -p 6006:6006'

# =============================================================================

# =============================================================================
#   Dev Container Management Functions (DO NOT EDIT)

function drh {
    # "Docker Run Here"
    # ref: https://gist.github.com/matt-wiley/e1063d877386b0425ab6e912c8f5a59b
    # Simplfies running Docker container with current working directory mounted in.
    docker run -dit --rm -v "$(pwd):$(pwd)" -w "$(pwd)" "${@}"
}

function dev_container {
    local container_name="$(pwd | xargs basename)"
    case "${1}" in
        "start")
            shift
            # echo "Checking for dev container."
            if $(docker exec "${container_name}" sh 2>/dev/null ); then
                : # echo "Dev container found."
            else 
                drh --name ${container_name} ${ADDITIONAL_DOCKER_CONFIG} ${DEV_DOCKER_IMAGE} 2>&1>&-
            fi
            ;;
        "exec")
            shift
            # echo "Checking for dev container."
            if $(docker exec "${container_name}" sh 2>/dev/null); then
                # echo "Dev container found."
                docker exec -it "${container_name}" "${@}"
            else 
                # echo "Dev container not found."
                dev_container start
                docker exec -it "${container_name}" "${@}"
            fi
            ;;
        "inspect")
            shift
            # echo "Checking for dev container."
            if $(docker exec "${container_name}" sh 2>/dev/null); then
                # echo "Dev container found."
                docker inspect "${container_name}"
            else 
                echo "Dev container '${container_name}' not found."
            fi
            ;;
        "stop")
            shift
            # echo "Checking for dev container."
            if $(docker exec "${container_name}" sh 2>/dev/null ); then
                # echo "Dev container found."
                docker kill ${container_name} 2>&1>&-
            else 
                : # echo "Dev container not found."
            fi
            ;;
        *)
            ;;
    esac
}

# =============================================================================


# =============================================================================
#   Convenience aliases

alias dc='dev_container'
    # Useful for running 'dc stop' to kill the dev container

# =============================================================================


# =============================================================================
#   Near-native aliases for dev container executions.
#   Usually the main tooling commands

alias node='dev_container exec node'
alias npm='dev_container exec npm'

# =============================================================================