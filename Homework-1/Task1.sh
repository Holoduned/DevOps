#!/bin/bash

LOGFILE="Task1.log"

log() {
    echo "$(date +'%d-%m-%Y %H:%M:%S') - $1" | tee -a $LOGFILE
}

process_arguments() {
    while getopts "d:" opt; do
        case $opt in
            d)
                ROOT_DIR="$OPTARG"
                ;;
            *)
                echo "Usage: $0 [-d root_directory]"
                exit 1
                ;;
        esac
    done

    if [ -z "$ROOT_DIR" ]; then
        read -p "Введите путь до корневого каталога: " ROOT_DIR
    fi

    if [ ! -d "$ROOT_DIR" ]; then
        log "Ошибка: Директория $ROOT_DIR не существует."
        exit 1
    fi

    if [ ! -w "$ROOT_DIR" ]; then
        log "Ошибка: Нет прав на запись в директорию $ROOT_DIR."
        exit 1
    fi
}

get_user_list() {
    getent passwd | awk -F: '$3 >= 1000 && $3 != 65534 {print $1}'
}

create_user_directories() {
    local user_list="$1"
    
    for user in $user_list; do
        local user_home_dir="$ROOT_DIR/$user"
        
        if [ ! -d "$user_home_dir" ]; then
            mkdir "$user_home_dir"
            chmod 755 "$user_home_dir"
            chown "$user:$user" "$user_home_dir"
            log "Директория $user_home_dir создана и права установлены."
        else
            log "Директория $user_home_dir уже существует."
        fi
    done

    log "Все операции завершены."
}

process_arguments "$@"
user_list=$(get_user_list)
create_user_directories "$user_list"
