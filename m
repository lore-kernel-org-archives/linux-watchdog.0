Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BD37CD39
	for <linux-watchdog@vger.kernel.org>; Tue,  2 Jun 2026 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372599; cv=none; b=t3/vVRgIwrckT5f2APOooVlGMyotO2TqvuwNrg/6IBWc5zOfKEDwDC+zRJSLp/u6A3AT3nVhPd5c9lsQh64NIxqyhgSmOBbi/Q649MOjjgloQjtWX8QPhasGLjkCthheebvD4brrDJbuyPsuM/R8GlzPQigqcvOUw/Z0Mj3rS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372599; c=relaxed/simple;
	bh=b8dClMO3fqopElGLyFWvnTYXFYmyQYf0jHbLbgu4/zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDcyRnXqBmSF+xpYHLBwmg7UvVvDG9Rpxg9qGARd2SI9m5/KbrQbEaH2Ii3ro3B84qPIleqDACn0r0/i0x1UG/jl0AMMSjpZvPAslYrTaXyQs6ZDAAbdIzdawImV8KMnbqsvbBDcH300ripOgO0w9IA/wurKaYectODAyAWBiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5v31RcO; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5v31RcO"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c858961a8efso885371a12.2
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Jun 2026 20:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780372597; x=1780977397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d817NOr3momH70wIRQ5A6GydO8RK9hEIFT/iNULbrzs=;
        b=M5v31RcOkxtlv6kaY3Uam3O5Ku2huXO/M1BRljRmp6fs0S5SbiXPDAIo6muT6ua9A9
         BK14rJojcQyImF+JPD3U8iNVpbZmCYdjUU4pvNtx8SEEMjuR1g9OWKc18XsYDSpyge+f
         cJ6RP6DjQBntn7JxIyMRZReBgyuCCQLrCYjATC86bh8woPWo6UK9Zc3jD9QuEdkpwp37
         VsZdD6/rmOhDrvcPgaN71rlcTwtJ3ejv7ynAj1dWX832REDmi2g1r0A5tFsi7NDavRGu
         hb5eL/LH+qj6X1tc17qWNLkq5be1pWCAPjkIJPEWx0oPHOn3wDoWBfIwSLz4y0obwTuh
         LZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780372597; x=1780977397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d817NOr3momH70wIRQ5A6GydO8RK9hEIFT/iNULbrzs=;
        b=ALli62O2WSztLSoWQhieHLzDrva5POimOQPFG/Dr13kfguLFzmEcCgxqTvBNmyz4Ku
         E6MiMfkfEOMoe8gEHMmUwEVpYE/Z4enPsmv5MahEC6YmoD8ZdxXkD9lpxdNnteqE3ovO
         PjL9SO7tXvYaH7WaIPDNf0mSjMg2gUB6HVV/Y0eYEbMwO6CYM2eJ78JbjIBxdQsElBKM
         tZ/h+rnaoI+RR2lRKZXVgErYVt0CB4G/wk1AsmQqesxbDPTo/eqJZxH91H4YSW0O+ZM3
         XLyg1Oq/VTQAO6S58r35KQfWooqUx0XooMQbgukbb0hb+/6k4jfVJlkmNSX/Jdsxvsw8
         7sFw==
X-Gm-Message-State: AOJu0YxOxkYs5k5b74stHnriqY0qRnmq3rNzSFht1zzaUXGtEqw6CCvp
	5oIvY51rv7J5kOycKXle1TW/xqg/Xt4LwfkJSCym5xDDOC3eoNXIv2qN6Pir8Q==
X-Gm-Gg: Acq92OH36d2FZxcx6OPfmjr3vHOuTBRvlnZXHFdo+BGgjPJmzdY0ocvmD3zZLLEd5PB
	k8TxHS3l30cshsvQHjprLmwiJzMTc6NKd9F/DfdkBn1wxZLbLqhYYxhjwiKsSoeiWHRR1/i7Mbn
	+OA2+5j50PMEtpILzR/RgiXFOzFhV3vUyRiPN3/gIYilAiZ7VwWr77VyHM/AH/9UnkoJmqBggIx
	+FzQkR7QsDjNzXcP0tUw67AZm3r7HCzTX2+bW8Ll1SBz6mTo17sAHgMLtV8F0pQeWdqzrW4p1fU
	VvmrocrOZemKY+niWAPRiDyCM9+tQBw7gK4pW+1ySDBn2+arAUs/9kizYuC+1zRtZhU+2ubIQow
	FuI08bQlSJvG/wfkEGf8subm7BPT0+Jd9Zkm31FDP8xtfHM1YfUCgW9fK8dRTThHOy9ljeoZdmx
	ZxTVvV8CSMdhkZi41QFOTlwPUNMNJlYWDRcHwSuyZqz11LJwJkFFo7NJhjYKGcLCyemDyZZp/fw
	5OkhC53hh1pncUxd/R9SXbbdgXG/8zToYf374NRBZ1zOg==
X-Received: by 2002:a05:6a21:4e03:b0:3b4:cd6:88b with SMTP id adf61e73a8af0-3b427fe5b05mr15201820637.46.1780372597306;
        Mon, 01 Jun 2026 20:56:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8583333e80sm8927633a12.18.2026.06.01.20.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:56:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	chleroy@kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] watchdog: pika_wdt: replace in_be32/out_be32 with ioread32be/iowrite32be
Date: Mon,  1 Jun 2026 20:56:20 -0700
Message-ID: <20260602035620.623085-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/Kconfig    | 2 +-
 drivers/watchdog/pika_wdt.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8319c503319a..7c5d6f642a96 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2040,7 +2040,7 @@ config 8xxx_WDT
 
 config PIKA_WDT
 	tristate "PIKA FPGA Watchdog"
-	depends on WARP || (PPC64 && COMPILE_TEST)
+	depends on WARP || COMPILE_TEST
 	default WARP
 	help
 	  This enables the watchdog in the PIKA FPGA. Currently used on
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 87b8988d2520..2d3c201540a9 100644
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
@@ -242,7 +242,7 @@ static int __init pikawdt_init(void)
 		return -ENOMEM;
 	}
 
-	ident.firmware_version = in_be32(pikawdt_private.fpga + 0x1c) & 0xffff;
+	ident.firmware_version = ioread32be(pikawdt_private.fpga + 0x1c) & 0xffff;
 
 	/* POST information is in the sd area. */
 	np = of_find_compatible_node(NULL, NULL, "pika,fpga-sd");
@@ -264,7 +264,7 @@ static int __init pikawdt_init(void)
 	 * Bit 31,   WDOG: Set to 1 when the last reset was caused by a watchdog
 	 *           timeout.
 	 */
-	post1 = in_be32(fpga + 0x40);
+	post1 = ioread32be(fpga + 0x40);
 	if (post1 & 0x80000000)
 		pikawdt_private.bootstatus = WDIOF_CARDRESET;
 
-- 
2.54.0

