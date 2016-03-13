#!/bin/bash
#
### BEGIN INIT INFO
# Provides:          LFS
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Should-Start:      $network $time
# Should-Stop:       $network $time
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start and stop LFS file system
### END INIT INFO
#

set -e

[ -x /usr/sbin/LFS ] || {
	echo LFS not exists
	exit 0
}

start() {
	LFS --daemon --security --host :: --dir /var/LFS/STORAGE
	echo LFS started
}

stop() {
	killall -q LFS
	echo LFS stoped
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		stop
		start
		;;
	*)
		;;
esac
