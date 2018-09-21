Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:44452 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391243AbeIVClX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Sep 2018 22:41:23 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] watchdog/hpwdt: Disable PreTimeout when Timeout is smaller
Date: Fri, 21 Sep 2018 14:50:39 -0600
Message-Id: <20180921205039.11466-1-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

During module install, disable pretimeout if the requested timeout
value is not greater than the minimal pretimeout value that is
supported by hardware.

This makes the module load handling of pretimeout consistent
with the ioctl handling of pretimeout.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 7af358b3e278..93562304f7aa 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -311,6 +311,10 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
 		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
 
+	if (pretimeout && hpwdt_dev.timeout <= PRETIMEOUT_SEC) {
+		dev_warn(&dev->dev, "timeout <= pretimeout. Setting pretimeout to zero\n");
+		pretimeout = 0;
+	}
 	hpwdt_dev.pretimeout = pretimeout ? PRETIMEOUT_SEC : 0;
 
 	hpwdt_dev.parent = &dev->dev;
-- 
2.13.6
