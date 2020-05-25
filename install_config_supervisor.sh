#!/bin/bash
set -e
SUPERVISOR_CONF_DIR="/etc/supervisor"
SUP_CONF="supervisord.conf"
PORT="8888"
APP_NAME="uos_docs"
# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get the absolute path to the script file
SCRIPT_DIR="/home/uisee/software/my_wiki"
CONF_DIR="/etc/supervisor/conf.d"  # supervisor configuration file directory
CONF="$APP_NAME.conf"
UOS_DOC_DIR="/home/uisee/Documents/uos_docs"  # todo: improve

main()
{
    install_apt_dependencies
    enable_supervisor_web_interface
    create_uos_docs_config_for_app
}

install_apt_dependencies()
{
    sudo apt-get install -y supervisor
}

enable_supervisor_web_interface()
{
    # enable the web gui interface
    if ( grep -Fxq "[inet_http_server]" /etc/supervisor/supervisord.conf ); then
        # if find "inet_http_server" in the supervisord.conf
        echo "Found web gui configuration."
        if ( grep "port" /etc/supervisor/supervisord.conf ); then
            echo "port found"
            sudo sed -i '/port /c\port = 127.0.0.1:9001' /etc/supervisor/supervisord.conf
        else
            # port not found
            echo "port not found"
            sudo sh -c 'echo "port = 127.0.0.1:9001" >> /etc/supervisor/supervisord.conf'
        fi

    else
        # can not find the configuration for the web app
        sudo sh -c "echo '[inet_http_server]' >> /etc/supervisor/supervisord.conf"
        sudo sh -c 'echo "port = 127.0.0.1:9001" >> /etc/supervisor/supervisord.conf'
    fi
    sudo service supervisor start && sudo supervisorctl reread
    sudo supervisorctl update
}

create_uos_docs_config_for_app()
{
    cd $UOS_DOC_DIR
    ## create supervisor configuration file for the app
    touch "$CONF"
    # write lines
    echo "[program:$APP_NAME]" > $CONF
    echo "directory = $UOS_DOC_DIR" >> $CONF
    echo "command = mkdocs serve" >> $CONF
    echo "autostart = true" >> $CONF
    echo "autorestart = true" >> $CONF
    echo "stderr_logfile = /var/log/$APP_NAME.err.log" >> $CONF
    echo "stdout_logfile = /var/log/$APP_NAME.out.log" >> $CONF
    # change the permission of the file
    sudo chmod a+x $CONF
    # enable the app in supervisor
    sudo mv $CONF $CONF_DIR
    # read the supervisor configuration file
    sudo supervisorctl reread
    # update the programs run by the supervisor
    sudo supervisorctl update
}

main
