Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D14399890
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952666; cv=none; b=Xe7d1/2yXBghE+eFYVgWED5WOpGHjB6JnoXkjyCSZH9/Ddj+P1JxWwjdkqTLFqggSKbps/8AGRnDf9BTGQEszIHRnuTViqbkWe2tNuVJR2yhnGuCqD4oIjxTpD9HgINjCeGWmJ3je9FBUpo0rfsJh1fK35hKmqKgki4m+GrOP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952666; c=relaxed/simple;
	bh=bFta00Twt/E/RTqGANbDtk89KNmVRe6fyKVi3Knj4aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dX28Y+qINOBfYZavT7aljPHlulxRaXSPcfq2RQOQgpp4ILlAOkvOtIvkGbECBG4BS/FWCf2n5NuW87Q7Ve+yYMA07p1bjyk+FjV5dZwrx8Ft92NpQcnOz9HjID/4dGknMbjGjvaMKACOWUDVDNQt046M1dIJHbRamQKaykb5ZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0pnuAVB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0pnuAVB"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e053987001so47084977b3.0
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780952664; x=1781557464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYTDwqz4z09i7KEktqEP/nOWuMoIM8Ls9CTv9jln1cM=;
        b=H0pnuAVBebyn5ZqZFCft73WZC38VZVbYepx5gYVhJdPuQy23risPPe83ciQLiynUDz
         k0nnsYe10iMiP26JGgtqg342IgnMevIV7EnlSPR77bo9HftD45upoBMlc00iCC+8196A
         ESPHbSVn+ET7RVYOJ6i6ZvCcrwo5jfFZOYLYEKzPP5GmWp8EVPqsdlw4CpMDo6M2JfjD
         dHE4sy1Hv+LrcQavwnIfTQPKU0pajYDW4i3F4swM92Nso+RAOufiMPxGsN1ZCCWbvRw0
         dljOoW8SxZ1tyTO1JA538lSjXZHUlnoBuneQ0LXIRAXyYhKBfL/TrA07CY+eKddnvHAW
         f1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952664; x=1781557464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BYTDwqz4z09i7KEktqEP/nOWuMoIM8Ls9CTv9jln1cM=;
        b=hLiHMmHN705s2B6MGDXe43l6HOPXC2HBxSUeCA5SdMWhQN0P67WH/fEWZE+Qnew4b6
         LxEfuTeW/0NIWCXvWqy6obgooYrxUEva3/08ApnKBpKqzbhHcNXVv1mK/RxanL3XaUUX
         rKy9YK+PdU+w2uRs8CbzW0IKjOxxlx3q3qRH/i1sWbqeSM5hMV8FgYM0akHdgMt6UvvK
         Xum89fN9xHvG30Wuyral/RPzpf1L1wggOnEf+kF4Nvb1oICZYLosp6GjNghUS0zsMBFC
         VdtNfKpPIupjmbi4Y+9PU1qeubskewbmjB9HPFSzYy9vb1dI5Jf26fN3spAM3QGy2vtI
         bgEA==
X-Gm-Message-State: AOJu0YxMc1ScfwK003Hi0/a82xOkxN/d2ldhkp9UFqtxPGiG2gyIBu3n
	OT/CTEypBCExzfC77hqtPz9+K0e9g4PrWXOkeIHhCcJ7OoLdX38YRzTo71o9/1nM
X-Gm-Gg: Acq92OHKiOcSCUnmLdvJdbOeF8rUFZsjVYP7M2ZJB94dYnrrjkXVB83sfZyw4xjFH3v
	+4UI2R9VU6DGyv8noW1oeXPNl1VItI8vVQ71hkHBBav6V7DVG5lAG7+P8CBUolsqky+ny5Xqqrg
	dCqgys6JTN9X/iJ6D5A220BSefZaXKfMYKrpd1wziTai2co8yMFxvHWgsMQ0wEQYmqW+Eo17EmK
	wM7ZLiZCMZhgZ+CHhUjRiPv3QYkrC7LotND046/mJvUtMOM/+XN1zkpC+/4VFiNVn2zuOKv4S1k
	qzP7Pe+O6YISlJAGeAATDLD2YN8e+pd8ZytW2KdyIMuWwbxK1hv4Q/N7LQZnkZ9gKqUZQE5+s0b
	RQcOO4dkxdazSu7IjBhAryExJLXBC8aIqd9IT0rnWE97JJp4i/+vROyu+BFhJb6HC3q9S3yWIPW
	Cv02/XSC9FZ92sW7/ISVurrLiqFJEHr6SgTjUNtWQ3lKScrVpk6LzFMIwewLdPvUKnhd1eJ3wzG
	F8B/qDicTreJKOKHRwvtI22YdivTB2KxgWDIfutnY9QbQ==
X-Received: by 2002:a05:690c:650c:b0:7b9:f136:56d8 with SMTP id 00721157ae682-7ed53996c90mr133275957b3.30.1780952664090;
        Mon, 08 Jun 2026 14:04:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2399ab1fsm89468367b3.33.2026.06.08.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:04:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 2/2] watchdog: pika_wdt: enable COMPILE_TEST builds
Date: Mon,  8 Jun 2026 14:04:02 -0700
Message-ID: <20260608210402.31545-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608210402.31545-1-rosenp@gmail.com>
References: <20260608210402.31545-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace powerpc-specific I/O accessors (in_be32/out_be32) with
generic ones (ioread32be/iowrite32be) so the driver can be
compile-tested on other architectures.  Relax the Kconfig
dependency accordingly and add the required HAS_IOMEM.

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
index d567103ec5e4..e599aff8329b 100644
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

