#!/usr/bin/env bash

addReminder() {
    echo "Remind me: $4 in $1 days, $2 hours and $3 minutes."
}
declare -i days=0 hours=0 minutes=0
while getopts "d:h:m:a:" option; do
    case $option in
    d) days="$OPTARG" ;;
    h) hours="$OPTARG" ;;
    m) minutes="$OPTARG" ;;
    a)
        reminder="$OPTARG"
        addReminder "$days" "$hours" "$minutes" "$reminder"
        ;;
    *)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    esac
done
