Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:38188 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752116AbcISOrw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 10:47:52 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: corbet@lwn.net, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        tomas.winkler@intel.com, tglx@linutronix.de, wim@iguana.be,
        linux@roeck-us.net, elfring@users.sourceforge.net,
        nicolas.dichtel@6wind.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, dasaratharaman.chandramouli@intel.com,
        maheshkhanwalkar@gmail.com, mikedanese@google.com,
        ben@decadent.org.uk, ghackmann@google.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 3/8] samples: move laptops example code from Documentation
Date: Mon, 19 Sep 2016 08:47:34 -0600
Message-Id: <8029dc678a811fc42a829494c1582f5bdf57f49d.1474073857.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Move laptops examples to samples and remove it from Documentation
Makefile. Create a new Makefile to build laptops. It can be built
from top level directory or from laptops directory:

Run make -C samples/laptops or cd samples/laptops; make

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 Documentation/Makefile           |   2 +-
 Documentation/laptops/.gitignore |   1 -
 Documentation/laptops/Makefile   |   5 --
 Documentation/laptops/dslm.c     | 166 ---------------------------------------
 samples/laptops/.gitignore       |   1 +
 samples/laptops/Makefile         |   9 +++
 samples/laptops/dslm.c           | 166 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 177 insertions(+), 173 deletions(-)
 delete mode 100644 Documentation/laptops/.gitignore
 delete mode 100644 Documentation/laptops/Makefile
 delete mode 100644 Documentation/laptops/dslm.c
 create mode 100644 samples/laptops/.gitignore
 create mode 100644 samples/laptops/Makefile
 create mode 100644 samples/laptops/dslm.c

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 60ec0dc..539120b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1 +1 @@
-subdir-y := blackfin laptops mic misc-devices pcmcia timers watchdog
+subdir-y := blackfin mic misc-devices pcmcia timers watchdog
diff --git a/Documentation/laptops/.gitignore b/Documentation/laptops/.gitignore
deleted file mode 100644
index 9fc984e..0000000
--- a/Documentation/laptops/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-dslm
diff --git a/Documentation/laptops/Makefile b/Documentation/laptops/Makefile
deleted file mode 100644
index 0abe44f..0000000
--- a/Documentation/laptops/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# List of programs to build
-hostprogs-y := dslm
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
diff --git a/Documentation/laptops/dslm.c b/Documentation/laptops/dslm.c
deleted file mode 100644
index d5dd2d4..0000000
--- a/Documentation/laptops/dslm.c
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- * dslm.c
- * Simple Disk Sleep Monitor
- *  by Bartek Kania
- * Licensed under the GPL
- */
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <time.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/ioctl.h>
-#include <linux/hdreg.h>
-
-#ifdef DEBUG
-#define D(x) x
-#else
-#define D(x)
-#endif
-
-int endit = 0;
-
-/* Check if the disk is in powersave-mode
- * Most of the code is stolen from hdparm.
- * 1 = active, 0 = standby/sleep, -1 = unknown */
-static int check_powermode(int fd)
-{
-    unsigned char args[4] = {WIN_CHECKPOWERMODE1,0,0,0};
-    int state;
-
-    if (ioctl(fd, HDIO_DRIVE_CMD, &args)
-	&& (args[0] = WIN_CHECKPOWERMODE2) /* try again with 0x98 */
-	&& ioctl(fd, HDIO_DRIVE_CMD, &args)) {
-	if (errno != EIO || args[0] != 0 || args[1] != 0) {
-	    state = -1; /* "unknown"; */
-	} else
-	    state = 0; /* "sleeping"; */
-    } else {
-	state = (args[2] == 255) ? 1 : 0;
-    }
-    D(printf(" drive state is:  %d\n", state));
-
-    return state;
-}
-
-static char *state_name(int i)
-{
-    if (i == -1) return "unknown";
-    if (i == 0) return "sleeping";
-    if (i == 1) return "active";
-
-    return "internal error";
-}
-
-static char *myctime(time_t time)
-{
-    char *ts = ctime(&time);
-    ts[strlen(ts) - 1] = 0;
-
-    return ts;
-}
-
-static void measure(int fd)
-{
-    time_t start_time;
-    int last_state;
-    time_t last_time;
-    int curr_state;
-    time_t curr_time = 0;
-    time_t time_diff;
-    time_t active_time = 0;
-    time_t sleep_time = 0;
-    time_t unknown_time = 0;
-    time_t total_time = 0;
-    int changes = 0;
-    float tmp;
-
-    printf("Starting measurements\n");
-
-    last_state = check_powermode(fd);
-    start_time = last_time = time(0);
-    printf("  System is in state %s\n\n", state_name(last_state));
-
-    while(!endit) {
-	sleep(1);
-	curr_state = check_powermode(fd);
-
-	if (curr_state != last_state || endit) {
-	    changes++;
-	    curr_time = time(0);
-	    time_diff = curr_time - last_time;
-
-	    if (last_state == 1) active_time += time_diff;
-	    else if (last_state == 0) sleep_time += time_diff;
-	    else unknown_time += time_diff;
-
-	    last_state = curr_state;
-	    last_time = curr_time;
-
-	    printf("%s: State-change to %s\n", myctime(curr_time),
-		   state_name(curr_state));
-	}
-    }
-    changes--; /* Compensate for SIGINT */
-
-    total_time = time(0) - start_time;
-    printf("\nTotal running time:  %lus\n", curr_time - start_time);
-    printf(" State changed %d times\n", changes);
-
-    tmp = (float)sleep_time / (float)total_time * 100;
-    printf(" Time in sleep state:   %lus (%.2f%%)\n", sleep_time, tmp);
-    tmp = (float)active_time / (float)total_time * 100;
-    printf(" Time in active state:  %lus (%.2f%%)\n", active_time, tmp);
-    tmp = (float)unknown_time / (float)total_time * 100;
-    printf(" Time in unknown state: %lus (%.2f%%)\n", unknown_time, tmp);
-}
-
-static void ender(int s)
-{
-    endit = 1;
-}
-
-static void usage(void)
-{
-    puts("usage: dslm [-w <time>] <disk>");
-    exit(0);
-}
-
-int main(int argc, char **argv)
-{
-    int fd;
-    char *disk = 0;
-    int settle_time = 60;
-
-    /* Parse the simple command-line */
-    if (argc == 2)
-	disk = argv[1];
-    else if (argc == 4) {
-	settle_time = atoi(argv[2]);
-	disk = argv[3];
-    } else
-	usage();
-
-    if (!(fd = open(disk, O_RDONLY|O_NONBLOCK))) {
-	printf("Can't open %s, because: %s\n", disk, strerror(errno));
-	exit(-1);
-    }
-
-    if (settle_time) {
-	printf("Waiting %d seconds for the system to settle down to "
-	       "'normal'\n", settle_time);
-	sleep(settle_time);
-    } else
-	puts("Not waiting for system to settle down");
-
-    signal(SIGINT, ender);
-
-    measure(fd);
-
-    close(fd);
-
-    return 0;
-}
diff --git a/samples/laptops/.gitignore b/samples/laptops/.gitignore
new file mode 100644
index 0000000..9fc984e
--- /dev/null
+++ b/samples/laptops/.gitignore
@@ -0,0 +1 @@
+dslm
diff --git a/samples/laptops/Makefile b/samples/laptops/Makefile
new file mode 100644
index 0000000..ff613b3
--- /dev/null
+++ b/samples/laptops/Makefile
@@ -0,0 +1,9 @@
+CC := $(CROSS_COMPILE)gcc
+CFLAGS := -I../../usr/include
+
+PROGS := dslm
+
+all: $(PROGS)
+
+clean:
+	rm -fr $(PROGS)
diff --git a/samples/laptops/dslm.c b/samples/laptops/dslm.c
new file mode 100644
index 0000000..d5dd2d4
--- /dev/null
+++ b/samples/laptops/dslm.c
@@ -0,0 +1,166 @@
+/*
+ * dslm.c
+ * Simple Disk Sleep Monitor
+ *  by Bartek Kania
+ * Licensed under the GPL
+ */
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <time.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <linux/hdreg.h>
+
+#ifdef DEBUG
+#define D(x) x
+#else
+#define D(x)
+#endif
+
+int endit = 0;
+
+/* Check if the disk is in powersave-mode
+ * Most of the code is stolen from hdparm.
+ * 1 = active, 0 = standby/sleep, -1 = unknown */
+static int check_powermode(int fd)
+{
+    unsigned char args[4] = {WIN_CHECKPOWERMODE1,0,0,0};
+    int state;
+
+    if (ioctl(fd, HDIO_DRIVE_CMD, &args)
+	&& (args[0] = WIN_CHECKPOWERMODE2) /* try again with 0x98 */
+	&& ioctl(fd, HDIO_DRIVE_CMD, &args)) {
+	if (errno != EIO || args[0] != 0 || args[1] != 0) {
+	    state = -1; /* "unknown"; */
+	} else
+	    state = 0; /* "sleeping"; */
+    } else {
+	state = (args[2] == 255) ? 1 : 0;
+    }
+    D(printf(" drive state is:  %d\n", state));
+
+    return state;
+}
+
+static char *state_name(int i)
+{
+    if (i == -1) return "unknown";
+    if (i == 0) return "sleeping";
+    if (i == 1) return "active";
+
+    return "internal error";
+}
+
+static char *myctime(time_t time)
+{
+    char *ts = ctime(&time);
+    ts[strlen(ts) - 1] = 0;
+
+    return ts;
+}
+
+static void measure(int fd)
+{
+    time_t start_time;
+    int last_state;
+    time_t last_time;
+    int curr_state;
+    time_t curr_time = 0;
+    time_t time_diff;
+    time_t active_time = 0;
+    time_t sleep_time = 0;
+    time_t unknown_time = 0;
+    time_t total_time = 0;
+    int changes = 0;
+    float tmp;
+
+    printf("Starting measurements\n");
+
+    last_state = check_powermode(fd);
+    start_time = last_time = time(0);
+    printf("  System is in state %s\n\n", state_name(last_state));
+
+    while(!endit) {
+	sleep(1);
+	curr_state = check_powermode(fd);
+
+	if (curr_state != last_state || endit) {
+	    changes++;
+	    curr_time = time(0);
+	    time_diff = curr_time - last_time;
+
+	    if (last_state == 1) active_time += time_diff;
+	    else if (last_state == 0) sleep_time += time_diff;
+	    else unknown_time += time_diff;
+
+	    last_state = curr_state;
+	    last_time = curr_time;
+
+	    printf("%s: State-change to %s\n", myctime(curr_time),
+		   state_name(curr_state));
+	}
+    }
+    changes--; /* Compensate for SIGINT */
+
+    total_time = time(0) - start_time;
+    printf("\nTotal running time:  %lus\n", curr_time - start_time);
+    printf(" State changed %d times\n", changes);
+
+    tmp = (float)sleep_time / (float)total_time * 100;
+    printf(" Time in sleep state:   %lus (%.2f%%)\n", sleep_time, tmp);
+    tmp = (float)active_time / (float)total_time * 100;
+    printf(" Time in active state:  %lus (%.2f%%)\n", active_time, tmp);
+    tmp = (float)unknown_time / (float)total_time * 100;
+    printf(" Time in unknown state: %lus (%.2f%%)\n", unknown_time, tmp);
+}
+
+static void ender(int s)
+{
+    endit = 1;
+}
+
+static void usage(void)
+{
+    puts("usage: dslm [-w <time>] <disk>");
+    exit(0);
+}
+
+int main(int argc, char **argv)
+{
+    int fd;
+    char *disk = 0;
+    int settle_time = 60;
+
+    /* Parse the simple command-line */
+    if (argc == 2)
+	disk = argv[1];
+    else if (argc == 4) {
+	settle_time = atoi(argv[2]);
+	disk = argv[3];
+    } else
+	usage();
+
+    if (!(fd = open(disk, O_RDONLY|O_NONBLOCK))) {
+	printf("Can't open %s, because: %s\n", disk, strerror(errno));
+	exit(-1);
+    }
+
+    if (settle_time) {
+	printf("Waiting %d seconds for the system to settle down to "
+	       "'normal'\n", settle_time);
+	sleep(settle_time);
+    } else
+	puts("Not waiting for system to settle down");
+
+    signal(SIGINT, ender);
+
+    measure(fd);
+
+    close(fd);
+
+    return 0;
+}
-- 
2.7.4

