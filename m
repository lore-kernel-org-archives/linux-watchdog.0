Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51256 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033Ab2ENSMJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 14:12:09 -0400
From: Devendra Naga <devendra.aaru@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Rob Landley <rob@landley.net>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH] Documentation/watchdog: close the fd when cmdline arg given
Date: Mon, 14 May 2012 23:42:02 +0530
Message-Id: <1337019122-17300-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

in the watchdog test code, the ioctl is performed on the watchdog device
and just doing exit(0) so we leak a filedescripor.

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 Documentation/watchdog/src/watchdog-test.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index 63fdc34..23084f2 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -47,18 +47,18 @@ int main(int argc, char *argv[])
 	    ioctl(fd, WDIOC_SETOPTIONS, &flags);
 	    fprintf(stderr, "Watchdog card disabled.\n");
 	    fflush(stderr);
-	    exit(0);
+	    goto end;
 	} else if (!strncasecmp(argv[1], "-e", 2)) {
 	    flags = WDIOS_ENABLECARD;
 	    ioctl(fd, WDIOC_SETOPTIONS, &flags);
 	    fprintf(stderr, "Watchdog card enabled.\n");
 	    fflush(stderr);
-	    exit(0);
+	    goto end;
 	} else {
 	    fprintf(stderr, "-d to disable, -e to enable.\n");
 	    fprintf(stderr, "run by itself to tick the card.\n");
 	    fflush(stderr);
-	    exit(0);
+	    goto end;
 	}
     } else {
 	fprintf(stderr, "Watchdog Ticking Away!\n");
@@ -69,4 +69,7 @@ int main(int argc, char *argv[])
 	keep_alive();
 	sleep(1);
     }
+end:
+    close(fd);
+    return 0;
 }
-- 
1.7.9.5

