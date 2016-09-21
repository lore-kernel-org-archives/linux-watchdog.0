Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:42855 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S941144AbcIUTrn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Sep 2016 15:47:43 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: corbet@lwn.net, tomas.winkler@intel.com, tglx@linutronix.de,
        clemens@ladisch.de, wim@iguana.be, linux@roeck-us.net,
        davem@davemloft.net, geert@linux-m68k.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kvalo@codeaurora.org, mchehab@kernel.org, ghackmann@google.com,
        ben@decadent.org.uk, maheshkhanwalkar@gmail.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 3/4] samples: move watchdog example code from Documentation
Date: Wed, 21 Sep 2016 13:47:32 -0600
Message-Id: <d445156ba97dff44a1c32c7bbbf1978c3b9eac0c.1474485474.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474485474.git.shuahkh@osg.samsung.com>
References: <cover.1474485474.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474485474.git.shuahkh@osg.samsung.com>
References: <cover.1474485474.git.shuahkh@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Move watchdog examples to samples and remove it from Documentation
Makefile. Create a new Makefile to build watchdog. It can be built
from top level directory or from watchdog directory:

Run make -C samples/watchdog or cd samples/watchdog; make

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 Documentation/Makefile                       |  2 +-
 Documentation/watchdog/Makefile              |  1 -
 Documentation/watchdog/src/.gitignore        |  1 -
 Documentation/watchdog/src/Makefile          |  5 -----
 Documentation/watchdog/src/watchdog-simple.c | 24 ------------------------
 Documentation/watchdog/watchdog-api.txt      |  2 +-
 Documentation/watchdog/wdt.txt               |  2 +-
 samples/watchdog/.gitignore                  |  1 +
 samples/watchdog/Makefile                    |  8 ++++++++
 samples/watchdog/watchdog-simple.c           | 24 ++++++++++++++++++++++++
 10 files changed, 36 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/watchdog/Makefile
 delete mode 100644 Documentation/watchdog/src/.gitignore
 delete mode 100644 Documentation/watchdog/src/Makefile
 delete mode 100644 Documentation/watchdog/src/watchdog-simple.c
 create mode 100644 samples/watchdog/.gitignore
 create mode 100644 samples/watchdog/Makefile
 create mode 100644 samples/watchdog/watchdog-simple.c

diff --git a/Documentation/Makefile b/Documentation/Makefile
index fc386b7..b2210b7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,2 +1,2 @@
 subdir-y := accounting auxdisplay blackfin \
-	laptops pcmcia watchdog
+	laptops pcmcia
diff --git a/Documentation/watchdog/Makefile b/Documentation/watchdog/Makefile
deleted file mode 100644
index 6018f45..0000000
--- a/Documentation/watchdog/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-subdir-y := src
diff --git a/Documentation/watchdog/src/.gitignore b/Documentation/watchdog/src/.gitignore
deleted file mode 100644
index ff0ebb5..0000000
--- a/Documentation/watchdog/src/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-watchdog-simple
diff --git a/Documentation/watchdog/src/Makefile b/Documentation/watchdog/src/Makefile
deleted file mode 100644
index 47be791..0000000
--- a/Documentation/watchdog/src/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# List of programs to build
-hostprogs-y := watchdog-simple
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
diff --git a/Documentation/watchdog/src/watchdog-simple.c b/Documentation/watchdog/src/watchdog-simple.c
deleted file mode 100644
index ba45803..0000000
--- a/Documentation/watchdog/src/watchdog-simple.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-
-int main(void)
-{
-	int fd = open("/dev/watchdog", O_WRONLY);
-	int ret = 0;
-	if (fd == -1) {
-		perror("watchdog");
-		exit(EXIT_FAILURE);
-	}
-	while (1) {
-		ret = write(fd, "\0", 1);
-		if (ret != 1) {
-			ret = -1;
-			break;
-		}
-		sleep(10);
-	}
-	close(fd);
-	return ret;
-}
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
diff --git a/Documentation/watchdog/wdt.txt b/Documentation/watchdog/wdt.txt
index 061c2e3..ed2f0b8 100644
--- a/Documentation/watchdog/wdt.txt
+++ b/Documentation/watchdog/wdt.txt
@@ -47,4 +47,4 @@ The external event interfaces on the WDT boards are not currently supported.
 Minor numbers are however allocated for it.
 
 
-Example Watchdog Driver:  see Documentation/watchdog/src/watchdog-simple.c
+Example Watchdog Driver:  see samples/watchdog/watchdog-simple.c
diff --git a/samples/watchdog/.gitignore b/samples/watchdog/.gitignore
new file mode 100644
index 0000000..ff0ebb5
--- /dev/null
+++ b/samples/watchdog/.gitignore
@@ -0,0 +1 @@
+watchdog-simple
diff --git a/samples/watchdog/Makefile b/samples/watchdog/Makefile
new file mode 100644
index 0000000..9b53d89
--- /dev/null
+++ b/samples/watchdog/Makefile
@@ -0,0 +1,8 @@
+CC := $(CROSS_COMPILE)gcc
+PROGS := watchdog-simple
+
+all: $(PROGS)
+
+clean:
+	rm -fr $(PROGS)
+
diff --git a/samples/watchdog/watchdog-simple.c b/samples/watchdog/watchdog-simple.c
new file mode 100644
index 0000000..ba45803
--- /dev/null
+++ b/samples/watchdog/watchdog-simple.c
@@ -0,0 +1,24 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+int main(void)
+{
+	int fd = open("/dev/watchdog", O_WRONLY);
+	int ret = 0;
+	if (fd == -1) {
+		perror("watchdog");
+		exit(EXIT_FAILURE);
+	}
+	while (1) {
+		ret = write(fd, "\0", 1);
+		if (ret != 1) {
+			ret = -1;
+			break;
+		}
+		sleep(10);
+	}
+	close(fd);
+	return ret;
+}
-- 
2.7.4

