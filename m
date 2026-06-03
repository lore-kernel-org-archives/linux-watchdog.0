Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CE3F54BF
	for <linux-watchdog@vger.kernel.org>; Wed,  3 Jun 2026 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780459375; cv=none; b=dELYYVaQtYGrgJvOqDadKuakYQqQ7A9sX77tUegFzdlJKblA/byJ2IV59UDOpu7piayKRrC67JDKEwSDHkHsFdGnlGR0Hy/gSoxVR0wZa0EMief6BQwTmtE1rgD9ABnEgaensqeHKpl3yJOTOEuCCSmtEPiB7ZtA3CSsi6gFpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780459375; c=relaxed/simple;
	bh=vHuCzqR8LSil06PO+XxUGSIa0ut9qcXEYLKuOP+NJ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDARdhjmpk91zGniB43T/QqjgwzHS2iYn0vKpt6Ty/Hd4d9ZY0zqjzazcTxjCWHASzp81kBZ0dVgCWIRkaSRV6870nx96qsf/aFVsJcf+nTEAUCsGTk/mSPGiLEmwz0cN/Wd/IbxEnS9gJOWNEcAPRvn8YCrUf3d380Wn9accWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYU3lcBq; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYU3lcBq"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91564c3a968so35265485a.1
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Jun 2026 21:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780459373; x=1781064173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPCyDDH9UNTEwkuwuBfe1Sw4ZubltM6kmNISCDS0HII=;
        b=rYU3lcBqi35q6Jl3zj0D2AxN6xA+6k+fieYh1nEinzKu9ZzkoFFUIYZzRHnVDtNRWN
         /cpIxz4vR4SwADHBMKUwR2uHgV+xqTrtYwAcWnyRCFMFX3mb6+bxjfeOjvuQPUFxKxFM
         f5aSyniXfCon4kGL8d/2MscMN9ViaFBwCZ7mWvFvG/BldL6UpGhU1yGfRUXpD/IDRW1O
         3vMctrG5eBgnsBFWSBV089Sq6INBTulnXJ4lvsMJOn1+C87Bl5JZXsur0i9V0n0dS3Ew
         gfxEaSCx3NQonWQtn8qiSxSQUGqtFPTzPHsHukTgwpw3rytmDRsTAFceiZh3ENvxLNe4
         hngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780459373; x=1781064173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HPCyDDH9UNTEwkuwuBfe1Sw4ZubltM6kmNISCDS0HII=;
        b=LGnRJZMu1tzOIFqvG1OLabdyNw5pe4V00Xsyu7mEtEfswmyvrFHBPwoFqti3tzMwci
         M5FwgpkbmQ/qk+J4UiqE23lGGu5zwNWVtVeYjtTrHeg9Fafy/ECfkSoWYhKB8NOEE/On
         KGK5+gcbzWGFTpYhedEtrqnFhjGud5wbGKeysPsvf0HUxZM3sC9ocehZwHSgTZs+ttgO
         6XndLMSPWl3XtTZIzvTGOFDTWHyWMgjHG/TCPWgliAKMQY9ZerGeD+1PzZwgNjud/D4k
         KfoRypgfWL9ihLcFGlDyCCFmpB8eKS/3fnBOTunPwdmvNAQrT0GDr+HEtKOqtCN6Fdps
         KUZA==
X-Gm-Message-State: AOJu0YxoO01WlUTfpOybHSbL8v7dV+8FUCfxZ2UEIDZ+OalnmeVvpjyN
	i4+fY1U7vC8qy7/lsXBMO0nY7wbeLAQiUKmUnCM6V4lykig3M1FQXO4QPOWyjALS
