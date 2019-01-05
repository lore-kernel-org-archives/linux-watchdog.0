Return-Path: <SRS0=S4iV=PN=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6004C43387
	for <linux-watchdog@archiver.kernel.org>; Sat,  5 Jan 2019 01:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5555218E0
	for <linux-watchdog@archiver.kernel.org>; Sat,  5 Jan 2019 01:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzROmLVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfAEBLR (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 4 Jan 2019 20:11:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38967 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfAEBLR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Jan 2019 20:11:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so33837898ljh.6
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Jan 2019 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRhuQE1jrZ/KxZQU0NrmODSbsXVqSL3bpErcmoZcIEg=;
        b=XzROmLVPlYKqUQhH+czUDUvuUuK6V2GQPUGp2TNeOwHovVJmEoDrlub6awtFUzSvMC
         prfM2aGFabd72FX1Mi3tKBYEI0iHGj333g1yrfNTiQeqJH2ksVDz4GQMur7rVQLFjZuZ
         I1iYnr6EoW6U2bY3S2wZlDHDuMsoLW6YDtjqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRhuQE1jrZ/KxZQU0NrmODSbsXVqSL3bpErcmoZcIEg=;
        b=jTBvYogJ+QK6VIYM+O+T0N9bf+kjCMu0D7UcWTZwUBaHh0RiejGhRq8HzrcNRkZlWK
         wYULkJu0ATa+ebRKy1XfIpRN/l/7VUCBHpLDVp0ayJLZR7t2hT6JSl1sNQzp0wfyJFPG
         9OatdpcGArqE0Ak/n4s5YbNmXLesX6Rk83GgXtCeEnu7fcXbRI7DticU77w3ArDb/VG/
         oVaEVmgYeazPTAvTM8UEOqCR0pIkIYaeicyxQR27e+sV3sQpdCqtNG7sB54rXyRMtyAY
         4w0E0QOBZb64BEpIH3gWu4brqUrW+B5Qqc50OelwnczhXC44XHQioNH50sZpb0YgnmoY
         pvGw==
X-Gm-Message-State: AJcUukfI5kDsKfjFIyRqLa9m6FL4YF8E4ggiSPAWjR23nZKthEy80xRP
        9PiEjRWXkJVbWAAYp2S3AG2L5eiKTDtYbLVv
X-Google-Smtp-Source: ALg8bN7THPxZ2ApioR6lRzgtS9ykrzggNJESDwGj2hX7P/EenwIsCqIE43yID8Nt7fJ13ZQQoK7Wqw==
X-Received: by 2002:a2e:87c3:: with SMTP id v3-v6mr33018367ljj.13.1546650674975;
        Fri, 04 Jan 2019 17:11:14 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id l21-v6sm12666569ljj.48.2019.01.04.17.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 17:11:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] watchdog: wm831x: Use GPIO descriptor
Date:   Sat,  5 Jan 2019 02:09:08 +0100
Message-Id: <20190105010908.26623-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The WM831x watchdog driver passes a global GPIO number from
platform data into this driver, this is discouraged so pass
a GPIO descriptor instead.

More thorough approaches are possible passing descriptors
associated with the device through machine descriptor tables,
but no boardfiles in the kernel currently use this driver
so it is hard to test.

Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/watchdog/wm831x_wdt.c    | 23 ++++++-----------------
 include/linux/mfd/wm831x/pdata.h |  3 ++-
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 116c2f47b463..998a39f83c48 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <linux/mfd/wm831x/core.h>
 #include <linux/mfd/wm831x/pdata.h>
@@ -29,7 +29,7 @@ struct wm831x_wdt_drvdata {
 	struct watchdog_device wdt;
 	struct wm831x *wm831x;
 	struct mutex lock;
-	int update_gpio;
+	struct gpio_desc *update_gpiod;
 	int update_state;
 };
 
@@ -103,8 +103,8 @@ static int wm831x_wdt_ping(struct watchdog_device *wdt_dev)
 
 	mutex_lock(&driver_data->lock);
 
-	if (driver_data->update_gpio) {
-		gpio_set_value_cansleep(driver_data->update_gpio,
+	if (driver_data->update_gpiod) {
+		gpiod_set_value_cansleep(driver_data->update_gpiod,
 					driver_data->update_state);
 		driver_data->update_state = !driver_data->update_state;
 		ret = 0;
@@ -239,19 +239,8 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 		reg |= pdata->secondary << WM831X_WDOG_SECACT_SHIFT;
 		reg |= pdata->software << WM831X_WDOG_RST_SRC_SHIFT;
 
-		if (pdata->update_gpio) {
-			ret = devm_gpio_request_one(&pdev->dev,
-						pdata->update_gpio,
-						GPIOF_OUT_INIT_LOW,
-						"Watchdog update");
-			if (ret < 0) {
-				dev_err(wm831x->dev,
-					"Failed to request update GPIO: %d\n",
-					ret);
-				return ret;
-			}
-
-			driver_data->update_gpio = pdata->update_gpio;
+		if (pdata->update_gpiod) {
+			driver_data->update_gpiod = pdata->update_gpiod;
 
 			/* Make sure the watchdog takes hardware updates */
 			reg |= WM831X_WDOG_RST_SRC;
diff --git a/include/linux/mfd/wm831x/pdata.h b/include/linux/mfd/wm831x/pdata.h
index dcc9631b3052..ea7e9ad10a14 100644
--- a/include/linux/mfd/wm831x/pdata.h
+++ b/include/linux/mfd/wm831x/pdata.h
@@ -15,6 +15,7 @@
 #ifndef __MFD_WM831X_PDATA_H__
 #define __MFD_WM831X_PDATA_H__
 
+struct gpio_desc;
 struct wm831x;
 struct regulator_init_data;
 
@@ -95,7 +96,7 @@ enum wm831x_watchdog_action {
 
 struct wm831x_watchdog_pdata {
 	enum wm831x_watchdog_action primary, secondary;
-	int update_gpio;
+	struct gpio_desc *update_gpiod;
 	unsigned int software:1;
 };
 
-- 
2.19.2

