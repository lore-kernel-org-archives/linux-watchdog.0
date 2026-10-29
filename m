Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264358;
	b=3p/5srlkCRz56T4QJ+cvNvkDQBbmARPWnQWDe1QrNfnZEBc8YsYj6kYq9KrE2tpBRJ9g
	 2hR4aH3afHo3BMSbyvxiOHc5WoaB1bMFKLtYJsnJsBQeWQJTUAuSERd0zPdm7neyzMpx+
	 Eh8Egrp0/9GypnDrQFC64pPPe9N6cRZdR5+9EMyJZ8OwrjbtIgYb9FX3JZJ8h4aXW+Rxn
	 Jsw1xw5rAz8zItkTOLVTBvj/elgRibmyBUzOXpD71TyhrnxDBCnA9w2xufTvmnGeJg2ub
	 jQRgEuIB+5NwZIeTqi7HbBy+Wo964NNpoIytihv3j2y2bfitH5VuNK7St7C14YCLAvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Pf8vm5N7CuEKM9qQ3heupZiM07wEvXe0DI+wIb1mu6U=;
	b=bdCeqlXo1CqtspQWd6LvfPNRfZgyJj2vBUJTqsFt8PApkhP4s8yYuKUQ1Iow2DSvDGTA
	 soSVJG5XW/4PCbdsPJUTnLw4tMFPP8djFzu1UHMHAwNF1y8EezOWv1t4c8bkyyOifbq3O
	 WLdaEC8jFy5rqSTatoHmvI84YRKLSWyMlx7LXocd3ZqegVbpWr030NoeJvjHoN1O5QGO3
	 J4R1DbUAettN9UjIuuMgUBBRrpiVVwUeUufesAzSbiXlEWC6YqsX/1WdRs75Lj8M15JWV
	 C+W+kLHX1EJ9Ict1qf/Uo3T/JjR0g+JdTWEjEzIPnkY6xlQr61OPY8M9LWSrDu7o7XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K2v0+3e3;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05090606A32A
	for <linux-watchdog@vger.kernel.org>; Thu, 29 Oct 2026 08:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05090606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K2v0+3e3
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35c76e9614aso2705302eec.0
        for <linux-watchdog@vger.kernel.org>; Thu, 29 Oct 2026 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264356; x=1793869156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pf8vm5N7CuEKM9qQ3heupZiM07wEvXe0DI+wIb1mu6U=;
        b=K2v0+3e3EDuDJKYcecldqmNA0dnBAMPZ/tCas/ggAI7Q9myljmj86Fack4anqlW9GZ
         6K3tBlVgm9GtLjXDQRpy1APoGWnXJD/B+KhPDsnfdH8ImOc/kzyXISK8TcWP4pESnqd7
         BjPKKidjfszlk4nbNXKT0twyD6mIg1P3oZH2WiSQY94SpMNwXwAj/eUSDQVeKotcyZ/a
         5fG2TYaBP2WgJShkf6EwW1a23l5WGLx/FAE7MQw1xOfYiT/Lv/qGw9s4X27pHmOgJyWO
         Bpc83FlmhfIEU9wky3diYsh98VQ4XH9A4Wb8sJqOAXH5pjP8pCdkFn6jTEVuZLdscTdO
         XNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264356; x=1793869156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pf8vm5N7CuEKM9qQ3heupZiM07wEvXe0DI+wIb1mu6U=;
        b=Y+6/A0xDxTq63/hCRWYu7RZsXfAbjv+Br96bLZAUaakmEpgvhDIHVyr0h9YnMR4V6t
         hd/FJyv4Fh6SV2/sKsWhq4ieZeYC1CfUtZzOaUD0RPe1JP8YLxaozmeCU/u+aS+bVduu
         44b2oTDkhABq6hyFQmrH2AvUMyAiKYW01bcEPF5DcbJKyVAauzUYuCzaG3hmpW4tpqIy
         Zr1V4R4iXepz1bfROOh3eW8RLQxUTpihq8pMKoa0jCscz8tlaKH9Fp2OfR5Tx5/6v1un
         rUE3fAQwp3XbkmxUwLEHKRPbYxxvDFMXsjM5pHg3dwlO3xtSZ3NE1agKWFRl4NSkQ5Ej
         0zbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHLPQyMgQT8KmNDP3LFwK2gtd6J2RRr0vwhuAGWZpbXj+k+GlW9fPEbx5TTcG4n71R3ykXZ1i7ifFA/b8RUA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKrLbx0oiY8wGOUGpTn0jky3i6CcztAX9RW1sTpEhmAgdPYxBlx
	DgfgdMbXkHOTZNN/ZwAIlAWIbMBlFpz1Ki56c6v/GGIVHg/VXPNKODg=
