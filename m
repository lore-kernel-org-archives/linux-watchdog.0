Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF73AC0D9
	for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2026 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697085; cv=none; b=pGJzK2wva3PSAZWfUyhZzyqb96Hy06GaazIs0tXKvIcnr+PTE+Tm8H9p90r0R0beQ97advRlE5HSwOGa2netmpzpDgvrTIQhDM8j0svjia/r8leL4WtYRQJBG0DfnxsAMQneuxV7W/dXgFgDpCN2hAskzRi54SFM3dm+i11yOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697085; c=relaxed/simple;
	bh=2EmRJVOu9kxZujWs9EHUsfBKTk0WixSaolqBsSe+3cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MkoyIeLFI3m0w/V559X8URrLaw9ywVUqeaoJAHjtDb+WrHaEXnqdfvAtqoZghABjtjqTZ69vys9/YTAoMoCG8nD6QeNwCOvAcXhGQn0000RRAnMr3IGzZd7lSkMa7+JbhxvvnqQuMbfy5379wTOz+T/x0YWHcFAuKWFjEyDhhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2D5s7BR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2D5s7BR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3664df32e91so10827544a91.3
        for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2026 01:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779697083; x=1780301883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc4O5/kSgHyWkY3Qo5dJGWH4VWfSLL8bPtdDsIJFGxs=;
        b=i2D5s7BRJpcTb8H4a2tfRzC1PkmLFikC/gQNEOWlJMtpBNxSBiyUstqNqEmoVCC1Rl
         7bRFbG5vXwxY7+5Ec2TTfYAP2uEm1Swf1kXCoixwkmJjlOBCcRNYQgr740yENfKUEcdh
         c8VlBxDJbBjThI8SPAh5mDIegj+VHtdrPqer9xqSL3rQLWeTSOMInK7NYcwcuwCvTHLA
         H+AVxQW/eNLwyR6KJMANVRiuJB7LPiFC9l+7w/gDy6+0asfUNwvXVlWKob2pFBUgv98L
         4qyfu6R86SVSi2x19VnXw+0nJr9TXspQ2z8XJm63mxMi1AD5cZWKkNuhqWtAQAy5lq7/
         Es9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779697083; x=1780301883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dc4O5/kSgHyWkY3Qo5dJGWH4VWfSLL8bPtdDsIJFGxs=;
        b=VB9KK7PoWe2cnu5hw1QUwj0ub/gLdac1x4sTG5CYoiuA6/fC6FBusnmI7KpwWqJLcH
         u+wOLrqDmicWl0ZI0FXo5zJKi2wLdOToaLE4LF+Gevh5Jqcz1NtOJ5jLpdrBSP3JRVk5
         Lbop417V5jVN7izY6fV4fw4ttYpHKadfwYUgY6wKQAWf6rHwLveulwx6JbborHmkeqo/
         Gw0ABO5itdA2mQONf7w3H/LcwjhYfVFu0DJmvpfP/O2g8gP83EereXi6Swb8FuH3jKAc
         uz0GtMhtQsy5mJHZlj0YIoeyTuy6LZIalf8haDoVjMiohewAycy6lpLV8D3qkzUeiwfK
         eAzg==
X-Forwarded-Encrypted: i=1; AFNElJ80eJIpQk6rz/tnZ8FHyLzgpsLZs0uCBb020ts8erTYgXICX1xCTsOxUelSvUg2SQ7k+rVi4DOVH1nK7SCNOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAJwKVACzfBFga9BmOgHRimRYLrkzqZiM3LgjR56JHcQiTILE
	73vqYYvAKPNg02KE3LwAH0dzefJNtQgnMJA78Q4ro9OmcCU+rTPn7Jg4
X-Gm-Gg: Acq92OGMsGxt1MaCLrvyjY/ZN3JqUdtjbYyqYRtrP4TNAjqszkxe79O5wLC5rTIoxpq
	eu6daH843g4LXGaAlWjR+ISBVZfsvWsHKap2MI/72JWwDfkhL/4mwsq6L5Vvg3DFk9BCo/keuNS
	nqk9WmLgl8lFXWFHlgrjhhSq1vENo6U8PF2OJoAvvVCs23OdfBZcDJcjvZ82JKRebiDkaZy4orf
	+wSqKJTIlKt2BOHJ8onNZQeSxuMZQRxK7sgvaFVF8H5HT1mY/ZbwZb3FzD9pQ4bXCiqxFrVYezU
	QbmeeBed4fLDCFbR+5ecLgcDZSry2yYx0jHptciXeS2cuvlWTc71uWlzOIREtJT3j7EdsuWKGht
	C9dTfN9LqllyQeYaB6qR5BgGazEPMU6F3q8LXVAabRJHW8d42jvMjOjtsoNC7J6ADW6uRnkb8Om
	PueTtF6jr/Je0NpPo6YznAbpVjH7EZVuMQF2rCXV5gSpzOKakNHLHMr1aliLPSWWgeHtqVIEf4F
	iFg
