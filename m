Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54437 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbcFUXAY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jun 2016 19:00:24 -0400
From: Timur Tabi <timur@codeaurora.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH 2/2] Documentation/watchdog: add support for magic close to watchdog-test
Date: Tue, 21 Jun 2016 18:00:15 -0500
Message-Id: <1466550015-14924-2-git-send-email-timur@codeaurora.org>
In-Reply-To: <1466550015-14924-1-git-send-email-timur@codeaurora.org>
References: <1466550015-14924-1-git-send-email-timur@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Some drivers have the WDIOF_MAGICCLOSE set, which means that applications
need to write 'V' to the watchdog device before closing, otherwise the
driver won't stop the watchdog timer.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 Documentation/watchdog/src/watchdog-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index b3cc7aa..c691539 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -13,6 +13,7 @@
 #include <linux/watchdog.h>
 
 int fd;
+const char v = 'V';
 
 /*
  * This function simply sends an IOCTL to the driver, which in turn ticks
@@ -34,6 +35,7 @@ static void keep_alive(void)
 
 static void term(int sig)
 {
+    write(fd, &v, 1);
     close(fd);
     printf("\nStopping watchdog ticks...\n");
     exit(0);
@@ -89,6 +91,7 @@ int main(int argc, char *argv[])
 	sleep(ping_rate);
     }
 end:
+    write(fd, &v, 1);
     close(fd);
     return 0;
 }
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

