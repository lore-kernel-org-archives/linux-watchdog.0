Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989815;
	b=abxVHr04ocPPPdUMHaC9YPKRWa4R+Wl+6dxTQteCmDWh3StYnAKqPpTEoxk2UkJC8i3a
	 xcy1Pm3v7CNIjDd0uMAPExJ2PDLuFKWl/UNmzhS3YyAqV67dFQQtHkZ047Rv3Ss3zmF6L
	 /MAPQlQcLFvFyV4oAusEqJP57bsK7QCrlSyGCi3r86M7awYzVXmr2kgAdeQ15b7Rx9HHR
	 PkDLYr8zrcAN5epMb4Zk9RtYttVnwdO/YbU9DfW2LJlS6BwEris45ZzyjjacwvgHzbc2m
	 nAxJtLEn7J0WYjXewgTmyfzqq5L3WTufUWarxvxsKPpJE6U2JpiHBvbHun77F25enjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DruTwIEuL419lERQzYgeQDALQqSuvj3CoTd7MhEXhE0=;
	b=BsU9NIAdEzM1v3H/sKOVt54C8IqARlscbD24R8uWsf4KVDP6y9nLK3y5KkQk7NlKRb6u
	 meFu4PVCGM6GmCqhpGoWg/oFTbDqhQgN+fXyuyFzbdpjNBAEhksAvtve7w9r+NV0pg8zW
	 gigAAiGzNxQLnv/IeixSDCU6Lpm/zzsDIznIxoc/ZhWX4c2OQ7l/Wvl5McF048th1msvN
	 oQFAIyl0LtmJ8zUmgBih7OTPDS4VL2m2H8NI7t3OYtTS2dcPiixJ5DsnDHzoY04SGsCVz
	 57pTx/ea0kNyIS5BPeLgzgHiF2NkGsId7+0nbsRvTCPmK4FPChI79waYseOGezXhyow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USPeiRF6;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6860A3807
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 08:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F6860A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USPeiRF6
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b600fae14dso330831b3a.2
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 00:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794989814; x=1795594614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DruTwIEuL419lERQzYgeQDALQqSuvj3CoTd7MhEXhE0=;
        b=USPeiRF6Io8kJCL6UTsJnDfsRDziB0l2u00jfPT4LTitHF1kc0qS0uCA0/sU0+A3nS
         MSnbfb7Uo+xh9nIJaQrTTff3HzFw4Jwrswz53GxG19I1ZlMjHaeZui1UudS75cXxKUfr
         T69s0m1YLE/7gSegRNvNFQiyMp/PwGjQyL/a80PcorVvtBEhwajvDFZJY1lSxPczHNM5
         DUD2Z6yU3WMtPr15R95iS8LEmMfpRlQNKMFSVSCZq4yEx4Z8LuiYOd5w4GCwbp0WBAyP
         R6Q75mnzaHNPWnXZGxu1LoTWomnwwugazAgdf16Akj9z/36ep1+J6458Cp4GH2T6vhLl
         g1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794989814; x=1795594614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DruTwIEuL419lERQzYgeQDALQqSuvj3CoTd7MhEXhE0=;
        b=xVMn2DCA5dmY9mkjKny5OYMryDwB7XyNDBvdNswYal+1TBWjeyaFAFP8APf3lgDOoX
         Li5tob1DzTTL1QpO8C+x9yXzEXZGWrkjxYfzItKHmEgoldyunHwvVwwLmacDd6iCYYaH
         Mu9j5bqQovPPlobexmQrRZAZjv1kJg1nnSLDnEqwKRwDh1cQv7pFCOn3OUGdE3MO2cMc
         eHeAXsRvOuMQXr6VGIMebF1Opw0pnIdTG/xcNaAOE1coTxJXIkEUMugZcoeS7XxJSKOe
         YSDFMvi6pANDXxszfYqrSbp7K2fimdo+WGjTWhA/Rh+kmnDOWkynchNpAzbIxChVdYod
         XPig==