X-Received: by 2002:a17:90b:3a10:b0:369:a359:b192 with SMTP id 98e67ed59e1d1-36a67475b45mr12807202a91.10.1779697082704;
        Mon, 25 May 2026 01:18:02 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7cf9sm8964102a91.10.2026.05.25.01.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:18:02 -0700 (PDT)
From: a0282524688@gmail.com
To: Ming Yu <tmyu0@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>
Cc: Ming Yu <a0282524688@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v5 1/7] mfd: nct6694: Move module type macros to shared header
Date: Mon, 25 May 2026 16:17:30 +0800
Message-Id: <20260525081736.2904310-2-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525081736.2904310-1-a0282524688@gmail.com>
References: <20260525081736.2904310-1-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

Move NCT6694_XXX_MOD  macro definitions from individual sub-device
drivers into the shared header include/linux/mfd/nct6694.h.

This is a prerequisite for supporting multiple transport interfaces
(USB, HIF) without duplicating these definitions.

No functional change.

Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes in v5:
- Split from the monolithic v4 patch to follow the single logical change principle.

 drivers/gpio/gpio-nct6694.c         |  7 -------
 drivers/hwmon/nct6694-hwmon.c       | 21 ---------------------
 drivers/i2c/busses/i2c-nct6694.c    |  7 -------
 drivers/net/can/usb/nct6694_canfd.c |  6 ------
 drivers/rtc/rtc-nct6694.c           |  7 -------
 drivers/watchdog/nct6694_wdt.c      |  7 -------
 include/linux/mfd/nct6694.h         |  9 +++++++++
 7 files changed, 9 insertions(+), 55 deletions(-)

diff --git a/drivers/gpio/gpio-nct6694.c b/drivers/gpio/gpio-nct6694.c
index a8607f0d9915..53bfc5983648 100644
--- a/drivers/gpio/gpio-nct6694.c
+++ b/drivers/gpio/gpio-nct6694.c
@@ -13,13 +13,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-/*
- * USB command module type for NCT6694 GPIO controller.
- * This defines the module type used for communication with the NCT6694
- * GPIO controller over the USB interface.
- */
-#define NCT6694_GPIO_MOD	0xFF
-
 #define NCT6694_GPIO_VER	0x90
 #define NCT6694_GPIO_VALID	0x110
 #define NCT6694_GPI_DATA	0x120
diff --git a/drivers/hwmon/nct6694-hwmon.c b/drivers/hwmon/nct6694-hwmon.c
index 6dcf22ca5018..581451875f2c 100644
--- a/drivers/hwmon/nct6694-hwmon.c
+++ b/drivers/hwmon/nct6694-hwmon.c
@@ -15,13 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-/*
- * USB command module type for NCT6694 report channel
- * This defines the module type used for communication with the NCT6694
- * report channel over the USB interface.
- */
-#define NCT6694_RPT_MOD			0xFF
-
 /* Report channel */
 /*
  * The report channel is used to report the status of the hardware monitor
@@ -38,13 +31,6 @@
 #define NCT6694_TIN_STS(x)		(0x6A + (x))
 #define NCT6694_FIN_STS(x)		(0x6E + (x))
 
-/*
- * USB command module type for NCT6694 HWMON controller.
- * This defines the module type used for communication with the NCT6694
- * HWMON controller over the USB interface.
- */
-#define NCT6694_HWMON_MOD		0x00
-
 /* Command 00h - Hardware Monitor Control */
 #define NCT6694_HWMON_CONTROL		0x00
 #define NCT6694_HWMON_CONTROL_SEL	0x00
@@ -53,13 +39,6 @@
 #define NCT6694_HWMON_ALARM		0x02
 #define NCT6694_HWMON_ALARM_SEL		0x00
 
