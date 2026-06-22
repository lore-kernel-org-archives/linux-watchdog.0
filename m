Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3C391E52
	for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117079; cv=none; b=jFmAnd87GtsfSvfhPUTr4iB/cASDQaL7fZkKpw8PtXTtsvj9T0vATNF7SjJsg+u8XrCn/YsATdVCssClmhZKNSLEOR30sY02j6u1scS27qBOr8bt9UIsezkzPjE/5JHcnbrN20C20PaAPxpm/SSIEaOIu4v86cCG0XTL2FSjjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117079; c=relaxed/simple;
	bh=IZh5GKCtDAeQHoypwMtpST8EyXt54FkThS3vdNC4IWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gc5/YcHtQl0Vk1rSsYHDzVs63xtUiiT1yLXIyiYTTUgTJ1gkA+KHg4CQ8DVJWt9q/s0dTD37b9An2FvDyiOIL22wQbdhsUkcfbmLV4IibxE5ES3Ar30Vvc4T7f8lZr/huAWKx5ZQMBtsHpuH2L5epOYJG/eh9OXCqJ67eVXYEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbGijCqf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbGijCqf"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so31251505e9.1
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117072; x=1782721872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCw42dfMKoRdIXvSRtooW3yTtI3yB3GDP2Hqbg56URg=;
        b=cbGijCqftwqpsA+Q0/uztJILDjr2/7ecuY+iHqYnJSDgPzZbaghCfckuQAhnbKpt4u
         wTIRfQOz1+SotguACzSna3qCbFPhXDUFhw8mQ01wtbSq3DIJt4gmXwTIdViEZWluQb3a
         qnc2UCxKpWOS72UPsMdaib5nNPXCO9uPIajzHcSXlKeLi+6yBVQyQQUhhFEQH+gcbHzA
         wEMANgy3k4ESB3Ji1IzlR2pG9u5gEnPTGMn7yYDVkNSaOMal8xZ1u5pZ9eHSq3mN+TLl
         IjSnbHFJrKRE1+uIS0/QyXoNt77CSNuyR8AAU7X7xEM5frYYLRtTcRnZ2tOnnwnQXNjG
         vUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117072; x=1782721872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCw42dfMKoRdIXvSRtooW3yTtI3yB3GDP2Hqbg56URg=;
        b=HdWpsD0UiZ4grRpFxttrgFyFLv8oKQg7tGcyrCzo7jZpRypKhbXmvDtUkL8YBdX2Hc
         SZckcqZigUdlFOdglw+Nm5DJOZ+Jsr6A7apnZJEYq8ZyUDNGoaPk/fDTgIUTmYs/8vN3
         jy4lE04CQQzHSHe4q8ubXYAyWVdGuTUrTGagV246D+YRbYOiV+2kEQTcyq5Tc+ZYoWkj
         0d+rR1FJsaiblfmDwi9cv1XlUxLa49bIX8YHmOBO6iSqQhd6b4dWiPlhtScxr3Glsqjr
         8k9TnRe4Rx96I5sG2JyALZo2xq2w6cRosm6uqLjx+eVKa/6PLOPcsEa5JsrAglnMfMWc
         G2oA==
X-Forwarded-Encrypted: i=1; AFNElJ+o3KgMHVLWIbxf0/vAT2X48RKnIBPY0OjQ0m+P8kuvkF56KLnTmEJv+fimUoYwcmAn1PimbkPGHfsPu/mRCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwv/whAYWN5NEz339rQs9tcIRH3ckv50lb0aVlSupOpy/yDAMN
	HtbaAJA0pv4ha7NbishelfmZ2NzGP7jEdol+6/jyCJBTfcyWRpY20Wu/
X-Gm-Gg: AfdE7ckBE6S+xnTB1+VrZLXrbo32G/v+p1JfQFju4to4NZRTZzrgQpB3/VlGYXj+Ecs
	yD6mbqPfJnFEAW/8QagUT5/Iz6mek6UmvTPC/0TpTaqrav2UqmxTD0DAtS1rgk7EtU2G5KoH7HY
	W70udwO3gK2z4eS3E61vMzBepEz3uQxaR7d9g/+SzvQXbjYC/BP3NtrhlYmpJ9frffpz3XNpYO1
	PHIfiJw7/Zs9XmZoEAYGD2nTdDKevB62ooHiDrbCGOVIkZdyZGR79w+B6ecbBmN9bdc++wK6j3K
	aJ2IhEGPbFRIVmhuHci+ZcFSCfOe0cBPKIz5TaChYFsZ7aIzI9xNNS7DCwbcAATg3ELfgfricYI
	8md2eEI0M41uPTC/eNZBClhCjeLVH0ja52GM9p9ngFqw3U9nbO1NeHrelFZCDtb12Nkm47SqX4i
	AhCs4JKkErdEeij3gJp81NWsA=
