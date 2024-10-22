#!/bin/bash

get_project_version() {
    if [ -f "package.json" ]; then
        version=$(jq -r .version package.json)
        echo "Versión del proyecto obtenida de package.json: $version"
    elif [ -f "CHANGELOG.md" ]; then
        version=$(grep -m 1 -oP '## \[\K[^]]+' CHANGELOG.md)
        echo "Versión del proyecto obtenida de CHANGELOG.md: $version"
    else
        version=$(git describe --tags --abbrev=0 2>/dev/null)
        if [ -z "$version" ]; then
            echo "No se encontraron versiones."
        else
            echo "Versión del proyecto obtenida de Git tags: $version"
        fi
    fi
}

get_repository_info() {
    # Obtener el nombre del repositorio
    repo_url=$(git config --get remote.origin.url)
    repo_name=$(basename -s .git "$repo_url")

    # Obtener la rama actual
    branch_name=$(git rev-parse --abbrev-ref HEAD)

    echo "Nombre del repositorio: $repo_name"
    echo "Rama actual: $branch_name"
}

get_project_version
get_repository_info