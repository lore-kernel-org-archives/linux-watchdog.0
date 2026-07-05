Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC4380FF9
	for <linux-watchdog@vger.kernel.org>; Sun,  5 Jul 2026 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260075; cv=none; b=BGevywcJiXkD7jiZHGL4Il81/7q+nsxKOvoGT0PzhFZ+X7tYzXhOvzMKeejx7VFQlAfE4OCVyYSmZSCLFTqY0lZ7OkHgwnXS4MmYnNnUCCI60kUIpYJorv5tVRKIsQjZ40VAGgGcrWvB+0/IM7WcTkJudJUhaNkxybJWLXzYMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260075; c=relaxed/simple;
	bh=04e/Vb8TzD7k0lpyz3v8T9K3xjbwU9F9Cf26pX1gqJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYsJZFsQea0Qn+eTysr8TwcGaocQr7ll3UgCmlZQMtsx/kTOplnsZmsmF265HyGLWD185jxeTfSyquoVUevs+7kg79qFOMWWTmKCOL++0c+25kOM+/SsB3KSgCQQJD5rBJsrCfUifN2OFw9tx4wUp0HVYdVdZnU+ObvDVM4axmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTdxycbU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTdxycbU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b966dd74so6789355e9.3
        for <linux-watchdog@vger.kernel.org>; Sun, 05 Jul 2026 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783260072; x=1783864872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+Rc67BgTH3+EnF6kyABEC4BScrr4lbwf75koOQCx0Q=;
        b=KTdxycbUKcy/R8RquV/zQ8XRFnOLkVXXNp/4iz0H6hk1DvbWdDCQG7CMBAU9AG/Yyp
         JjuswuJc4GMdeRMm2xxXHVF2n7IzZXY7FJqsixMzRwA5mmkoPhATWOCEgjLsv85ltEbp
         xpSY2Rm1wRIWWfNDhWCedwPTDJRYgJyxg/U+CWqU5KpPJq5+cA9CsN+s1gkt+xCoLGWG
         pscs5z+GA0aEr9xB+UlJQQ/lItvv6KfoArZU6aj0C47GfNr6IGr55uMn2L+63T2sXV3P
         P4ZqQgcBcNSn1kcq+lvB9l8n2Y3uwa7kDst3ExYjepXw1henrWtXi1X6UjGeqiT/qkOx
         6h0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783260072; x=1783864872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+Rc67BgTH3+EnF6kyABEC4BScrr4lbwf75koOQCx0Q=;
        b=M3TCfZFGke4S3vrMBVeJbl56wA9CZd9PEHDbE+3/0WPSHFSVTVTfUUZZbJ/lawts3t
         zwTPqiDLMXne2HnIBusKlN07qpJRZOO0exJshLqK5HTHodaQORLq2xPGuPdgM32SPGcC
         Ke0VUbn2nWH15T+82gtxPQia1KWxhiISCgWPv3H9UMdrLvXyLVXwuBGf0QdBzT2soPLJ
         5D6W3+7JYbIKSvVy5vf9JSU/hINC8+kAXQmorDyMBdDcp/GGVPrz/JWSjVQggZ1P+EEX
         qBjPO9ikZO5eE7+cesJiF4ELI+GchB70ZhlMF9tRDTCIDLpNT+f/b1h362PFMhjPGSPV
         uegQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AK1KV85dXoz0Nb2uw9NIovWRESrCm6GgjyBoCOOgz0I9NbHWvtPZ/Bb3U9japTQbyvYLX7ySk5w4cFRnTKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MylJNWgXQcquIjN8b28Ymgw12yor8DW6tn1e+8Zs6/n9zMDb
	pTya1f9HbpKs9NRvoUzboQeP2T+TtB6G9IppF1xRT1eNcWz5hzj6Fb3v
X-Gm-Gg: AfdE7ckPyRAFoewHqWFv+cXwDhVLtV4XVnfJ44aP7i9IhlvKWkUgMVFNtFG9bM0UBgl
	j896BJgK5WWcxmryzgYlaj6YF/Of5hzrW4okLBQnzhAmnrMH7WNO5V3LvzhR80EeipLFtEu+gys
	PDL/XKlac5reRM0NPvX4lmBb0ZRISTYXP2lraCq2niOZii+yc8r1Ki+ongNKNli1aKN9/Q1UphD
	7Z0N0ud0qBr20kH2OA9ZobktegtKcA0epL8mkRh0mNmT3pg1v8v7OIiTaNo3yLxNrL5WksMuqYz
	vehcJBBnGB0bxf6gVi/SW5XbPbWsdO5X+Xqlpz0YqOS2jJfQGV/klRCGgNI+9ZNIvfYKmNvlGSI
	WvTVRgkAtDHqcQJ8xoJm9HY8URrms5O6NWALfRSVHL7QXfjPKmUPDTXtNFB2Vre0UrxHl58vpKO
	1FovV7GSAwKbUKXvxzjXM3SxQ=
X-Received: by 2002:a05:600c:13d6:b0:493:b771:ddf9 with SMTP id 5b1f17b1804b1-493d11d076amr45112645e9.1.1783260071622;
        Sun, 05 Jul 2026 07:01:11 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm275911115e9.10.2026.07.05.07.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 07:01:10 -0700 (PDT)
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
Subject: [PATCH v3 2/3] docs: watchdog: npcm: Add reset status description
Date: Sun,  5 Jul 2026 17:00:59 +0300
Message-Id: <20260705140100.1543486-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260705140100.1543486-1-tmaimon77@gmail.com>
References: <20260705140100.1543486-1-tmaimon77@gmail.com>
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
 Documentation/watchdog/npcm_wdt.rst | 71 +++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/watchdog/npcm_wdt.rst

diff --git a/Documentation/watchdog/index.rst b/Documentation/watchdog/index.rst
index dbc702b31a43..eb9e76275fa0 100644
--- a/Documentation/watchdog/index.rst
+++ b/Documentation/watchdog/index.rst
@@ -25,4 +25,5 @@ Driver specific
     hpwdt
     ics-wdt
     mlx-wdt
+    npcm_wdt
     pcwd-watchdog
diff --git a/Documentation/watchdog/npcm_wdt.rst b/Documentation/watchdog/npcm_wdt.rst
new file mode 100644
index 000000000000..cdc45ade9e0d
--- /dev/null
+++ b/Documentation/watchdog/npcm_wdt.rst
@@ -0,0 +1,71 @@
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
+On NPCM750, the driver samples ``RESSR``. When reset bits are still latched,
+it clears them and stores the sampled value in ``SCRPAD2`` so later watchdog
+probes can report the same boot-time state.
+
+On NPCM845, the driver samples ``INTCR2``. When reset bits are still latched,
+it clears them and stores the sampled value in ``SCRPAD10`` so later watchdog
+probes can report the same boot-time state.
+
+The WPCM450 watchdog continues to operate without this reset-indication
+mapping.
-- 
2.34.1

