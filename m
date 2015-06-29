Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40189 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbbF2QqU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Jun 2015 12:46:20 -0400
From: Timur Tabi <timur@codeaurora.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Vipul Gandhi <vgandhi@codeaurora.org>
Subject: [PATCH] Documentation/watchdog: add timeout and ping rate control to watchdog-test.c
Date: Mon, 29 Jun 2015 11:46:17 -0500
Message-Id: <1435596377-17737-1-git-send-email-timur@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog test program is much more useful if it can configure the
timeout value and ping rate.  This will allow you to test actual timeouts.

Adds the -t parameter to set the timeout value (in seconds), and -p to set
the ping rate (number of seconds between pings).

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 Documentation/watchdog/src/watchdog-test.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index 3da8229..fcdde8f 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -41,6 +41,7 @@ static void term(int sig)
 int main(int argc, char *argv[])
 {
     int flags;
+    unsigned int ping_rate = 1;
 
     fd = open("/dev/watchdog", O_WRONLY);
 
@@ -63,22 +64,33 @@ int main(int argc, char *argv[])
 	    fprintf(stderr, "Watchdog card enabled.\n");
 	    fflush(stderr);
 	    goto end;
+	} else if (!strncasecmp(argv[1], "-t", 2) && argv[2]) {
+	    flags = atoi(argv[2]);
+	    ioctl(fd, WDIOC_SETTIMEOUT, &flags);
+	    fprintf(stderr, "Watchdog timeout set to %u seconds.\n", flags);
+	    fflush(stderr);
+	    goto end;
+	} else if (!strncasecmp(argv[1], "-p", 2) && argv[2]) {
+	    ping_rate = strtoul(argv[2], NULL, 0);
+	    fprintf(stderr, "Watchdog ping rate set to %u seconds.\n", ping_rate);
+	    fflush(stderr);
 	} else {
-	    fprintf(stderr, "-d to disable, -e to enable.\n");
+	    fprintf(stderr, "-d to disable, -e to enable, -t <n> to set " \
+		"the timeout,\n-p <n> to set the ping rate, and \n");
 	    fprintf(stderr, "run by itself to tick the card.\n");
 	    fflush(stderr);
 	    goto end;
 	}
-    } else {
-	fprintf(stderr, "Watchdog Ticking Away!\n");
-	fflush(stderr);
     }
 
+    fprintf(stderr, "Watchdog Ticking Away!\n");
+    fflush(stderr);
+
     signal(SIGINT, term);
 
     while(1) {
 	keep_alive();
-	sleep(1);
+	sleep(ping_rate);
     }
 end:
     close(fd);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

