Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62168 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758531Ab2EQJhz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 May 2012 05:37:55 -0400
From: Devendra Naga <devendra.aaru@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Rob Landley <rob@landley.net>,
	Devendra Naga <devendra.aaru@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/watchdog: Fix the file descriptor leak when no cmdline arg given
Date: Thu, 17 May 2012 15:07:48 +0530
Message-Id: <1337247468-28125-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

we start a infinite loop when user gives ./watchdog-test, and when user
ctrl + c's the program, we just exit immeadiately with out closing the
filedescriptor of the watchdog device. a signal handler is used to
do the job of closing the filedescriptor and exiting the program.

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 Documentation/watchdog/src/watchdog-test.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index 23084f2..73ff5cc 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <signal.h>
 #include <sys/ioctl.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
@@ -29,6 +30,14 @@ static void keep_alive(void)
  * The main program.  Run the program with "-d" to disable the card,
  * or "-e" to enable the card.
  */
+
+void term(int sig)
+{
+    close(fd);
+    fprintf(stderr, "Stopping watchdog ticks...\n");
+    exit(0);
+}
+
 int main(int argc, char *argv[])
 {
     int flags;
@@ -65,6 +74,8 @@ int main(int argc, char *argv[])
 	fflush(stderr);
     }
 
+    signal(SIGINT, term);
+
     while(1) {
 	keep_alive();
 	sleep(1);
-- 
1.7.9.5

