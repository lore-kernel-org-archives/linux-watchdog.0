Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43737 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935257AbeEXAPr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 23 May 2018 20:15:47 -0400
Received: by mail-qt0-f196.google.com with SMTP id f13-v6so30535584qtp.10
        for <linux-watchdog@vger.kernel.org>; Wed, 23 May 2018 17:15:47 -0700 (PDT)
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v3 3/6] watchdog: sp805: add 'timeout-sec' DT property support
Date: Wed, 23 May 2018 17:15:21 -0700
Message-Id: <1527120924-12131-4-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add support for optional devicetree property 'timeout-sec'.
'timeout-sec' is used in the driver if specified in devicetree.
Otherwise, fall back to driver default, i.e., 60 seconds

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp805_wdt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 03805bc..1484609 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -230,7 +230,14 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	spin_lock_init(&wdt->lock);
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
-	wdt_setload(&wdt->wdd, DEFAULT_TIMEOUT);
+
+	/*
+	 * If 'timeout-sec' devicetree property is specified, use that.
+	 * Otherwise, use DEFAULT_TIMEOUT
+	 */
+	wdt->wdd.timeout = DEFAULT_TIMEOUT;
+	watchdog_init_timeout(&wdt->wdd, 0, &adev->dev);
+	wdt_setload(&wdt->wdd, wdt->wdd.timeout);
 
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret) {
-- 
2.1.4

