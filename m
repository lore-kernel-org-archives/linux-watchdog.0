Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:41104 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S941132AbcIUTrk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Sep 2016 15:47:40 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: corbet@lwn.net, tomas.winkler@intel.com, tglx@linutronix.de,
        clemens@ladisch.de, wim@iguana.be, linux@roeck-us.net,
        davem@davemloft.net, geert@linux-m68k.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kvalo@codeaurora.org, mchehab@kernel.org, ghackmann@google.com,
        ben@decadent.org.uk, maheshkhanwalkar@gmail.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 2/4] samples: move timers example code from Documentation
Date: Wed, 21 Sep 2016 13:47:31 -0600
Message-Id: <27dc99a87dda188924ed3f69ff1c15d445e47f9a.1474485474.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474485474.git.shuahkh@osg.samsung.com>
References: <cover.1474485474.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474485474.git.shuahkh@osg.samsung.com>
References: <cover.1474485474.git.shuahkh@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Move timers examples to samples and remove it from Documentation
Makefile. Create a new Makefile to build timers. It can be built
from top level directory or from timers directory:

Run make -C samples/timers or cd samples/timers; make

Acked-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 Documentation/Makefile              |   2 +-
 Documentation/timers/.gitignore     |   1 -
 Documentation/timers/Makefile       |   5 -
 Documentation/timers/hpet.txt       |   2 +-
 Documentation/timers/hpet_example.c | 294 ------------------------------------
 samples/timers/.gitignore           |   1 +
 samples/timers/Makefile             |  15 ++
 samples/timers/hpet_example.c       | 294 ++++++++++++++++++++++++++++++++++++
 8 files changed, 312 insertions(+), 302 deletions(-)
 delete mode 100644 Documentation/timers/.gitignore
 delete mode 100644 Documentation/timers/Makefile
 delete mode 100644 Documentation/timers/hpet_example.c
 create mode 100644 samples/timers/.gitignore
 create mode 100644 samples/timers/Makefile
 create mode 100644 samples/timers/hpet_example.c

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3c2a207..fc386b7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,2 +1,2 @@
 subdir-y := accounting auxdisplay blackfin \
-	laptops pcmcia timers watchdog
+	laptops pcmcia watchdog
diff --git a/Documentation/timers/.gitignore b/Documentation/timers/.gitignore
deleted file mode 100644
index c5c45d7..0000000
--- a/Documentation/timers/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-hpet_example
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
index a484d2c..895345e 100644
--- a/Documentation/timers/hpet.txt
+++ b/Documentation/timers/hpet.txt
@@ -25,4 +25,4 @@ arch/x86/kernel/hpet.c.
 
 The driver provides a userspace API which resembles the API found in the
 RTC driver framework.  An example user space program is provided in