X-Gm-Gg: AYBFou1wEGv/CCyeyWaJVnU85hAHEWB6F/hXdGSSTIDh/NzI5llS7JisOm8zNiZPi/K
	R+JRu87gelGP5q6ciL0rqY9jjlofWwp6qjMqbsy00Ykp7jofVA1pdXFE4Vxxa/rTWl1Y0v/y7QW
	tZCsC93czzG+/S1AclUqEG6MC6anQcDTNfJaSpkDUPvtK73qJgLs7zbq5tbdIyQ1ajiRsEOUTxj
	TDG+o1ehhWqZeHck09JhwSFStmfGPLmylQkfSURCRMdqKbgseaiPKK1vaPiiRlRZRQxWb5nyub4
	DtlwkjaKgUQpVUH+l/SYgGCtEacm6LxM5VBQ+c15RS/B8cyW0OoxIIxhP1042IStda9+WN1isy8
	SUezLwkn3cGg0lLEfknJtQ4fN0SwnsLgYu7hbSOqYlmHhC2mp2c1OF/SaEXOm580Rp2Bb+uv6N7
	oOLz1mLQahLmsGNpS0iVcuqip1JsLpSIFkvoryPlEH9BCkZx+mc51tRp2b3hvy5yNImP28J5oeM
	nQw68ZvFlQsf8kEOEWLbq64Uv1zqtAR2W5Ib+cAhSShxyvohz4aUjnTIzoFopop6EMsQTZj2fd3
	oHElFJKtyjTV+TMzPsOfhLWEC05URQIcp0YTeDgzgyF38JxHxjQ/4xgvUx+6sA==
X-Received: by 2002:a05:693c:4141:10b0:36a:3453:a356 with SMTP id 5a478bee46e88-36a3453a84dmr1973145eec.36.1793264356042;
        Thu, 29 Oct 2026 01:59:16 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:59:15 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 07/14] rtc: add support for x86 macs in macsmc-rtc
Date: Thu, 29 Oct 2026 04:52:04 -0400
Message-ID: <20261029085504.3547-8-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
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

Make macsmc-rtc work on Intel Macs. The ACPI RTC doesn't
work correctly on T2 Macs, so the clock from the SMC is
used instead.

On these machines the time offset is kept in the SMC instead
of NVMEM, and the clock rate is read from the SMC too.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/rtc/rtc-macsmc.c | 126 ++++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-macsmc.c b/drivers/rtc/rtc-macsmc.c
index 8fe883066..37395c64c 100644
--- a/drivers/rtc/rtc-macsmc.c
+++ b/drivers/rtc/rtc-macsmc.c
@@ -2,9 +2,12 @@
 /*
  * Apple SMC RTC driver
  * Copyright The Asahi Linux Contributors
+ *
+ * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
  */
 
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/mfd/macsmc.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
@@ -20,13 +23,54 @@
 /* 32768 Hz clock */
 #define RTC_SEC_SHIFT 15
 