X-Received: by 2002:a05:600c:c088:b0:490:c2a3:23d3 with SMTP id 5b1f17b1804b1-4923f59465cmr201609475e9.35.1782117072491;
        Mon, 22 Jun 2026 01:31:12 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm200809105e9.11.2026.06.22.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:31:12 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: andrew@codeconstruct.com.au,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	joel@jms.id.au
Subject: [PATCH v2 2/3] docs: watchdog: npcm: Add reset status description
Date: Mon, 22 Jun 2026 11:30:45 +0300
Message-Id: <20260622083046.3189603-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622083046.3189603-1-tmaimon77@gmail.com>
References: <20260622083046.3189603-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation describing how the NPCM watchdog driver reports reset
causes through bootstatus on NPCM750 and NPCM845 systems.

Document the reset flag mapping, the watchdog instance mapping for
WDIOF_CARDRESET, and the NPCM750/NPCM845 latch handling. Also mention
sysfs bootstatus reporting when watchdog sysfs support is enabled.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 Documentation/watchdog/index.rst    |  1 +
 Documentation/watchdog/npcm_wdt.rst | 70 +++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/watchdog/npcm_wdt.rst

diff --git a/Documentation/watchdog/index.rst b/Documentation/watchdog/index.rst
index 1cea24681e6b..ef29e861e837 100644
--- a/Documentation/watchdog/index.rst
+++ b/Documentation/watchdog/index.rst
@@ -9,6 +9,7 @@ Watchdog Support
 
     hpwdt
     mlx-wdt
+    npcm_wdt
     pcwd-watchdog
     watchdog-api
     watchdog-kernel-api
diff --git a/Documentation/watchdog/npcm_wdt.rst b/Documentation/watchdog/npcm_wdt.rst
new file mode 100644
index 000000000000..48f0c7920c11
--- /dev/null
+++ b/Documentation/watchdog/npcm_wdt.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+NPCM Watchdog
+=============
+
+The NPCM watchdog driver can report reset-cause information on
+``nuvoton,npcm750-wdt`` and ``nuvoton,npcm845-wdt`` systems.
+
+Userspace can read the latched reset cause through
+``WDIOC_GETBOOTSTATUS``. When ``CONFIG_WATCHDOG_SYSFS`` is enabled, the
+same value is also visible through ``/sys/class/watchdog/watchdogN/bootstatus``.
+
+The mapping is fixed in the driver. It exposes the SoC reset indications
+through the generic watchdog bootstatus flags and is not configurable from
+Device Tree.
+
+.. list-table:: Reset-cause mapping
+   :header-rows: 1
+
+   * - Platform
+     - Reset indication
+     - Bootstatus flag
+     - Reported meaning
+   * - NPCM750 and NPCM845
+     - ``PORST``
+     - ``WDIOF_OVERHEAT``
+     - power-on reset
+   * - NPCM750 and NPCM845
+     - ``CORST``
+     - ``WDIOF_FANFAULT``
+     - core reset
+   * - NPCM750 and NPCM845
+     - ``SWR1RST``
+     - ``WDIOF_EXTERN1``
+     - software reset source 1
+   * - NPCM750 and NPCM845
+     - ``SWR2RST``
+     - ``WDIOF_EXTERN2``
+     - software reset source 2
+   * - NPCM750 and NPCM845
+     - ``SWR3RST``
+     - ``WDIOF_POWERUNDER``
+     - software reset source 3
+   * - NPCM750
+     - ``SWR4RST``
+     - ``WDIOF_POWEROVER``
+     - software reset source 4
+   * - NPCM845
+     - ``TIP reset`` (``INTCR2[25]``)
+     - ``WDIOF_POWEROVER``
+     - TIP reset
+
+``WDIOF_CARDRESET`` is reported only for the watchdog instance whose own
+reset-status bit is latched. On systems with three watchdog instances, this
+maps ``WD0RST``, ``WD1RST``, and ``WD2RST`` to ``watchdog0``, ``watchdog1``,
+and ``watchdog2`` respectively.
+
+The driver may report ``WDIOF_CARDRESET`` together with one or more of the
+reset-cause flags listed above.
+
+On NPCM750, the driver samples ``RESSR`` and clears the latched reset bits
+after reading them.
+
+On NPCM845, the driver samples ``INTCR2``. When reset bits are still latched,
+it clears them and stores the sampled value in ``SCRPAD10`` so later watchdog
+probes can report the same boot-time state.
+
+The WPCM450 watchdog continues to operate without this reset-indication
+mapping.
-- 
2.34.1

