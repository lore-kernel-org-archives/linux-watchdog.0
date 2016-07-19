Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53467 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbcGSJ00 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 05:26:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Timur Tabi <timur@codeaurora.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/watchdog: check return value for magic close
Date: Tue, 19 Jul 2016 11:24:50 +0200
Message-Id: <20160719092522.6397-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

A recent commit added a write to the watchdog test code for doing the "magic
close", but that caused a compile-time warning:

Documentation/watchdog/src/watchdog-test.c: In function ‘main’:
Documentation/watchdog/src/watchdog-test.c:94:5: warning: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Wunused-result]

This changes the code to print a runtime warning if the write fails.

Fixes: 5a2d3de19602 ("Documentation/watchdog: add support for magic close to watchdog-test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/watchdog/src/watchdog-test.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index c69153913722..52eea54649ab 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -2,6 +2,7 @@
  * Watchdog Driver Test Program
  */
 
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -35,9 +36,13 @@ static void keep_alive(void)
 
 static void term(int sig)
 {
-    write(fd, &v, 1);
+    int ret = write(fd, &v, 1);
+
     close(fd);
-    printf("\nStopping watchdog ticks...\n");
+    if (ret < 0)
+	printf("\nStopping watchdog ticks failed (%d)...\n", errno);
+    else
+	printf("\nStopping watchdog ticks...\n");
     exit(0);
 }
 
@@ -45,6 +50,7 @@ int main(int argc, char *argv[])
 {
     int flags;
     unsigned int ping_rate = 1;
+    int ret;
 
     setbuf(stdout, NULL);
 
@@ -91,7 +97,9 @@ int main(int argc, char *argv[])
 	sleep(ping_rate);
     }
 end:
-    write(fd, &v, 1);
+    ret = write(fd, &v, 1);
+    if (ret < 0)
+	printf("Sopping watchdog ticks failed (%d)...\n", errno);
     close(fd);
     return 0;
 }
-- 
2.9.0

