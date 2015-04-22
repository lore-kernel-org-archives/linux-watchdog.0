Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:58622 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756889AbbDVLMA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Apr 2015 07:12:00 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv7 4/8] Documentation/watchdog: watchdog-test.c: Add support for changing timeout
Date: Wed, 22 Apr 2015 14:11:38 +0300
Message-Id: <1429701102-22320-5-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

It might be useful for the random watchdog developer to also test
changing the watchdog timeout. Therefore, change the test application
to also support changing timeout.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 Documentation/watchdog/src/watchdog-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index 3da8229..fb20d70 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -63,6 +63,12 @@ int main(int argc, char *argv[])
 	    fprintf(stderr, "Watchdog card enabled.\n");
 	    fflush(stderr);
 	    goto end;
+	} else if (!strncasecmp(argv[1], "-t", 2)) {
+	    flags = atoi(argv[2]);
+	    ioctl(fd, WDIOC_SETTIMEOUT, &flags);
+	    fprintf(stderr, "Watchdog timeout set to %d seconds.\n", flags);
+	    fflush(stderr);
+	    goto end;
 	} else {
 	    fprintf(stderr, "-d to disable, -e to enable.\n");
 	    fprintf(stderr, "run by itself to tick the card.\n");
-- 
2.1.0