-/*
- * USB command module type for NCT6694 PWM controller.
- * This defines the module type used for communication with the NCT6694
- * PWM controller over the USB interface.
- */
-#define NCT6694_PWM_MOD			0x01
-
 /* PWM Command - Manual Control */
 #define NCT6694_PWM_CONTROL		0x01
 #define NCT6694_PWM_CONTROL_SEL		0x00
diff --git a/drivers/i2c/busses/i2c-nct6694.c b/drivers/i2c/busses/i2c-nct6694.c
index 1413ab6f9462..ef3329f34246 100644
--- a/drivers/i2c/busses/i2c-nct6694.c
+++ b/drivers/i2c/busses/i2c-nct6694.c
@@ -12,13 +12,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-/*
- * USB command module type for NCT6694 I2C controller.
- * This defines the module type used for communication with the NCT6694
- * I2C controller over the USB interface.
- */
-#define NCT6694_I2C_MOD			0x03
-
 /* Command 00h - I2C Deliver */
 #define NCT6694_I2C_DELIVER		0x00
 #define NCT6694_I2C_DELIVER_SEL		0x00
diff --git a/drivers/net/can/usb/nct6694_canfd.c b/drivers/net/can/usb/nct6694_canfd.c
index e5f7f8849a73..262b4c26c9d4 100644
--- a/drivers/net/can/usb/nct6694_canfd.c
+++ b/drivers/net/can/usb/nct6694_canfd.c
@@ -18,12 +18,6 @@
 
 #define DEVICE_NAME "nct6694-canfd"
 
-/* USB command module type for NCT6694 CANfd controller.
- * This defines the module type used for communication with the NCT6694
- * CANfd controller over the USB interface.
- */
-#define NCT6694_CANFD_MOD			0x05
-
 /* Command 00h - CAN Setting and Initialization */
 #define NCT6694_CANFD_SETTING			0x00
 #define NCT6694_CANFD_SETTING_ACTIVE_CTRL1	BIT(0)
diff --git a/drivers/rtc/rtc-nct6694.c b/drivers/rtc/rtc-nct6694.c
index 35401a0d9cf5..c06902f150c9 100644
--- a/drivers/rtc/rtc-nct6694.c
+++ b/drivers/rtc/rtc-nct6694.c
@@ -14,13 +14,6 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 
-/*
- * USB command module type for NCT6694 RTC controller.
- * This defines the module type used for communication with the NCT6694
- * RTC controller over the USB interface.
- */
-#define NCT6694_RTC_MOD		0x08
-
 /* Command 00h - RTC Time */
 #define NCT6694_RTC_TIME	0x0000
 #define NCT6694_RTC_TIME_SEL	0x00
diff --git a/drivers/watchdog/nct6694_wdt.c b/drivers/watchdog/nct6694_wdt.c
index bc3689bd4b6b..4c06ac105562 100644
--- a/drivers/watchdog/nct6694_wdt.c
+++ b/drivers/watchdog/nct6694_wdt.c
@@ -20,13 +20,6 @@
 
 #define NCT6694_WDT_MAX_DEVS		2
 
-/*
- * USB command module type for NCT6694 WDT controller.
- * This defines the module type used for communication with the NCT6694
- * WDT controller over the USB interface.
- */
-#define NCT6694_WDT_MOD			0x07
-
 /* Command 00h - WDT Setup */
 #define NCT6694_WDT_SETUP		0x00
 #define NCT6694_WDT_SETUP_SEL(idx)	(idx ? 0x01 : 0x00)
diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
index 6eb9be2cd4a0..3c683e317aa3 100644
--- a/include/linux/mfd/nct6694.h
+++ b/include/linux/mfd/nct6694.h
@@ -8,6 +8,15 @@
 #ifndef __MFD_NCT6694_H
 #define __MFD_NCT6694_H
 
+#define NCT6694_HWMON_MOD	0x00
+#define NCT6694_PWM_MOD		0x01
+#define NCT6694_I2C_MOD		0x03
+#define NCT6694_CANFD_MOD	0x05
+#define NCT6694_WDT_MOD		0x07
+#define NCT6694_RTC_MOD		0x08
+#define NCT6694_RPT_MOD		0xFF
+#define NCT6694_GPIO_MOD	NCT6694_RPT_MOD
+
 #define NCT6694_VENDOR_ID	0x0416
 #define NCT6694_PRODUCT_ID	0x200B
 #define NCT6694_INT_IN_EP	0x81
-- 
2.34.1

