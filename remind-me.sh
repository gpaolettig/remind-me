#!/usr/bin/env bash

addReminder() {
    time_string=""
    if [[ $1 -gt 0 ]]; then
        time_string+="$1 hours "
    fi
    if [[ $2 -gt 0 ]]; then
        time_string+="$2 minutes"
    fi
    if [[ -z $time_string ]]; then
        echo -e "\033[31mError: You must specify a future time.\033[0m"
        exit 1
    fi

    echo "notify-send -i 'dialog-information' -a 'remind-me' 'Reminder:' '$3'" | at now + "$time_string" 2>/dev/null
    echo -e "\033[32mReminder scheduled: '$3' in $time_string.\033[0m"
}
showHelp() {
    printf "Usage: %s [\033[95m-h\033[0m hours] [\033[95m-m\033[0m minutes] [\033[95m-a\033[0m 'reminder']\n" "$0"
    printf "Options:\n"
    printf "  \033[95m-h\033[0m hours       Number of hours for the reminder.\n"
    printf "  \033[95m-m\033[0m minutes     Number of minutes for the reminder.\n"
    printf "  \033[95m-a\033[0m 'reminder'  The reminder message.\n"
}

declare -i hours=0 minutes=0
while getopts "d:h:m:a:" option; do
    case $option in
    h) hours="$OPTARG" ;;
    m) minutes="$OPTARG" ;;
    a)
        reminder="$OPTARG"
        addReminder "$hours" "$minutes" "$reminder"
        ;;
    *)
        echo -e "\033[31mInvalid option: -$OPTARG\033[0m" >&2
        exit 1
        ;;
    esac
done
if [[ $OPTIND -eq 1 ]]; then
    showHelp
    exit 0
fi