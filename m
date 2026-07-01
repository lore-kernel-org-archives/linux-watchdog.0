Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE42FDC27
	for <linux-watchdog@vger.kernel.org>; Wed,  1 Jul 2026 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877847; cv=none; b=snOVJi3pVhZb+b4Stcs0sfcDx3gtXdfZuMqU3DFji9o2OY+eMF3XlcA87cA43IAR9vU/pRG7jqUGYYK8IFQ07Mewk49y+xt2Jf/VioEa/Y8rbqIqWcZZpdlCGv1Pqt923u4g9wdv/FktAZFZdUYxRJq98m41Luu8Cop6pfd805Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877847; c=relaxed/simple;
	bh=QHLfq0+01isNj1yrq9v2QkM6WgJjPQHUV4X0GxdiE/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r9ixg4g5+dilQVWhbFLvLykS1vOvyrpKc/IGwFkrHiFFh/xAxG05raeRssFZfmMGcZH7gEDGXQyi0JgmjkRN8+96cVUEh5v09Gwb9IKUz3kl90nEg5Ate6auUi04dOG8tpWRd9dsBtAA+wKUkD74oSgIZTy+2mS3zlQw1vK6JU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHBwfLGv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHBwfLGv"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so124746a12.2
        for <linux-watchdog@vger.kernel.org>; Tue, 30 Jun 2026 20:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782877845; x=1783482645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X7pzfCTXPwMbRd3JbENOoVc0U1qKMgH+pMjUvhfKbY=;
        b=JHBwfLGvdvWV0U+2BmS7u1KrGPFlDXA9X5HyKKP8sIOF64hZxKBrCK8IXbhfeLW+eK
         YcVyNfgWvs+pnDsoNKKTGLSNfth3zSoNsBpSK2Re2i1fu30FyLlj2e8cOMAbmWdRg0j+
         1NLczPbs0R5UjbjSI/at0OMoZ/GeWtfNMSrND2pP2/iqdUqm5uaOXdGmnqB5m6gqZdns
         Bx0Lycvnpuy9f4Ken/zQ0ozRfRVy30eUNdNQMt4ONwdYWczW8XGOL8kVHtReqthqZjwd
         P2uOwR3ELhv/Xx+gewJPxnHmYYhT99gKxjDk2jqloVOW41pauS/kgYx6el0xuw2G0Dwa
         GpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782877845; x=1783482645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4X7pzfCTXPwMbRd3JbENOoVc0U1qKMgH+pMjUvhfKbY=;
        b=WEbmU9fQpwoA4/n01XseMnSKeHh3kdZhN4BvrjFGIhwtstHSI0osCJ2qQ8IPfHqT2W
         r7A9YS/CIjwmZOFPBg8fSPZ+5wX+Fo6Ic31cuQHuolT7jpAmj2VT4jhSll5nYFMT9sQR
         jwSDsg/5dW9lcgCAIuCxaaiM5d9VIvz6m+PMNgQP/VhS/GclynvSK3lLC5/j5OlVug5I
         RlEVXa0YxwBqQAhDNhMwfa/R4DTIsX8s3/hPUjQ0LLjPa6QZEZP1ogpbKWR20hpWnSlJ
         ELFB2H4jB74gsGK0aPowXjj63BWPnj5zV+4Uyz1JSHUUAi50iNriWAqeA7HFCxMRjRhi
         uHfw==
X-Forwarded-Encrypted: i=1; AHgh+RqjCkPhrmGziNQCgEeg9idaedeQ/uS/7Iebvqu6nxfZmTA8pT86SAtFxI8CEPHJPWyj6QHJLERk6t2/sBzKrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIB8lu33y8eDhaoMZMNBRxyQZXbKJo4tfOJ2ME1RU/5/gR/nWu
	3RA4Ur5Z+ODS7aHIaUHaXN6oYSl8FoHO1hBjUDaUQSAMr+DtJ8CJ/w05
X-Gm-Gg: AfdE7clQdYTyBejrNJ8MIYMRp5bq+ZM38f6XGRgad6c0HIL1GTkKQEz91zi+WUJj+da
	a5pSTVtGNtNUuRnSCNSvhMvHPOTasRYHzKXamRoumhfQ1RbNzGW4RxK7tgx+WTczZKE6hZ4MStq
	DTaDXDZIyBRjXLgps/N6WATTRWFTx+EyUXnQOU4f/OEKqi8s02RLI4frYyS49m7tl555D4zdSiR
	01T9i1tN9DCIYGVYg8ru2UjB3xzhPrHBAYWMPrp/wF0fbLi9sytH3suFNB2BbwYKpREoT8E3Vws
	oqNKcg/oaoW6OIrjPUXqlu0b7Fu7/AG6ukNMGM5/7g9QRfAuJ8hqz3UHV/LtUhH6MFJ/Qn4PVOd
	dzhcUlB8VXn34wW9fDF9COoMpBg9fhK+71pnsqhCcpSLNW6kp52BNz2CBXbAPIrjlc06TIDwZw1
	kOpgNgQDaRww7diN6zMEKq11pfyA4UzSFicpK7BV0sHH6apjlwOd+fsO4=
X-Received: by 2002:a05:6a20:a121:b0:3b3:fdb0:2295 with SMTP id adf61e73a8af0-3bfc505bcc1mr5294388637.6.1782877845029;
        Tue, 30 Jun 2026 20:50:45 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbd27a924sm2429089a12.14.2026.06.30.20.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 20:50:44 -0700 (PDT)
From: a0282524688@gmail.com
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v6 1/7] mfd: nct6694: Move module type macros to shared header
Date: Wed,  1 Jul 2026 11:50:19 +0800
Message-Id: <20260701035025.3082927-2-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035025.3082927-1-a0282524688@gmail.com>
References: <20260701035025.3082927-1-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

Move NCT6694_XXX_MOD macro definitions from individual sub-device
drivers into the shared header include/linux/mfd/nct6694.h.

This is a prerequisite for supporting multiple transport interfaces
(USB, HIF) without duplicating these definitions.

No functional change.

Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes in v6:

Changes in v5:
- Split from the monolithic v4 patch to follow the single logical change
  principle.

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

