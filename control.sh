#!/bin/bash

CIRCLE_HOME=/root/senmud
PORT=8899

restart_circle() {
	cd ${CIRCLE_HOME}
	nohup setsid ./bin/circle -o ${CIRCLE_HOME}/mud.log ${PORT} > /dev/null 2>&1 &
}

kill_circle() {
	killall circle
	sleep 0.5
}

check_circle() {
	p=`netstat -ntpl 2>/dev/null | grep ${PORT} | wc -l`
	if (( $p == 0 ))
	then
		restart_circle
		echo "circle not exists, restart"
	else
		echo "circle ok"
	fi
}

case "$1" in
	"restart")
		kill_circle
		restart_circle
		check_circle
		;;
	"stop")
		kill_circle
		exit
		;;
	*)
		check_circle
		;;
esac

