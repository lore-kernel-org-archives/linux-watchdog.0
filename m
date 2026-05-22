Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073E357CFB
	for <linux-watchdog@vger.kernel.org>; Fri, 22 May 2026 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492373; cv=none; b=Djm90YCXrJarPJNuj8HIt16++vlOPc26MjVs2K3eI7Gm4VYncbGZY3H2AFTnjxVr4iqBc9n7LMNdnmiy+SB/a9vzF2MhuHdjmLBq3h0DJu/xkFeWaLpXZ/vZB6BGTMKQlg6PaCpxLi8Kiqe00Jpd6B4eS1Bac5OsTAg63neeZ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492373; c=relaxed/simple;
	bh=hARffAEKbjRoHH1/Qsl5IruxaaDH9YpycQv+2tbQQiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E65L5sTBL0vRr91971KBpBKSYqpsAA5h3TwubeA1csr6hOUv+PUFSPF7TON+lE0LP9ahWuip7Z6+m0/rE20+NxK7aWYWAufPD6AB9ifvC9JGpPMhAget5w3+QxtpSE0n6WwrA1wryIujlovq449nQ7kJh5+0U+EVcvSKSKEWvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAqUbdYR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAqUbdYR"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-83d31ac4017so3932649b3a.3
        for <linux-watchdog@vger.kernel.org>; Fri, 22 May 2026 16:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779492371; x=1780097171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKC9/Prd/89ZXNMx/5tDvvj+DNnxm/w14WIebn7H1DA=;
        b=jAqUbdYRKFy6iXEqK07eVro2BXsCFZHfLMNmgQgH7TtGOcUq02Iz355i3m3QglZ+E9
         aOAkw7wdLCemx+gog+J4+7Smml+bU1rbUpcRium4xsDSzfKRj7J+nqtbdXfgWQVx0ovH
         O7JRa9NpXSXsvSYLOuwdpp7tBXFKs5yGoW+ReocBhSpSnM04AL/FlKs27Dla7C7swrzP
         5DkFPlAlXVNjuN90p7ruX7yIzpbreGfClAq4DYUds/bNI0KsWzfHUkDCUanQWkYnrl5H
         4lfvndsnIkSOFkjQ+Z0xLAZ6iOSnvf59e6myR/IuowL/HN6l20fptprmJFvIpsXMyO7l
         b6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492371; x=1780097171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKC9/Prd/89ZXNMx/5tDvvj+DNnxm/w14WIebn7H1DA=;
        b=HVJyUvw/t7yuqpyXI9nMKBbuT92car05UX7djuUhDf6NlNerjSbJRKsuM5DTin1+gX
         VkEnecRqwNo8++NKOlJbjhOfqAJ4OHd/W0DYuY4coNzhixnd9BkxfPVIUy+GHNyjINGA
         199TcytIBIqPjHSL65W1Q0o0OrMc/zeQOjBniaOyPuaPLIkEsj6z9NxHALaQdX6F19BM
         ZVrjnsjMJE+82Txk/KmMG3z+m0V8uWPMpIAFQTxM4TaYPdecO1DaJBfgFlLF/5+LgT9w
         qhG6E947h+fShaxyFZqzyR+ermriM3BKR685nf0QUESt0PAMeeYpvNmKpgzXGJsv+EIs
         4YOQ==
X-Gm-Message-State: AOJu0Yy8wvzsfVC14SXk+zkQUMcv8Xcml58KL4tcqdG3/r0W9GzFU/tB
	mZ+YKXWoJA//Hq0AdH2+DB2n7rjaQQFru5R3a3Wcrw/OHSD2VCpF9+Td2TZUlA==
X-Gm-Gg: Acq92OHZLcqfvp0ij6BRrPEyaD5VRAMWvg1L75bVsJT6+H/m6Ju+yzE7hEg93EET0/p
	5ac8xwg5EhVqApzKNiiR2IBxzideQJKt7Jq0ZnjyMoVAKhkMaow8fVi9J1R8BjfTCKtY9shE0ag
	y3+f0leDh11+Zbk8wEqD7g+bNpwKXDnbuKF/ABgpJD5X6dvejAtBy4Stp9At495CzOmL9da00WO
	ct6CX8kDNJrk8v3CV2aofxKSMHXE39Sbnq6ymKYgYWe8uit6XNqa/IuHhXmma3pdvGxH7G3nblf
	UvZiYu9ILizV7IeLfRAWQxFIBQBlQEU4C+yO9/0+ZnuUGGZORWy8Vp7Za7KgndWGcQL5k3E2WCB
	pGS1PeWLtUhA5zy5BVAFeKf+LwEISOm3Ag9tCdVzhCYedKJViwH1/pwT+zVrT1Q2ZvT0W0Gnb9M
	Ou2gy/TWCmw1+NMmRbhZAA9uWrapwV80T3Bbz9Je75sOaJ8Jxp7lkoebJlMmmzotBmSVcCJzKun
	/lioWuGMqRC76kfoRVgvgchPMZdyJrzRsc=
X-Received: by 2002:a05:6a00:a10:b0:82f:44dc:f85c with SMTP id d2e1a72fcca58-8415f693e49mr5644623b3a.34.1779492371344;
        Fri, 22 May 2026 16:26:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac99b0sm2898323b3a.4.2026.05.22.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 16:26:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] watchdog: ath79: modernize and broaden build coverage
Date: Fri, 22 May 2026 16:25:51 -0700
Message-ID: <20260522232553.44748-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two cleanups for the Atheros AR71XX/AR724X/AR913X watchdog driver.

Patch 1 splits OF out as a hard dependency (the driver has always been
OF-only) and broadens COMPILE_TEST coverage from ARM to all
architectures, so the driver can be built on non-MIPS targets.

Patch 2 moves the driver off the legacy miscdevice/file_operations
interface to the watchdog_device framework.  This drops ~100 lines of
hand-rolled ioctl, open/release, and busy/expect-close bookkeeping in
favor of framework callbacks, fixes get_timeleft() to return seconds
instead of raw clock ticks, and properly propagates -EPROBE_DEFER from
clk_get().  nowayout, the timeout module parameter, and module .owner
are wired through the standard helpers.

Tested on an Archer C7v2; sysupgrade watchdog handoff still works.

Rosen Penev (2):
  watchdog: ath79_wdt: select OF and COMPILE_TEST
  watchdog: ath79: convert to watchdog_device

 drivers/watchdog/Kconfig     |   3 +-
 drivers/watchdog/ath79_wdt.c | 248 +++++++++++------------------------
 2 files changed, 76 insertions(+), 175 deletions(-)

-- 
2.54.0

