Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34308 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbcGRSeJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jul 2016 14:34:09 -0400
From: Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>
To: corbet@lwn.net, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
	tglx@linutronix.de, clemens@ladisch.de, wim@iguana.be,
	linux@roeck-us.net, gregkh@linuxfoundation.org,
	maheshkhanwalkar@gmail.com, dasaratharaman.chandramouli@intel.com,
	timur@codeaurora.org, arnd@arndb.de, nab@linux-iscsi.org,
	hans.verkuil@cisco.com, mchehab@osg.samsung.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2] Documentation: Move samples from doc to samples/
Date: Mon, 18 Jul 2016 14:33:07 -0400
Message-Id: <1468866787-4094-1-git-send-email-maheshkhanwalkar@gmail.com>
In-Reply-To: <578D15D0.7020006 () codeaurora ! org>
References: <578D15D0.7020006 () codeaurora ! org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Moved sample code found in Documentation/ to samples/ but kept actual
documentation where it is, while updating any in-text references to the
moved code. Updated the Documentation/Makefile and samples/Makefile to
reflect the change. Built with CONFIG_SAMPLES=y in .config with no
build errors. The directories added within samples/ still follow the
same structure that they did in Documentation. Directories in
Documentation/ that contained code still exist, only the code within
them has been moved out accordingly.

Documentation/Makefile: Removed subdirectories that no longer have any
code or Makefiles in them

samples/Makefile: Added references to the new subdirectories created
from the move