X-Forwarded-Encrypted: i=1; AL+hErE4Uz87XFP+tD4jcz/CDbyHFGwim4PA9/YQ4khPhk+OYwEKc2e/N3zzCDXATReNhVSdr8krAPOujClgIqNCnA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Eav1/MioU/E8XPxjSEWr4OdkG5tyLCDgRUy0Eejwm7kbeZsej
	qVJCAwyALm6PY3kGVsa7eiVQXBeiV5noOzOqk60V//7w4RycA4Vzaocm
X-Gm-Gg: AYBFou1vTVO0ltu+cIo1lR7rxQCcDIj7KPo+xGlOUO+mKruRNciDmr7qCnI5gDYs11h
	l1hFOLD5ByHpZduIbA6T1bzRMh3VEwhKFs8HiM5sVaxcqnFD8ah8ijEPaEVlEjw7es4UAxge/Hr
	WKpPvziBfIzYEskiy3wcVqyiIynKNYtQVdOspuXRwMah+JExIBnmHiZKx7azfUzEpmUmoNc4L1h
	iKj9VYtJaxzUtVUX9Tnh3E/OCoVjsqqlaOJf/soenEk8+r0jcuK1Kn+2lKVulpKxVY45laHun5C
	y9a9jv/PghshxXQuzzezOlBIZwtqvD8FNi0OvHlkUO9DALrhhj8Rw2Ce0kpR73THbx7t2FERA96
	F363D75Np0HuihIcu+ddE3zP46I6VBS2ZTDiW/uPrafIVuHwqH1Wcj/dL5d1JPX7TfM233jKUqe
	/jJK2JaLpiTMuBdIjKGuk2Cl/mmbUlFzZOb2KfagQtm/AZWqpSQd+yxxiSFW+LUDpdxOhaV4Pux
	I7IgOP3O2m74eEbmn470MAkoNSPySa7VqMDQMjEcDLDdHSlCN97C9aQSxm8eYoNjqDqqaZO9s3S
	vQa6ibR5jZmD/Fj+S9/t+lJcofGFvWLc6eFN5BcdLrXH41zFg5NSGibdYIzvmMWpOMHq+z8=
X-Received: by 2002:a05:6a21:828c:b0:3f9:b55e:10bb with SMTP id adf61e73a8af0-3fe98af080bmr1592901637.87.1794989813764;
        Wed, 18 Nov 2026 00:16:53 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cad8cefbsm764401b3a.31.2026.11.18.00.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:16:53 -0800 (PST)
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
	linux-watchdog@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v10 06/13] mfd: nct6694: Move module type macros to shared header
Date: Wed, 18 Nov 2026 16:16:17 +0800
Message-Id: <20261118081625.2399247-7-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118081625.2399247-1-a0282524688@gmail.com>
References: <20261118081625.2399247-1-a0282524688@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

Each sub-device driver defines the module type used by its own
commands. The upcoming HIF transport also needs to recognise
NCT6694_RPT_MOD, as report accesses are served from a separate
register space rather than through the command mailbox.

Move all module types into the shared header so that the transports
and the sub-device drivers use a single set of definitions.

No functional change.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes in v10:
- None.

Changes in v9:
- Added Andi's Reviewed-by.

Changes in v8:
- Reworded the commit message to explain why the transport needs the
  module types.

Changes in v7:
- None.

Changes in v6:
- None.

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
index 9d51bf52e99a..b3eba9f344ef 100644
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
index 32f96867635f..fde32010a66c 100644
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
index 158a533dfba7..d3e2316ff53c 100644
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
index 501c364277d8..86a03f02515c 100644
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
index 57bcc1299973..94c630a9ced6 100644
--- a/drivers/watchdog/nct6694_wdt.c
+++ b/drivers/watchdog/nct6694_wdt.c
@@ -21,13 +21,6 @@
 
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
index 2022b8fcc096..d752708c2a8d 100644
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
 #define NCT6694_INT_IN_EP	0x01
-- 
2.34.1

