Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34324 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbbFEMln (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Jun 2015 08:41:43 -0400
Received: by laew7 with SMTP id w7so53291176lae.1
        for <linux-watchdog@vger.kernel.org>; Fri, 05 Jun 2015 05:41:42 -0700 (PDT)
Date: Fri, 5 Jun 2015 15:41:44 +0300
From: Markus Rinne <markus.rinne@vincit.fi>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: imx2_wdt: Fix ioctl() results
Message-ID: <20150605124144.GA26755@markusri_laptop.vincit.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT returned the initial timeout and
not the one that was last set.  Fix this by updating struct
watchdog_device member 'timeout'.  This is how it's supposed to be done
according to Documentation/watchdog/watchdog-kernel-api.txt.

This is the test case I used:

#include <fcntl.h>
#include <linux/watchdog.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <assert.h>
#include <stdlib.h>

static const int TIMEOUT = 127;

int main(void)
{
	int fd = open("/dev/watchdog", O_WRONLY);
	if (fd == -1)
		return EXIT_FAILURE;

	int timeout = TIMEOUT;
	ioctl(fd, WDIOC_SETTIMEOUT, &timeout);
	assert(timeout == TIMEOUT);

	close(fd);

	return EXIT_SUCCESS;
}

Signed-off-by: Markus Rinne <markus.rinne@vincit.fi>
---
 drivers/watchdog/imx2_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 5e6d808..b636799 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -168,6 +168,7 @@ static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 
 	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
 			   WDOG_SEC_TO_COUNT(new_timeout));
+	wdog->timeout = new_timeout;
 	return 0;
 }
 
-- 
1.8.4