-file:Documentation/timers/hpet_example.c
+file:samples/timers/hpet_example.c
diff --git a/Documentation/timers/hpet_example.c b/Documentation/timers/hpet_example.c
deleted file mode 100644
index 3ab4993..0000000
--- a/Documentation/timers/hpet_example.c
+++ /dev/null
@@ -1,294 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <memory.h>
-#include <malloc.h>
-#include <time.h>
-#include <ctype.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <signal.h>
-#include <errno.h>
-#include <sys/time.h>
-#include <linux/hpet.h>
-
-
-extern void hpet_open_close(int, const char **);
-extern void hpet_info(int, const char **);
-extern void hpet_poll(int, const char **);
-extern void hpet_fasync(int, const char **);
-extern void hpet_read(int, const char **);
-
-#include <sys/poll.h>
-#include <sys/ioctl.h>
-
-struct hpet_command {
-	char		*command;
-	void		(*func)(int argc, const char ** argv);
-} hpet_command[] = {
-	{
-		"open-close",
-		hpet_open_close
-	},
-	{
-		"info",
-		hpet_info
-	},
-	{
-		"poll",
-		hpet_poll
-	},
-	{
-		"fasync",
-		hpet_fasync
-	},
-};
-
-int
-main(int argc, const char ** argv)
-{
-	unsigned int	i;
-
-	argc--;
-	argv++;
-
-	if (!argc) {
-		fprintf(stderr, "-hpet: requires command\n");
-		return -1;
-	}
-
-
-	for (i = 0; i < (sizeof (hpet_command) / sizeof (hpet_command[0])); i++)
-		if (!strcmp(argv[0], hpet_command[i].command)) {
-			argc--;
-			argv++;
-			fprintf(stderr, "-hpet: executing %s\n",
-				hpet_command[i].command);
-			hpet_command[i].func(argc, argv);
-			return 0;
-		}
-
-	fprintf(stderr, "do_hpet: command %s not implemented\n", argv[0]);
-
-	return -1;
-}
-
-void
-hpet_open_close(int argc, const char **argv)
-{
-	int	fd;
-
-	if (argc != 1) {
-		fprintf(stderr, "hpet_open_close: device-name\n");
-		return;
-	}
-
-	fd = open(argv[0], O_RDONLY);
-	if (fd < 0)
-		fprintf(stderr, "hpet_open_close: open failed\n");
-	else
-		close(fd);
-
-	return;
-}
-
-void
-hpet_info(int argc, const char **argv)
-{
-	struct hpet_info	info;
-	int			fd;
-
-	if (argc != 1) {
-		fprintf(stderr, "hpet_info: device-name\n");
-		return;
-	}
-
-	fd = open(argv[0], O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "hpet_info: open of %s failed\n", argv[0]);
-		return;
-	}
-
-	if (ioctl(fd, HPET_INFO, &info) < 0) {
-		fprintf(stderr, "hpet_info: failed to get info\n");
-		goto out;
-	}
-
-	fprintf(stderr, "hpet_info: hi_irqfreq 0x%lx hi_flags 0x%lx ",
-		info.hi_ireqfreq, info.hi_flags);
-	fprintf(stderr, "hi_hpet %d hi_timer %d\n",
-		info.hi_hpet, info.hi_timer);
-
-out:
-	close(fd);
-	return;
-}
-
-void
-hpet_poll(int argc, const char **argv)
-{
-	unsigned long		freq;
-	int			iterations, i, fd;
-	struct pollfd		pfd;
-	struct hpet_info	info;
-	struct timeval		stv, etv;
-	struct timezone		tz;
-	long			usec;
-
-	if (argc != 3) {
-		fprintf(stderr, "hpet_poll: device-name freq iterations\n");
-		return;
-	}
-
-	freq = atoi(argv[1]);
-	iterations = atoi(argv[2]);
-
-	fd = open(argv[0], O_RDONLY);
-
-	if (fd < 0) {
-		fprintf(stderr, "hpet_poll: open of %s failed\n", argv[0]);
-		return;
-	}
-
-	if (ioctl(fd, HPET_IRQFREQ, freq) < 0) {
-		fprintf(stderr, "hpet_poll: HPET_IRQFREQ failed\n");
-		goto out;
-	}
-
-	if (ioctl(fd, HPET_INFO, &info) < 0) {
-		fprintf(stderr, "hpet_poll: failed to get info\n");
-		goto out;
-	}
-
-	fprintf(stderr, "hpet_poll: info.hi_flags 0x%lx\n", info.hi_flags);
-
-	if (info.hi_flags && (ioctl(fd, HPET_EPI, 0) < 0)) {
-		fprintf(stderr, "hpet_poll: HPET_EPI failed\n");
-		goto out;
-	}
-
-	if (ioctl(fd, HPET_IE_ON, 0) < 0) {
-		fprintf(stderr, "hpet_poll, HPET_IE_ON failed\n");
-		goto out;
-	}
-
-	pfd.fd = fd;
-	pfd.events = POLLIN;
-
-	for (i = 0; i < iterations; i++) {
-		pfd.revents = 0;
-		gettimeofday(&stv, &tz);
-		if (poll(&pfd, 1, -1) < 0)
-			fprintf(stderr, "hpet_poll: poll failed\n");
-		else {
-			long 	data;
-
-			gettimeofday(&etv, &tz);
-			usec = stv.tv_sec * 1000000 + stv.tv_usec;
-			usec = (etv.tv_sec * 1000000 + etv.tv_usec) - usec;
-
-			fprintf(stderr,
-				"hpet_poll: expired time = 0x%lx\n", usec);
-
-			fprintf(stderr, "hpet_poll: revents = 0x%x\n",
-				pfd.revents);
-
-			if (read(fd, &data, sizeof(data)) != sizeof(data)) {
-				fprintf(stderr, "hpet_poll: read failed\n");
-			}
-			else
-				fprintf(stderr, "hpet_poll: data 0x%lx\n",
-					data);
-		}
-	}
-
-out:
-	close(fd);
-	return;
-}
-
-static int hpet_sigio_count;
-
-static void
-hpet_sigio(int val)
-{
-	fprintf(stderr, "hpet_sigio: called\n");
-	hpet_sigio_count++;
-}
-
-void
-hpet_fasync(int argc, const char **argv)
-{
-	unsigned long		freq;
-	int			iterations, i, fd, value;
-	sig_t			oldsig;
-	struct hpet_info	info;
-
-	hpet_sigio_count = 0;
-	fd = -1;
-
-	if ((oldsig = signal(SIGIO, hpet_sigio)) == SIG_ERR) {
-		fprintf(stderr, "hpet_fasync: failed to set signal handler\n");
-		return;
-	}
-
-	if (argc != 3) {
-		fprintf(stderr, "hpet_fasync: device-name freq iterations\n");
-		goto out;
-	}
-
-	fd = open(argv[0], O_RDONLY);
-
-	if (fd < 0) {
-		fprintf(stderr, "hpet_fasync: failed to open %s\n", argv[0]);
-		return;
-	}
-
-
-	if ((fcntl(fd, F_SETOWN, getpid()) == 1) ||
-		((value = fcntl(fd, F_GETFL)) == 1) ||
-		(fcntl(fd, F_SETFL, value | O_ASYNC) == 1)) {
-		fprintf(stderr, "hpet_fasync: fcntl failed\n");
-		goto out;
-	}
-
-	freq = atoi(argv[1]);
-	iterations = atoi(argv[2]);
-
-	if (ioctl(fd, HPET_IRQFREQ, freq) < 0) {
-		fprintf(stderr, "hpet_fasync: HPET_IRQFREQ failed\n");
-		goto out;
-	}
-
-	if (ioctl(fd, HPET_INFO, &info) < 0) {
-		fprintf(stderr, "hpet_fasync: failed to get info\n");
-		goto out;
-	}
-
-	fprintf(stderr, "hpet_fasync: info.hi_flags 0x%lx\n", info.hi_flags);
-
-	if (info.hi_flags && (ioctl(fd, HPET_EPI, 0) < 0)) {
-		fprintf(stderr, "hpet_fasync: HPET_EPI failed\n");
-		goto out;
-	}
-
-	if (ioctl(fd, HPET_IE_ON, 0) < 0) {
-		fprintf(stderr, "hpet_fasync, HPET_IE_ON failed\n");
-		goto out;
-	}
-
-	for (i = 0; i < iterations; i++) {
-		(void) pause();
-		fprintf(stderr, "hpet_fasync: count = %d\n", hpet_sigio_count);
-	}
-
-out:
-	signal(SIGIO, oldsig);
-
-	if (fd >= 0)
-		close(fd);
-
-	return;
-}
diff --git a/samples/timers/.gitignore b/samples/timers/.gitignore
new file mode 100644
index 0000000..c5c45d7
--- /dev/null
+++ b/samples/timers/.gitignore
@@ -0,0 +1 @@
+hpet_example
diff --git a/samples/timers/Makefile b/samples/timers/Makefile
new file mode 100644
index 0000000..a5c3c4a
--- /dev/null
+++ b/samples/timers/Makefile
@@ -0,0 +1,15 @@
+ifndef CROSS_COMPILE
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq ($(ARCH),x86)
+CC := $(CROSS_COMPILE)gcc
+PROGS := hpet_example
+
+all: $(PROGS)
+
+clean:
+	rm -fr $(PROGS)
+
+endif
+endif
diff --git a/samples/timers/hpet_example.c b/samples/timers/hpet_example.c
new file mode 100644
index 0000000..3ab4993
--- /dev/null
+++ b/samples/timers/hpet_example.c
@@ -0,0 +1,294 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <memory.h>
+#include <malloc.h>
+#include <time.h>
+#include <ctype.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <linux/hpet.h>
+
+
+extern void hpet_open_close(int, const char **);
+extern void hpet_info(int, const char **);
+extern void hpet_poll(int, const char **);
+extern void hpet_fasync(int, const char **);
+extern void hpet_read(int, const char **);
+
+#include <sys/poll.h>
+#include <sys/ioctl.h>
+
+struct hpet_command {
+	char		*command;
+	void		(*func)(int argc, const char ** argv);
+} hpet_command[] = {
+	{
+		"open-close",
+		hpet_open_close
+	},
+	{
+		"info",
+		hpet_info
+	},
+	{
+		"poll",
+		hpet_poll
+	},
+	{
+		"fasync",
+		hpet_fasync
+	},
+};
+
+int
+main(int argc, const char ** argv)
+{
+	unsigned int	i;
+
+	argc--;
+	argv++;
+
+	if (!argc) {
+		fprintf(stderr, "-hpet: requires command\n");
+		return -1;
+	}
+
+
+	for (i = 0; i < (sizeof (hpet_command) / sizeof (hpet_command[0])); i++)
+		if (!strcmp(argv[0], hpet_command[i].command)) {
+			argc--;
+			argv++;
+			fprintf(stderr, "-hpet: executing %s\n",
+				hpet_command[i].command);
+			hpet_command[i].func(argc, argv);
+			return 0;
+		}
+
+	fprintf(stderr, "do_hpet: command %s not implemented\n", argv[0]);
+
+	return -1;
+}
+
+void
+hpet_open_close(int argc, const char **argv)
+{
+	int	fd;
+
+	if (argc != 1) {
+		fprintf(stderr, "hpet_open_close: device-name\n");
+		return;
+	}
+
+	fd = open(argv[0], O_RDONLY);
+	if (fd < 0)
+		fprintf(stderr, "hpet_open_close: open failed\n");
+	else
+		close(fd);
+
+	return;
+}
+
+void
+hpet_info(int argc, const char **argv)
+{
+	struct hpet_info	info;
+	int			fd;
+
+	if (argc != 1) {
+		fprintf(stderr, "hpet_info: device-name\n");
+		return;
+	}
+
+	fd = open(argv[0], O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "hpet_info: open of %s failed\n", argv[0]);
+		return;
+	}
+
+	if (ioctl(fd, HPET_INFO, &info) < 0) {
+		fprintf(stderr, "hpet_info: failed to get info\n");
+		goto out;
+	}
+
+	fprintf(stderr, "hpet_info: hi_irqfreq 0x%lx hi_flags 0x%lx ",
+		info.hi_ireqfreq, info.hi_flags);
+	fprintf(stderr, "hi_hpet %d hi_timer %d\n",
+		info.hi_hpet, info.hi_timer);
+
+out:
+	close(fd);
+	return;
+}
+
+void
+hpet_poll(int argc, const char **argv)
+{
+	unsigned long		freq;
+	int			iterations, i, fd;
+	struct pollfd		pfd;
+	struct hpet_info	info;
+	struct timeval		stv, etv;
+	struct timezone		tz;
+	long			usec;
+
+	if (argc != 3) {
+		fprintf(stderr, "hpet_poll: device-name freq iterations\n");
+		return;
+	}
+
+	freq = atoi(argv[1]);
+	iterations = atoi(argv[2]);
+
+	fd = open(argv[0], O_RDONLY);
+
+	if (fd < 0) {
+		fprintf(stderr, "hpet_poll: open of %s failed\n", argv[0]);
+		return;
+	}
+
+	if (ioctl(fd, HPET_IRQFREQ, freq) < 0) {
+		fprintf(stderr, "hpet_poll: HPET_IRQFREQ failed\n");
+		goto out;
+	}
+
+	if (ioctl(fd, HPET_INFO, &info) < 0) {
+		fprintf(stderr, "hpet_poll: failed to get info\n");
+		goto out;
+	}
+
+	fprintf(stderr, "hpet_poll: info.hi_flags 0x%lx\n", info.hi_flags);
+
+	if (info.hi_flags && (ioctl(fd, HPET_EPI, 0) < 0)) {
+		fprintf(stderr, "hpet_poll: HPET_EPI failed\n");
+		goto out;
+	}
+
+	if (ioctl(fd, HPET_IE_ON, 0) < 0) {
+		fprintf(stderr, "hpet_poll, HPET_IE_ON failed\n");
+		goto out;
+	}
+
+	pfd.fd = fd;
+	pfd.events = POLLIN;
+
+	for (i = 0; i < iterations; i++) {
+		pfd.revents = 0;
+		gettimeofday(&stv, &tz);
+		if (poll(&pfd, 1, -1) < 0)
+			fprintf(stderr, "hpet_poll: poll failed\n");
+		else {
+			long 	data;
+
+			gettimeofday(&etv, &tz);
+			usec = stv.tv_sec * 1000000 + stv.tv_usec;
+			usec = (etv.tv_sec * 1000000 + etv.tv_usec) - usec;
+
+			fprintf(stderr,
+				"hpet_poll: expired time = 0x%lx\n", usec);
+
+			fprintf(stderr, "hpet_poll: revents = 0x%x\n",
+				pfd.revents);
+
+			if (read(fd, &data, sizeof(data)) != sizeof(data)) {
+				fprintf(stderr, "hpet_poll: read failed\n");
+			}
+			else
+				fprintf(stderr, "hpet_poll: data 0x%lx\n",
+					data);
+		}
+	}
+
+out:
+	close(fd);
+	return;
+}
+
+static int hpet_sigio_count;
+
+static void
+hpet_sigio(int val)
+{
+	fprintf(stderr, "hpet_sigio: called\n");
+	hpet_sigio_count++;
+}
+
+void
+hpet_fasync(int argc, const char **argv)
+{
+	unsigned long		freq;
+	int			iterations, i, fd, value;
+	sig_t			oldsig;
+	struct hpet_info	info;
+
+	hpet_sigio_count = 0;
+	fd = -1;
+
+	if ((oldsig = signal(SIGIO, hpet_sigio)) == SIG_ERR) {
+		fprintf(stderr, "hpet_fasync: failed to set signal handler\n");
+		return;
+	}
+
+	if (argc != 3) {
+		fprintf(stderr, "hpet_fasync: device-name freq iterations\n");
+		goto out;
+	}
+
+	fd = open(argv[0], O_RDONLY);
+
+	if (fd < 0) {
+		fprintf(stderr, "hpet_fasync: failed to open %s\n", argv[0]);
+		return;
+	}
+
+
+	if ((fcntl(fd, F_SETOWN, getpid()) == 1) ||
+		((value = fcntl(fd, F_GETFL)) == 1) ||
+		(fcntl(fd, F_SETFL, value | O_ASYNC) == 1)) {
+		fprintf(stderr, "hpet_fasync: fcntl failed\n");
+		goto out;
+	}
+
+	freq = atoi(argv[1]);
+	iterations = atoi(argv[2]);
+
+	if (ioctl(fd, HPET_IRQFREQ, freq) < 0) {
+		fprintf(stderr, "hpet_fasync: HPET_IRQFREQ failed\n");
+		goto out;
+	}
+
+	if (ioctl(fd, HPET_INFO, &info) < 0) {
+		fprintf(stderr, "hpet_fasync: failed to get info\n");
+		goto out;
+	}
+
+	fprintf(stderr, "hpet_fasync: info.hi_flags 0x%lx\n", info.hi_flags);
+
+	if (info.hi_flags && (ioctl(fd, HPET_EPI, 0) < 0)) {
+		fprintf(stderr, "hpet_fasync: HPET_EPI failed\n");
+		goto out;
+	}
+
+	if (ioctl(fd, HPET_IE_ON, 0) < 0) {
+		fprintf(stderr, "hpet_fasync, HPET_IE_ON failed\n");
+		goto out;
+	}
+
+	for (i = 0; i < iterations; i++) {
+		(void) pause();
+		fprintf(stderr, "hpet_fasync: count = %d\n", hpet_sigio_count);
+	}
+
+out:
+	signal(SIGIO, oldsig);
+
+	if (fd >= 0)
+		close(fd);
+
+	return;
+}
-- 
2.7.4

