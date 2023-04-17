#!/bin/bash

help() {
    cat <<EOF >&2
   user.list yer alan sitelerin ip adresini degistirmektedir.
Usage:	./changeip.sh -i <ip adress> -f <user.list>
	-h, --help  		Help
	-i, --ipadres		Ip Adress
	-f, --filelist	User List
EOF

}

while getopts ":h:i:f:" usage; do
    case $usage in
    h)
        help
        exit 1
        ;;
    i) ipadres="$OPTARG" ;;
    f) filelist="$OPTARG" ;;
    [?])
        help
        exit
        ;;
    esac
done

if [[ -z $ipadres ]] || [[ -z $filelist ]]; then
    help
    exit 1
fi

changeip() {
    cat $filelist | while read Nuser; do
        /usr/local/cpanel/bin/setsiteip -u $Nuser $ipadres
        echo $Nuser $ipadres
        sleep 1
    done
}

changeip
