Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36705 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab2G0DwU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Jul 2012 23:52:20 -0400
Received: by pbbrp8 with SMTP id rp8so4306419pbb.19
        for <linux-watchdog@vger.kernel.org>; Thu, 26 Jul 2012 20:52:20 -0700 (PDT)
From: Jerry Snitselaar <dev@snitselaar.org>
To: linux-kernel@vger.kernel.org
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: watchdog-test: make term() static
Date: Thu, 26 Jul 2012 20:52:09 -0700
Message-Id: <1343361129-8802-1-git-send-email-dev@snitselaar.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In 3.5 warning during build 'no previous prototype for term'. Since it
is only used in watchdog-test.c make term() static.

Signed-off-by: Jerry Snitselaar <dev@snitselaar.org>
---
 Documentation/watchdog/src/watchdog-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index 73ff5cc..3da8229 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -31,7 +31,7 @@ static void keep_alive(void)
  * or "-e" to enable the card.
  */
 
-void term(int sig)
+static void term(int sig)
 {
     close(fd);
     fprintf(stderr, "Stopping watchdog ticks...\n");
-- 
1.7.12.rc0

