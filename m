Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:30767 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeHBXRO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Aug 2018 19:17:14 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 1/4] watchdog: hpwdt: Initialize pretimeout from module parameter.
Date: Thu,  2 Aug 2018 15:15:38 -0600
Message-Id: <1533244541-42310-2-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When the pretimeout is specified as a module parameter, the
value should be reflected in hpwdt_dev.pretimeout.  The default
(on) case is correct.  But, when disabling pretimeout, the value
should be set to zero in hpwdt_dev.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 9dc62a4..369022d 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -313,6 +313,11 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
 		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
+	if (!pretimeout)
+		hpwdt_dev.pretimeout = 0;
+#endif
+
 	hpwdt_dev.parent = &dev->dev;
 	retval = watchdog_register_device(&hpwdt_dev);
 	if (retval < 0) {
-- 
1.8.3.1