+static bool force_clkm;
+module_param(force_clkm, bool, 0644);
+MODULE_PARM_DESC(force_clkm, "Force CLKM Key, instead of trying to use CLKL");
+
 struct macsmc_rtc {
 	struct device *dev;
 	struct apple_smc *smc;
 	struct rtc_device *rtc_dev;
 	struct nvmem_cell *rtc_offset;
+	uint8_t shift;
+	bool async_rtc;
 };
 
+static int macsmc_rtc_read_clkl(struct macsmc_rtc *rtc, u64 *ctr)
+{
+	u64 request = 0xffffffffffffULL;
+	u64 response = 0;
+	int i, j, ret;
+
+	for (i = 0; i < 4; i++) {
+		for (j = 0; j < 40; j++) {
+			ret = apple_smc_write(rtc->smc, SMC_KEY(CLKL), &request, RTC_BYTES);
+			if (ret == RTC_BYTES)
+				break;
+		}
+		if (ret != RTC_BYTES)
+			continue;
+
+		msleep(20);
+
+		for (j = 0; j < 20; j++) {
+			ret = apple_smc_read(rtc->smc, SMC_KEY(CLKL), &response, RTC_BYTES);
+			if (ret == RTC_BYTES) {
+				if ((response & 0x7fff) == 5 || (response & 0x7fff) == 6)
+					return -EAGAIN;
+
+				if (response != 0xffffffffffffULL) {
+					*ctr = response;
+					return RTC_BYTES;
+				}
+			}
+			fsleep(1000);
+		}
+	}
+
+	return -EIO;
+}
+
 static int macsmc_rtc_get_time(struct device *dev, struct rtc_time *tm)
 {
 	struct macsmc_rtc *rtc = dev_get_drvdata(dev);
@@ -36,25 +80,36 @@ static int macsmc_rtc_get_time(struct device *dev, struct rtc_time *tm)
 	size_t len;
 	int ret;
 
-	ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
+	if (rtc->async_rtc && !force_clkm)
+		ret = macsmc_rtc_read_clkl(rtc, &ctr);
+	else
+		ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
+
 	if (ret < 0)
 		return ret;
 	if (ret != RTC_BYTES)
 		return -EIO;
 
-	p_off = nvmem_cell_read(rtc->rtc_offset, &len);
-	if (IS_ERR(p_off))
-		return PTR_ERR(p_off);
-	if (len < RTC_BYTES) {
+	if (rtc->smc->is_acpi) {
+		ret = apple_smc_read(rtc->smc, SMC_KEY(CLKO), &off, RTC_BYTES);
+		if (ret < 0)
+			return ret;
+		if (ret != RTC_BYTES)
+			return -EIO;
+	} else {
+		p_off = nvmem_cell_read(rtc->rtc_offset, &len);
+		if (IS_ERR(p_off))
+			return PTR_ERR(p_off);
+		if (len < RTC_BYTES) {
+			kfree(p_off);
+			return -EIO;
+		}
+
+		memcpy(&off, p_off, RTC_BYTES);
 		kfree(p_off);
-		return -EIO;
 	}
-
-	memcpy(&off, p_off, RTC_BYTES);
-	kfree(p_off);
-
 	/* Sign extend from 48 to 64 bits, then arithmetic shift right 15 bits to get seconds */
-	now = sign_extend64(ctr + off, RTC_BITS - 1) >> RTC_SEC_SHIFT;
+	now = sign_extend64(ctr + off, RTC_BITS - 1) >> rtc->shift;
 	rtc_time64_to_tm(now, tm);
 
 	return ret;
@@ -66,14 +121,20 @@ static int macsmc_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	u64 ctr = 0, off = 0;
 	int ret;
 
-	ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
+	if (rtc->async_rtc && !force_clkm)
+		ret = macsmc_rtc_read_clkl(rtc, &ctr);
+	else
+		ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
 	if (ret < 0)
 		return ret;
 	if (ret != RTC_BYTES)
 		return -EIO;
 
 	/* This sets the offset such that the set second begins now */
-	off = (rtc_tm_to_time64(tm) << RTC_SEC_SHIFT) - ctr;
+	off = (rtc_tm_to_time64(tm) << rtc->shift) - ctr;
+	if (rtc->smc->is_acpi)
+		return (apple_smc_write(rtc->smc, SMC_KEY(CLKO), &off, RTC_BYTES) != RTC_BYTES);
+
 	return nvmem_cell_write(rtc->rtc_offset, &off, RTC_BYTES);
 }
 
@@ -86,13 +147,15 @@ static int macsmc_rtc_probe(struct platform_device *pdev)
 {
 	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
 	struct macsmc_rtc *rtc;
+	int ret;
+	uint32_t clkr = 0xFFFFFFFF;
 
 	/*
 	 * MFD will probe this device even without a node in the device tree,
 	 * thus bail out early if the SMC on the current machines does not
 	 * support RTC and has no node in the device tree.
 	 */
-	if (!pdev->dev.of_node)
+	if (!pdev->dev.of_node && !smc->is_acpi)
 		return -ENODEV;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -102,18 +165,40 @@ static int macsmc_rtc_probe(struct platform_device *pdev)
 	rtc->dev = &pdev->dev;
 	rtc->smc = smc;
 
-	rtc->rtc_offset = devm_nvmem_cell_get(&pdev->dev, "rtc_offset");
-	if (IS_ERR(rtc->rtc_offset))
-		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_offset),
-				     "Failed to get rtc_offset NVMEM cell\n");
+	if (!rtc->smc->is_acpi) {
+		rtc->rtc_offset = devm_nvmem_cell_get(&pdev->dev, "rtc_offset");
+		if (IS_ERR(rtc->rtc_offset))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_offset),
+					     "Failed to get rtc_offset NVMEM cell\n");
+	}
+
+	if (rtc->smc->is_acpi) {
+		ret = apple_smc_read_u32(rtc->smc, SMC_KEY(CLKR), &clkr);
+		if (ret < 0 || clkr == 0xFFFFFFFF)
+			rtc->shift = RTC_SEC_SHIFT;
+		else
+			rtc->shift = ffs(clkr) - 1;
+
+		if (apple_smc_key_exists(rtc->smc, SMC_KEY(CLKL))) {
+			u64 clkl;
+
+			ret = apple_smc_read(rtc->smc, SMC_KEY(CLKL), &clkl, RTC_BYTES);
+			if (ret == RTC_BYTES && clkl != 0xFFFFFFFFFFFFFFFFULL)
+				rtc->async_rtc = true;
+		}
+	} else
+		rtc->shift = RTC_SEC_SHIFT;
+
+	dev_info(&pdev->dev, "%u clock, using %s key\n", (clkr != 0xFFFFFFFF) ? clkr : 32768,
+				rtc->async_rtc ? "CLKL" : "CLKM");
 
 	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
 
 	rtc->rtc_dev->ops = &macsmc_rtc_ops;
-	rtc->rtc_dev->range_min = S64_MIN >> (RTC_SEC_SHIFT + (64 - RTC_BITS));
-	rtc->rtc_dev->range_max = S64_MAX >> (RTC_SEC_SHIFT + (64 - RTC_BITS));
+	rtc->rtc_dev->range_min = S64_MIN >> (rtc->shift + (64 - RTC_BITS));
+	rtc->rtc_dev->range_max = S64_MAX >> (rtc->shift + (64 - RTC_BITS));
 
 	platform_set_drvdata(pdev, rtc);
 
@@ -138,3 +223,4 @@ module_platform_driver(macsmc_rtc_driver);
 MODULE_LICENSE("Dual MIT/GPL");
 MODULE_DESCRIPTION("Apple SMC RTC driver");
 MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_ALIAS("platform:macsmc-rtc");
-- 
2.55.0