X-Gm-Gg: Acq92OF4vcWv5/hkzfjgGUb6KzxCMQUP2/WWaKhLkqC3AhuJk3mHZiY3nlPHOemY8lM
	wrdIJzL3sNwuKc86Wcc0xdKMQ25oGAzVXcxaTgklc9VE3bebcElhozR5NpARZOe17BrpFT9041C
	p+YOres9OS4P3Me+t35TYqt59KM8bfn3J8/fuk7wDcri4Yumt2v+fe7kcOL6rg3LsC4j44SePj5
	CXPSq6LL7+ObBnjDmfwl99JUbE0IUyMAAPDJgV+JtGuR1NNzPqMYgRCvO8eBJOltTASoVBEHWk7
	x+SSBrRDuRpXNIpDtvxPCS4G0+a1JbQmwfq0/keQsYw3tAKcqNO8Sbe9iBkEsTrMtfoJrhjaw0/
	/1GT+sbrmaa9FMra4bkP1aAHcfkifwvy8U7kWrp5FS9+s3OOmhM2T1kjfXSHFFkkRMO2/jLMa7t
	Uie3FJcb0MJ0XMlMvVkGGVMSkMNCoEMh1jNRcO5JVuGmN/QPZsQITZQGZmJNIghmAoQQKuE40jt
	OSA5ZRQlNC54wEa19DAwFCIyRcUw+x1iLNX38dj5UNlp/iyBniQUuqR
X-Received: by 2002:a05:620a:1a18:b0:90f:47f6:832f with SMTP id af79cd13be357-9158b72aef8mr200905585a.33.1780459373236;
        Tue, 02 Jun 2026 21:02:53 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3eea49sm127604285a.44.2026.06.02.21.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 21:02:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] watchdog: pika_wdt: replace in_be32/out_be32 with ioread32be/iowrite32be
Date: Tue,  2 Jun 2026 21:02:30 -0700
Message-ID: <20260603040230.318998-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603040230.318998-1-rosenp@gmail.com>
References: <20260603040230.318998-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ppc4xx-specific in_be32/out_be32 to the portable
ioread32be/iowrite32be. Also relax the Kconfig dependency from
(PPC64 && COMPILE_TEST) to just COMPILE_TEST to get build coverage.

Add HAS_IOMEM dependency for these functions.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/Kconfig    | 3 ++-
 drivers/watchdog/pika_wdt.c | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8319c503319a..855736eaca2c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2040,7 +2040,8 @@ config 8xxx_WDT
 
 config PIKA_WDT
 	tristate "PIKA FPGA Watchdog"
-	depends on WARP || (PPC64 && COMPILE_TEST)
+	depends on WARP || COMPILE_TEST
+	depends on HAS_IOMEM
 	default WARP
 	help
 	  This enables the watchdog in the PIKA FPGA. Currently used on
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 60a846cb3601..beb3ba1ab84f 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -77,10 +77,10 @@ static inline void pikawdt_reset(void)
 	 *           seconds. Valid ranges are 1 to 15 seconds. The value can
 	 *           be modified dynamically.
 	 */
-	unsigned reset = in_be32(pikawdt_private.fpga + 0x14);
+	unsigned reset = ioread32be(pikawdt_private.fpga + 0x14);
 	/* enable with max timeout - 15 seconds */
 	reset |= (1 << 7) + (WDT_HW_TIMEOUT << 8);
-	out_be32(pikawdt_private.fpga + 0x14, reset);
+	iowrite32be(reset, pikawdt_private.fpga + 0x14);
 }
 
 /*
@@ -243,7 +243,7 @@ static int __init pikawdt_init(void)
 		return -ENOMEM;
 	}
 
-	ident.firmware_version = in_be32(pikawdt_private.fpga + 0x1c) & 0xffff;
+	ident.firmware_version = ioread32be(pikawdt_private.fpga + 0x1c) & 0xffff;
 
 	/* POST information is in the sd area. */
 	np = of_find_compatible_node(NULL, NULL, "pika,fpga-sd");
@@ -265,7 +265,7 @@ static int __init pikawdt_init(void)
 	 * Bit 31,   WDOG: Set to 1 when the last reset was caused by a watchdog
 	 *           timeout.
 	 */
-	post1 = in_be32(fpga + 0x40);
+	post1 = ioread32be(fpga + 0x40);
 	if (post1 & 0x80000000)
 		pikawdt_private.bootstatus = WDIOF_CARDRESET;
 
-- 
2.54.0

