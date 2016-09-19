Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:41903 "EHLO
        resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752168AbcISOry (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 10:47:54 -0400
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
Subject: [PATCH 6/8] samples: move pcmcia example code from Documentation
Date: Mon, 19 Sep 2016 08:47:37 -0600
Message-Id: <2a7ba074ee6bba6d3f7b049dd993e4bf4ecb6544.1474073857.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Move pcmcia examples to samples and remove it from Documentation
Makefile. Create a new Makefile to build pcmcia. It can be built
from top level directory or from pcmcia directory:

Run make -C samples/pcmcia or cd samples/pcmcia; make

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 Documentation/Makefile           |  2 +-
 Documentation/pcmcia/.gitignore  |  1 -
 Documentation/pcmcia/Makefile    |  7 -------
 Documentation/pcmcia/crc32hash.c | 32 --------------------------------
 samples/pcmcia/.gitignore        |  1 +
 samples/pcmcia/Makefile          |  9 +++++++++
 samples/pcmcia/crc32hash.c       | 32 ++++++++++++++++++++++++++++++++
 7 files changed, 43 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/pcmcia/.gitignore
 delete mode 100644 Documentation/pcmcia/Makefile
 delete mode 100644 Documentation/pcmcia/crc32hash.c
 create mode 100644 samples/pcmcia/.gitignore
 create mode 100644 samples/pcmcia/Makefile
 create mode 100644 samples/pcmcia/crc32hash.c

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ac7d68f..bd5f115 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1 +1 @@
-subdir-y := blackfin pcmcia timers watchdog
+subdir-y := blackfin timers watchdog
diff --git a/Documentation/pcmcia/.gitignore b/Documentation/pcmcia/.gitignore
deleted file mode 100644
index 53d0813..0000000
--- a/Documentation/pcmcia/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-crc32hash
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
diff --git a/Documentation/pcmcia/crc32hash.c b/Documentation/pcmcia/crc32hash.c
deleted file mode 100644
index 44f8bee..0000000
--- a/Documentation/pcmcia/crc32hash.c
+++ /dev/null
@@ -1,32 +0,0 @@
-/* crc32hash.c - derived from linux/lib/crc32.c, GNU GPL v2 */
-/* Usage example:
-$ ./crc32hash "Dual Speed"
-*/
-
-#include <string.h>
-#include <stdio.h>
-#include <ctype.h>
-#include <stdlib.h>
-
-static unsigned int crc32(unsigned char const *p, unsigned int len)
-{
-	int i;
-	unsigned int crc = 0;
-	while (len--) {
-		crc ^= *p++;
-		for (i = 0; i < 8; i++)
-			crc = (crc >> 1) ^ ((crc & 1) ? 0xedb88320 : 0);
-	}
-	return crc;
-}
-
-int main(int argc, char **argv) {
-	unsigned int result;
-	if (argc != 2) {
-		printf("no string passed as argument\n");
-		return -1;
-	}
-	result = crc32((unsigned char const *)argv[1], strlen(argv[1]));
-	printf("0x%x\n", result);
-	return 0;
-}
diff --git a/samples/pcmcia/.gitignore b/samples/pcmcia/.gitignore
new file mode 100644
index 0000000..53d0813
--- /dev/null
+++ b/samples/pcmcia/.gitignore
@@ -0,0 +1 @@
+crc32hash
diff --git a/samples/pcmcia/Makefile b/samples/pcmcia/Makefile
new file mode 100644
index 0000000..81a7498
--- /dev/null
+++ b/samples/pcmcia/Makefile
@@ -0,0 +1,9 @@
+CC := $(CROSS_COMPILE)gcc
+CFLAGS := -I../../usr/include
+
+PROGS := crc32hash
+
+all: $(PROGS)
+
+clean:
+	rm -fr $(PROGS)
diff --git a/samples/pcmcia/crc32hash.c b/samples/pcmcia/crc32hash.c
new file mode 100644
index 0000000..44f8bee
--- /dev/null
+++ b/samples/pcmcia/crc32hash.c
@@ -0,0 +1,32 @@
+/* crc32hash.c - derived from linux/lib/crc32.c, GNU GPL v2 */
+/* Usage example:
+$ ./crc32hash "Dual Speed"
+*/
+
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <stdlib.h>
+
+static unsigned int crc32(unsigned char const *p, unsigned int len)
+{
+	int i;
+	unsigned int crc = 0;
+	while (len--) {
+		crc ^= *p++;
+		for (i = 0; i < 8; i++)
+			crc = (crc >> 1) ^ ((crc & 1) ? 0xedb88320 : 0);
+	}
+	return crc;
+}
+
+int main(int argc, char **argv) {
+	unsigned int result;
+	if (argc != 2) {
+		printf("no string passed as argument\n");
+		return -1;
+	}
+	result = crc32((unsigned char const *)argv[1], strlen(argv[1]));
+	printf("0x%x\n", result);
+	return 0;
+}
-- 
2.7.4

