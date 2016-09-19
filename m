Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:52075 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932133AbcISOrz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 10:47:55 -0400
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
Subject: [PATCH 8/8] samples: move watchdog example code from Documentation
Date: Mon, 19 Sep 2016 08:47:39 -0600
Message-Id: <7ef50ee89118078d35187a6dd0c66207875e0ea6.1474073857.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
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
 samples/watchdog/.gitignore                  |  1 +
 samples/watchdog/Makefile                    |  8 ++++++++
 samples/watchdog/watchdog-simple.c           | 24 ++++++++++++++++++++++++
 8 files changed, 34 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/watchdog/Makefile
 delete mode 100644 Documentation/watchdog/src/.gitignore
 delete mode 100644 Documentation/watchdog/src/Makefile
 delete mode 100644 Documentation/watchdog/src/watchdog-simple.c
 create mode 100644 samples/watchdog/.gitignore
 create mode 100644 samples/watchdog/Makefile
 create mode 100644 samples/watchdog/watchdog-simple.c

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9c3fe11..8435965 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1 +1 @@
-subdir-y := blackfin watchdog
+subdir-y := blackfin
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

