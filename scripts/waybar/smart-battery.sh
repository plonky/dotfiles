#!/bin/bash

FULL=95
NORMAL=20
WARNING=10

FULLSLEEP=60
WARNINGSLEEP=30
CRITICALSLEEP=5

trap ':' SIGUSR1

while true; do
    percentage=$(cat /sys/class/power_supply/BAT1/capacity)
    state=$(cat /sys/class/power_supply/BAT1/status)

    filled=$((percentage / 10))
    empty=$((10 - filled))


    bar_filled=$(seq 1 $filled | xargs printf '▰%.0s')

    # If the battery is 100, it'll still show 1 empty bar unless we have this
    if [ $empty = 0 ]; then
        bar_empty=''
    else
        bar_empty=$(seq 1 $empty | xargs printf '▱%.0s')
    fi

    bar="$bar_filled$bar_empty"


    if [ $percentage -ge $FULL ]; then
        class='full'
    elif [ $percentage -ge $NORMAL ]; then
        class='normal'
    elif [ $percentage -ge $WARNING ]; then
        class='warning'
    else
        # I like having a more precise battery percentage when
        # the battery is low, so I pull the decimal number
        class='critical'
        energy_now=$(cat /sys/class/power_supply/BAT1/energy_now)
        energy_full=$(cat /sys/class/power_supply/BAT1/energy_full)
        precise=$(awk "BEGIN {printf \"%.2f\", $energy_now / $energy_full * 100 }")
    fi


    if [ $state = 'Charging' ]; then
        charging_icon='󱐋'
        class="$class charging"
    else
        charging_icon=' '
    fi


    # Wildcards (*) make sure the class is still relevant even 
    # when adding the " charging" string
    if [[ $class == *"critical"* ]]; then
        echo "{\"text\":\"$bar $precise% $charging_icon\",\"class\":\"$class\"}"
    else
        echo "{\"text\":\"$bar $percentage% $charging_icon\",\"class\":\"$class\"}"
    fi


    case "$class" in
        *'full'*|*'normal'*) sleep $FULLSLEEP &
            wait $! ;;
        *'warning'*) sleep $WARNINGSLEEP &
            wait $! ;;
        *'critical'*) sleep $CRITICALSLEEP &
            wait $! ;;
    esac

done