Signed-off-by: Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>
---
Changes in v2: 
	- Fixed file delete + creation to file moved in patch.

 Documentation/Makefile                             |   6 +-
 Documentation/auxdisplay/Makefile                  |   7 -
 Documentation/auxdisplay/cfag12864b                |   2 +-
 Documentation/blackfin/Makefile                    |   5 -
 Documentation/mic/Makefile                         |   1 -
 Documentation/mic/mpssd/.gitignore                 |   1 -
 Documentation/mic/mpssd/micctrl                    | 173 ------------------
 Documentation/mic/mpssd/mpss                       | 200 ---------------------
 Documentation/pcmcia/Makefile                      |   7 -
 Documentation/pcmcia/devicetable.txt               |   2 +-
 Documentation/timers/Makefile                      |   5 -
 Documentation/timers/hpet.txt                      |   2 +-
 Documentation/watchdog/Makefile                    |   1 -
 Documentation/watchdog/pcwd-watchdog.txt           |   2 +-
 Documentation/watchdog/src/Makefile                |   5 -
 Documentation/watchdog/watchdog-api.txt            |   2 +-
 samples/Makefile                                   |   3 +-
 samples/auxdisplay/.gitignore                      |   1 +
 samples/auxdisplay/Makefile                        |   4 +
 .../auxdisplay/cfag12864b-example.c                |   0
 samples/blackfin/Makefile                          |   1 +
 .../blackfin/gptimers-example.c                    |   0
 samples/hpet/.gitignore                            |   1 +
 samples/hpet/Makefile                              |   7 +
 .../timers => samples/hpet}/hpet_example.c         |   0
 samples/mpssd/.gitignore                           |   3 +
 {Documentation/mic => samples}/mpssd/Makefile      |   0
 {Documentation/mic => samples}/mpssd/mpssd.c       |   0
 {Documentation/mic => samples}/mpssd/mpssd.h       |   0
 {Documentation/mic => samples}/mpssd/sysfs.c       |   0
 samples/pcmcia/.gitignore                          |   1 +
 samples/pcmcia/Makefile                            |   4 +
 {Documentation => samples}/pcmcia/crc32hash.c      |   0
 samples/prctl/.gitignore                           |   3 +
 {Documentation => samples}/prctl/Makefile          |   5 +-
 .../prctl/disable-tsc-ctxt-sw-stress-test.c        |   0
 .../prctl/disable-tsc-on-off-stress-test.c         |   0
 .../prctl/disable-tsc-test.c                       |   0
 .../watchdog/src => samples/watchdog}/.gitignore   |   0
 samples/watchdog/Makefile                          |   3 +
 .../src => samples/watchdog}/watchdog-simple.c     |   0
 .../src => samples/watchdog}/watchdog-test.c       |   0
 42 files changed, 39 insertions(+), 418 deletions(-)
 delete mode 100644 Documentation/auxdisplay/Makefile
 delete mode 100644 Documentation/blackfin/Makefile
 delete mode 100644 Documentation/mic/Makefile
 delete mode 100644 Documentation/mic/mpssd/.gitignore
 delete mode 100755 Documentation/mic/mpssd/micctrl
 delete mode 100755 Documentation/mic/mpssd/mpss
 delete mode 100644 Documentation/pcmcia/Makefile
 delete mode 100644 Documentation/timers/Makefile
 delete mode 100644 Documentation/watchdog/Makefile
 delete mode 100644 Documentation/watchdog/src/Makefile
 create mode 100644 samples/auxdisplay/.gitignore
 create mode 100644 samples/auxdisplay/Makefile
 rename {Documentation => samples}/auxdisplay/cfag12864b-example.c (100%)
 create mode 100644 samples/blackfin/Makefile
 rename {Documentation => samples}/blackfin/gptimers-example.c (100%)
 create mode 100644 samples/hpet/.gitignore
 create mode 100644 samples/hpet/Makefile
 rename {Documentation/timers => samples/hpet}/hpet_example.c (100%)
 create mode 100644 samples/mpssd/.gitignore
 rename {Documentation/mic => samples}/mpssd/Makefile (100%)
 rename {Documentation/mic => samples}/mpssd/mpssd.c (100%)
 rename {Documentation/mic => samples}/mpssd/mpssd.h (100%)
 rename {Documentation/mic => samples}/mpssd/sysfs.c (100%)
 create mode 100644 samples/pcmcia/.gitignore
 create mode 100644 samples/pcmcia/Makefile
 rename {Documentation => samples}/pcmcia/crc32hash.c (100%)
 create mode 100644 samples/prctl/.gitignore
 rename {Documentation => samples}/prctl/Makefile (53%)
 rename {Documentation => samples}/prctl/disable-tsc-ctxt-sw-stress-test.c (100%)
 rename {Documentation => samples}/prctl/disable-tsc-on-off-stress-test.c (100%)
 rename {Documentation => samples}/prctl/disable-tsc-test.c (100%)
 rename {Documentation/watchdog/src => samples/watchdog}/.gitignore (100%)
 create mode 100644 samples/watchdog/Makefile
 rename {Documentation/watchdog/src => samples/watchdog}/watchdog-simple.c (100%)
 rename {Documentation/watchdog/src => samples/watchdog}/watchdog-test.c (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index de955e1..667cdd2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,3 +1,3 @@
-subdir-y := accounting auxdisplay blackfin \
-	filesystems filesystems ia64 laptops mic misc-devices \
-	networking pcmcia prctl ptp timers vDSO watchdog
+subdir-y := accounting filesystems ia64 \
+	laptops misc-devices networking ptp \
+	vDSO
diff --git a/Documentation/auxdisplay/Makefile b/Documentation/auxdisplay/Makefile
deleted file mode 100644
index ada4dac..0000000
--- a/Documentation/auxdisplay/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# List of programs to build
-hostprogs-y := cfag12864b-example
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
-
-HOSTCFLAGS_cfag12864b-example.o += -I$(objtree)/usr/include
diff --git a/Documentation/auxdisplay/cfag12864b b/Documentation/auxdisplay/cfag12864b
index eb7be39..12fd51b 100644
--- a/Documentation/auxdisplay/cfag12864b
+++ b/Documentation/auxdisplay/cfag12864b
@@ -101,5 +101,5 @@ Although the LCD won't get updated until the next refresh time arrives.
 Also, you can mmap the framebuffer: open & mmap, munmap & close...
 which is the best option for most uses.
 
-Check Documentation/auxdisplay/cfag12864b-example.c
+Check samples/auxdisplay/cfag12864b-example.c
 for a real working userspace complete program with usage examples.
diff --git a/Documentation/blackfin/Makefile b/Documentation/blackfin/Makefile
deleted file mode 100644
index 6782c58..0000000
--- a/Documentation/blackfin/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-ifneq ($(CONFIG_BLACKFIN),)
-ifneq ($(CONFIG_BFIN_GPTIMERS),)
-obj-m := gptimers-example.o
-endif
-endif
diff --git a/Documentation/mic/Makefile b/Documentation/mic/Makefile
deleted file mode 100644
index a191d45..0000000
--- a/Documentation/mic/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-subdir-y := mpssd
diff --git a/Documentation/mic/mpssd/.gitignore b/Documentation/mic/mpssd/.gitignore
deleted file mode 100644
index 8b7c72f..0000000
--- a/Documentation/mic/mpssd/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-mpssd
diff --git a/Documentation/mic/mpssd/micctrl b/Documentation/mic/mpssd/micctrl
deleted file mode 100755
index 8f2629b..0000000
--- a/Documentation/mic/mpssd/micctrl
+++ /dev/null
@@ -1,173 +0,0 @@
-#!/bin/bash
-# Intel MIC Platform Software Stack (MPSS)
-#
-# Copyright(c) 2013 Intel Corporation.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License, version 2, as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# The full GNU General Public License is included in this distribution in
-# the file called "COPYING".
-#
-# Intel MIC User Space Tools.
-#
-# micctrl - Controls MIC boot/start/stop.
-#
-# chkconfig: 2345 95 05
-# description: start MPSS stack processing.
-#
-### BEGIN INIT INFO
-# Provides: micctrl
-### END INIT INFO
-
-# Source function library.
-. /etc/init.d/functions
-
-sysfs="/sys/class/mic"
-
-_status()
-{
-	f=$sysfs/$1
-	echo -e $1 state: "`cat $f/state`" shutdown_status: "`cat $f/shutdown_status`"
-}
-
-status()
-{
-	if [ "`echo $1 | head -c3`" == "mic" ]; then
-		_status $1
-		return $?
-	fi
-	for f in $sysfs/*
-	do
-		_status `basename $f`
-		RETVAL=$?
-		[ $RETVAL -ne 0 ] && return $RETVAL
-	done
-	return 0
-}
-
-_reset()
-{
-	f=$sysfs/$1
-	echo reset > $f/state
-}
-
-reset()
-{
-	if [ "`echo $1 | head -c3`" == "mic" ]; then
-		_reset $1
-		return $?
-	fi
-	for f in $sysfs/*
-	do
-		_reset `basename $f`
-		RETVAL=$?
-		[ $RETVAL -ne 0 ] && return $RETVAL
-	done
-	return 0
-}
-
-_boot()
-{
-	f=$sysfs/$1
-	echo "linux" > $f/bootmode
-	echo "mic/uos.img" > $f/firmware
-	echo "mic/$1.image" > $f/ramdisk
-	echo "boot" > $f/state
-}
-
-boot()
-{
-	if [ "`echo $1 | head -c3`" == "mic" ]; then
-		_boot $1
-		return $?
-	fi
-	for f in $sysfs/*
-	do
-		_boot `basename $f`
-		RETVAL=$?
-		[ $RETVAL -ne 0 ] && return $RETVAL
-	done
-	return 0
-}
-
-_shutdown()
-{
-	f=$sysfs/$1
-	echo shutdown > $f/state
-}
-
-shutdown()
-{
-	if [ "`echo $1 | head -c3`" == "mic" ]; then
-		_shutdown $1
-		return $?
-	fi
-	for f in $sysfs/*
-	do
-		_shutdown `basename $f`
-		RETVAL=$?
-		[ $RETVAL -ne 0 ] && return $RETVAL
-	done
-	return 0
-}
-
-_wait()
-{
-	f=$sysfs/$1
-	while [ "`cat $f/state`" != "offline" -a "`cat $f/state`" != "online" ]
-	do
-		sleep 1
-		echo -e "Waiting for $1 to go offline"
-	done
-}
-
-wait()
-{
-	if [ "`echo $1 | head -c3`" == "mic" ]; then
-		_wait $1
-		return $?
-	fi
-	# Wait for the cards to go offline
-	for f in $sysfs/*
-	do
-		_wait `basename $f`
-		RETVAL=$?
-		[ $RETVAL -ne 0 ] && return $RETVAL
-	done
-	return 0
-}
-
-if [ ! -d "$sysfs" ]; then
-	echo -e $"Module unloaded "
-	exit 3
-fi
-
-case $1 in
-	-s)
-		status $2
-		;;
-	-r)
-		reset $2
-		;;
-	-b)
-		boot $2
-		;;
-	-S)
-		shutdown $2
-		;;
-	-w)
-		wait $2
-		;;
-	*)
-		echo $"Usage: $0 {-s (status) |-r (reset) |-b (boot) |-S (shutdown) |-w (wait)}"
-		exit 2
-esac
-
-exit $?
diff --git a/Documentation/mic/mpssd/mpss b/Documentation/mic/mpssd/mpss
deleted file mode 100755
index 5fcf9fa..0000000
--- a/Documentation/mic/mpssd/mpss
+++ /dev/null
@@ -1,200 +0,0 @@
-#!/bin/bash
-# Intel MIC Platform Software Stack (MPSS)
-#
-# Copyright(c) 2013 Intel Corporation.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License, version 2, as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# The full GNU General Public License is included in this distribution in
-# the file called "COPYING".
-#
-# Intel MIC User Space Tools.
-#
-# mpss	Start mpssd.
-#
-# chkconfig: 2345 95 05
-# description: start MPSS stack processing.
-#
-### BEGIN INIT INFO
-# Provides: mpss
-# Required-Start:
-# Required-Stop:
-# Short-Description: MPSS stack control
-# Description: MPSS stack control
-### END INIT INFO
-
-# Source function library.
-. /etc/init.d/functions
-
-exec=/usr/sbin/mpssd
-sysfs="/sys/class/mic"
-mic_modules="mic_host mic_x100_dma scif vop"
-
-start()
-{
-	[ -x $exec ] || exit 5
-
-	if [ "`ps -e | awk '{print $4}' | grep mpssd | head -1`" = "mpssd" ]; then
-		echo -e $"MPSSD already running! "
-		success
-		echo
-		return 0
-	fi
-
-	echo -e $"Starting MPSS Stack"
-	echo -e $"Loading MIC drivers:" $mic_modules
-
-	modprobe -a $mic_modules
-	RETVAL=$?
-	if [ $RETVAL -ne 0 ]; then
-		failure
-		echo
-		return $RETVAL
-	fi
-
-	# Start the daemon
-	echo -n $"Starting MPSSD "
-	$exec
-	RETVAL=$?
-	if [ $RETVAL -ne 0 ]; then
-		failure
-		echo
-		return $RETVAL
-	fi
-	success
-	echo
-
-	sleep 5
-
-	# Boot the cards
-	micctrl -b
-
-	# Wait till ping works
-	for f in $sysfs/*
-	do
-		count=100
-		ipaddr=`cat $f/cmdline`
-		ipaddr=${ipaddr#*address,}
-		ipaddr=`echo $ipaddr | cut -d, -f1 | cut -d\; -f1`
-		while [ $count -ge 0 ]
-		do
-			echo -e "Pinging "`basename $f`" "
-			ping -c 1 $ipaddr &> /dev/null
-			RETVAL=$?
-			if [ $RETVAL -eq 0 ]; then
-				success
-				break
-			fi
-			sleep 1
-			count=`expr $count - 1`
-		done
-		[ $RETVAL -ne 0 ] && failure || success
-		echo
-	done
-	return $RETVAL
-}
-
-stop()
-{
-	echo -e $"Shutting down MPSS Stack: "
-
-	# Bail out if module is unloaded
-	if [ ! -d "$sysfs" ]; then
-		echo -n $"Module unloaded "
-		success
-		echo
-		return 0
-	fi
-
-	# Shut down the cards.
-	micctrl -S
-
-	# Wait for the cards to go offline
-	for f in $sysfs/*
-	do
-		while [ "`cat $f/state`" != "ready" ]
-		do
-			sleep 1
-			echo -e "Waiting for "`basename $f`" to become ready"
-		done
-	done
-
-	# Display the status of the cards
-	micctrl -s
-
-	# Kill MPSSD now
-	echo -n $"Killing MPSSD"
-	killall -9 mpssd 2>/dev/null
-	RETVAL=$?
-	[ $RETVAL -ne 0 ] && failure || success
-	echo
-	return $RETVAL
-}
-
-restart()
-{
-	stop
-	sleep 5
-	start
-}
-
-status()
-{
-	micctrl -s
-	if [ "`ps -e | awk '{print $4}' | grep mpssd | head -n 1`" = "mpssd" ]; then
-		echo "mpssd is running"
-	else
-		echo "mpssd is stopped"
-	fi
-	return 0
-}
-
-unload()
-{
-	if [ ! -d "$sysfs" ]; then
-		echo -n $"No MIC_HOST Module: "
-		success
-		echo
-		return
-	fi
-
-	stop
-
-	sleep 5
-	echo -n $"Removing MIC drivers:" $mic_modules
-	modprobe -r $mic_modules
-	RETVAL=$?
-	[ $RETVAL -ne 0 ] && failure || success
-	echo
-	return $RETVAL
-}
-
-case $1 in
-	start)
-		start
-		;;
-	stop)
-		stop
-		;;
-	restart)
-		restart
-		;;
-	status)
-		status
-		;;
-	unload)
-		unload
-		;;
-	*)
-		echo $"Usage: $0 {start|stop|restart|status|unload}"
-		exit 2
-esac
-
-exit $?
diff --git a/Documentation/pcmcia/Makefile b/Documentation/pcmcia/Makefile
deleted file mode 100644
index 47a8fa1..0000000
--- a/Documentation/pcmcia/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# List of programs to build
-hostprogs-y := crc32hash
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
-
-HOSTCFLAGS_crc32hash.o += -I$(objtree)/usr/include
diff --git a/Documentation/pcmcia/devicetable.txt b/Documentation/pcmcia/devicetable.txt
index 199afd1..af217b9 100644
--- a/Documentation/pcmcia/devicetable.txt
+++ b/Documentation/pcmcia/devicetable.txt
@@ -27,7 +27,7 @@ pcmcia:m0149cC1ABf06pfn00fn00pa725B842DpbF1EFEE84pc0877B627pd00000000
 The hex value after "pa" is the hash of product ID string 1, after "pb" for
 string 2 and so on.
 
-Alternatively, you can use crc32hash (see Documentation/pcmcia/crc32hash.c)
+Alternatively, you can use crc32hash (see samples/pcmcia/crc32hash.c)
 to determine the crc32 hash.  Simply pass the string you want to evaluate
 as argument to this program, e.g.:
 $ ./crc32hash "Dual Speed"
diff --git a/Documentation/timers/Makefile b/Documentation/timers/Makefile
deleted file mode 100644
index 6c09ee6..0000000
--- a/Documentation/timers/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# List of programs to build
-hostprogs-$(CONFIG_X86) := hpet_example
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
diff --git a/Documentation/timers/hpet.txt b/Documentation/timers/hpet.txt
index a484d2c..5edd798 100644
--- a/Documentation/timers/hpet.txt
+++ b/Documentation/timers/hpet.txt
@@ -25,4 +25,4 @@ arch/x86/kernel/hpet.c.
 
 The driver provides a userspace API which resembles the API found in the
 RTC driver framework.  An example user space program is provided in
-file:Documentation/timers/hpet_example.c
+file:samples/hpet/hpet_example.c
diff --git a/Documentation/watchdog/Makefile b/Documentation/watchdog/Makefile
deleted file mode 100644
index 6018f45..0000000
--- a/Documentation/watchdog/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-subdir-y := src
diff --git a/Documentation/watchdog/pcwd-watchdog.txt b/Documentation/watchdog/pcwd-watchdog.txt
index 4f68052..8903b92 100644
--- a/Documentation/watchdog/pcwd-watchdog.txt
+++ b/Documentation/watchdog/pcwd-watchdog.txt
@@ -25,7 +25,7 @@ Last reviewed: 10/05/2007
 
  If you want to write a program to be compatible with the PC Watchdog
  driver, simply use of modify the watchdog test program:
- Documentation/watchdog/src/watchdog-test.c
+ samples/watchdog/watchdog-test.c
 
 
  Other IOCTL functions include:
diff --git a/Documentation/watchdog/src/Makefile b/Documentation/watchdog/src/Makefile
deleted file mode 100644
index 4a892c3..0000000
--- a/Documentation/watchdog/src/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# List of programs to build
-hostprogs-y := watchdog-simple watchdog-test
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
diff --git a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
index b3a701f..0e62ba3 100644
--- a/Documentation/watchdog/watchdog-api.txt
+++ b/Documentation/watchdog/watchdog-api.txt
@@ -37,7 +37,7 @@ activates as soon as /dev/watchdog is opened and will reboot unless
 the watchdog is pinged within a certain time, this time is called the
 timeout or margin.  The simplest way to ping the watchdog is to write
 some data to the device.  So a very simple watchdog daemon would look
-like this source file:  see Documentation/watchdog/src/watchdog-simple.c
+like this source file:  see samples/watchdog/watchdog-simple.c
 
 A more advanced driver could for example check that a HTTP server is
 still responding before doing the write call to ping the watchdog.
diff --git a/samples/Makefile b/samples/Makefile
index 2e3b523..a04f62a 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
-			   configfs/ connector/ v4l/
+			   configfs/ connector/ v4l/ hpet/ prctl/ auxdisplay/ \
+			   blackfin/ pcmcia/ watchdog/
diff --git a/samples/auxdisplay/.gitignore b/samples/auxdisplay/.gitignore
new file mode 100644
index 0000000..7af2228
--- /dev/null
+++ b/samples/auxdisplay/.gitignore
@@ -0,0 +1 @@
+cfag12864b-example
diff --git a/samples/auxdisplay/Makefile b/samples/auxdisplay/Makefile
new file mode 100644
index 0000000..47912a2
--- /dev/null
+++ b/samples/auxdisplay/Makefile
@@ -0,0 +1,4 @@
+# List of programs to build
+obj-$(CONFIG_SAMPLES_AUXDISPLAY) := cfag12864b-example
+
+HOSTCFLAGS_cfag12864b-example.o += -I$(objtree)/usr/include
diff --git a/Documentation/auxdisplay/cfag12864b-example.c b/samples/auxdisplay/cfag12864b-example.c
similarity index 100%
rename from Documentation/auxdisplay/cfag12864b-example.c
rename to samples/auxdisplay/cfag12864b-example.c
diff --git a/samples/blackfin/Makefile b/samples/blackfin/Makefile
new file mode 100644
index 0000000..9190930
--- /dev/null
+++ b/samples/blackfin/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SAMPLES_BLACKFIN) := gptimers-example.o
diff --git a/Documentation/blackfin/gptimers-example.c b/samples/blackfin/gptimers-example.c
similarity index 100%
rename from Documentation/blackfin/gptimers-example.c
rename to samples/blackfin/gptimers-example.c
diff --git a/samples/hpet/.gitignore b/samples/hpet/.gitignore
new file mode 100644
index 0000000..c5c45d7
--- /dev/null
+++ b/samples/hpet/.gitignore
@@ -0,0 +1 @@
+hpet_example
diff --git a/samples/hpet/Makefile b/samples/hpet/Makefile
new file mode 100644
index 0000000..0b00476
--- /dev/null
+++ b/samples/hpet/Makefile
@@ -0,0 +1,7 @@
+# List of programs to build
+#hostprogs-$(CONFIG_X86) := hpet_example
+
+obj-$(CONFIG_SAMPLE_HPET) := hpet_example.o
+
+# Tell kbuild to always build the programs
+#always := $(hostprogs-y)
diff --git a/Documentation/timers/hpet_example.c b/samples/hpet/hpet_example.c
similarity index 100%
rename from Documentation/timers/hpet_example.c
rename to samples/hpet/hpet_example.c
diff --git a/samples/mpssd/.gitignore b/samples/mpssd/.gitignore
new file mode 100644
index 0000000..14e1679
--- /dev/null
+++ b/samples/mpssd/.gitignore
@@ -0,0 +1,3 @@
+mpssd
+mpss
+micctrl
diff --git a/Documentation/mic/mpssd/Makefile b/samples/mpssd/Makefile
similarity index 100%
rename from Documentation/mic/mpssd/Makefile
rename to samples/mpssd/Makefile
diff --git a/Documentation/mic/mpssd/mpssd.c b/samples/mpssd/mpssd.c
similarity index 100%
rename from Documentation/mic/mpssd/mpssd.c
rename to samples/mpssd/mpssd.c
diff --git a/Documentation/mic/mpssd/mpssd.h b/samples/mpssd/mpssd.h
similarity index 100%
rename from Documentation/mic/mpssd/mpssd.h
rename to samples/mpssd/mpssd.h
diff --git a/Documentation/mic/mpssd/sysfs.c b/samples/mpssd/sysfs.c
similarity index 100%
rename from Documentation/mic/mpssd/sysfs.c
rename to samples/mpssd/sysfs.c
diff --git a/samples/pcmcia/.gitignore b/samples/pcmcia/.gitignore
new file mode 100644
index 0000000..53d0813
--- /dev/null
+++ b/samples/pcmcia/.gitignore
@@ -0,0 +1 @@
+crc32hash
diff --git a/samples/pcmcia/Makefile b/samples/pcmcia/Makefile
new file mode 100644
index 0000000..992ec88
--- /dev/null
+++ b/samples/pcmcia/Makefile
@@ -0,0 +1,4 @@
+# List of programs to build
+obj-$(CONFIG_SAMPLES_PCMCIA) := crc32hash
+
+HOSTCFLAGS_crc32hash.o += -I$(objtree)/usr/include
diff --git a/Documentation/pcmcia/crc32hash.c b/samples/pcmcia/crc32hash.c
similarity index 100%
rename from Documentation/pcmcia/crc32hash.c
rename to samples/pcmcia/crc32hash.c
diff --git a/samples/prctl/.gitignore b/samples/prctl/.gitignore
new file mode 100644
index 0000000..0b5c274
--- /dev/null
+++ b/samples/prctl/.gitignore
@@ -0,0 +1,3 @@
+disable-tsc-ctxt-sw-stress-test
+disable-tsc-on-off-stress-test
+disable-tsc-test
diff --git a/Documentation/prctl/Makefile b/samples/prctl/Makefile
similarity index 53%
rename from Documentation/prctl/Makefile
rename to samples/prctl/Makefile
index 44de308..d7cb76f 100644
--- a/Documentation/prctl/Makefile
+++ b/samples/prctl/Makefile
@@ -1,8 +1,5 @@
 ifndef CROSS_COMPILE
-# List of programs to build
-hostprogs-$(CONFIG_X86) := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test disable-tsc-test
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
+obj-$(CONFIG_SAMPLES_PRCTL) := disable-tsc-ctxt-sw-stress-test.o disable-tsc-on-off-stress-test.o disable-tsc-test.o
 
 HOSTCFLAGS_disable-tsc-ctxt-sw-stress-test.o += -I$(objtree)/usr/include
 HOSTCFLAGS_disable-tsc-on-off-stress-test.o += -I$(objtree)/usr/include
diff --git a/Documentation/prctl/disable-tsc-ctxt-sw-stress-test.c b/samples/prctl/disable-tsc-ctxt-sw-stress-test.c
similarity index 100%
rename from Documentation/prctl/disable-tsc-ctxt-sw-stress-test.c
rename to samples/prctl/disable-tsc-ctxt-sw-stress-test.c
diff --git a/Documentation/prctl/disable-tsc-on-off-stress-test.c b/samples/prctl/disable-tsc-on-off-stress-test.c
similarity index 100%
rename from Documentation/prctl/disable-tsc-on-off-stress-test.c
rename to samples/prctl/disable-tsc-on-off-stress-test.c
diff --git a/Documentation/prctl/disable-tsc-test.c b/samples/prctl/disable-tsc-test.c
similarity index 100%
rename from Documentation/prctl/disable-tsc-test.c
rename to samples/prctl/disable-tsc-test.c
diff --git a/Documentation/watchdog/src/.gitignore b/samples/watchdog/.gitignore
similarity index 100%
rename from Documentation/watchdog/src/.gitignore
rename to samples/watchdog/.gitignore
diff --git a/samples/watchdog/Makefile b/samples/watchdog/Makefile
new file mode 100644
index 0000000..94f33e5
--- /dev/null
+++ b/samples/watchdog/Makefile
@@ -0,0 +1,3 @@
+# List of programs to build
+obj-$(CONFIG_SAMPLES_WATCHDOG) := watchdog-simple watchdog-test
+
diff --git a/Documentation/watchdog/src/watchdog-simple.c b/samples/watchdog/watchdog-simple.c
similarity index 100%
rename from Documentation/watchdog/src/watchdog-simple.c
rename to samples/watchdog/watchdog-simple.c
diff --git a/Documentation/watchdog/src/watchdog-test.c b/samples/watchdog/watchdog-test.c
similarity index 100%
rename from Documentation/watchdog/src/watchdog-test.c
rename to samples/watchdog/watchdog-test.c
-- 
2.7.4

