#!/bin/bash

set -e

NUMBER_OF_FILES=30;
BACKUP_DIR="/data/backups"
#TOODAY="$(date "+%Y-%m-%d_%H-%M-%S")"
TOODAY="$(date "+%Y-%m-%d")"
TARGET_DIR="/home/anton"
TAR_FILE="${BACKUP_DIR}/${TOODAY}.tar.gz"

function count_files_in() {
    cd "${1}";
    echo "$(ls|wc -l)";
}

function get_firsts_files_from() {
    cd "${1}";
    echo "$(ls |awk '{print $0}'|head -n ${2})";
} 

function backup_project(){
    COUNT="$(count_files_in "${BACKUP_DIR}")";
    if (( "${COUNT}" > "${NUMBER_OF_FILES}" ));then
        for FILE in $(get_firsts_files_from ${BACKUP_DIR} $[$COUNT - $NUMBER_OF_FILES]); do
            rm -f "${BACKUP_DIR}/${FILE}";
        done
    fi
    [[ -f "${TAR_FILE}" ]] && rm "${TAR_FILE}"
    tar -zcf "${TAR_FILE}" "${TARGET_DIR}" -P;
}

#------------------------  START -------------------------------------------------------------------

[[ -d "${BACKUP_DIR}" ]] && backup_project || exit 35

#------------------------  END   -------------------------------------------------------------------
