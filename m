Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F393DAAB2
	for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884507; cv=none; b=jFs1rR/Ura42jKHibrnwGy09bDxipKSpOfooP9SZ636xq0Z03AXX5Qvp2qfcqp3C0Vb8vkFXcOHcL0dSgYSylA5SGz2l36eYX5hvLCo8IxaA6sRN699mED1dZsV8vF9BWlt8I5ppVJTPvWT1V7Gr47+0y/FpO9wf4ojDVWRsjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884507; c=relaxed/simple;
	bh=ZwuJP6cujNSw138tlbCvqz+mNaAX3jOOr7oM5fRA97c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r91eoJRprAPwS8DrFRw+ga9ip1tuQp/D8ZUChTsLYVtamw5C6vVCQTvIwzkoAladdeZPAs1IL4XHstqriaDdleC3qoByAm1VcPjJoxPmNbI6wtIzwZvdgp4qA4GnFoWjoBLPngdYS+Lin5xl7vQTyGkk/UStlFOm0Iiaqx8MF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPRGXvZC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPRGXvZC"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848643382fcso204650b3a.1
        for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784884505; x=1785489305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XWkx9sDw2l9Oj12uX51/QV+iNNPhdJGAXVY8YBNeoPI=;
        b=JPRGXvZCAKmxNp+DqCfkLPrZwUNJUja6IpRGHofQPp6zcmDK9EibMMQk+nQOAyMf9s
         pTaB2ojFjezHt0zZIOVH2+stgAS6+3aqdm97v/QknM99ZmyzBAVwjokPcQTKroB+Edag
         miJd5Jil+TgyiwuTD8lawwaEOchc6g1UvYt0L+2ecd3qmW+P1R6o+6Z4XrYEK7BwbcUK
         f60tCAjK+3MXfg3ZVdlkXqyQNhZCNeqaA9QS8QrWJur1GWNAwoVzY/7QO6afCC+cOlut
         M+SXbo1ShweuZqM0rSyhYsqG0K5Sq+UsuoTIfLuJBlyK1RWk0gIKvYzLRvkutG9RPNMp
         HfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884505; x=1785489305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XWkx9sDw2l9Oj12uX51/QV+iNNPhdJGAXVY8YBNeoPI=;
        b=kcQ2PQhlWVJCVvDK8DBTdzAtHRKMKqPUEuFKREXJI637Qi8kY2Nhbb9XzT1NUEGYXd
         nAbBEcV/5MlNfrn0W4fSpVo/A7TQRWOTrs/NdQA179V2M98lx8tcAhOYw0J3rz1RFwCE
         9eSboo59gnrx7XPEO4iaNnpI5D6KuAC0jQs4S0zwssCogGWvRus+yvmKKCthoRvHmDMw
         e6LZVpEdxM1PYZwVP7iNUHN7FgGzYiz6DCl2eHKdhYnDuxCBUDw/XPryFo/hhrMKe15N
         p4YJBJx6eDjiL0eFGn8JvvucBRfJEpk+flG/GcImUDC4/3UsNzvWGDMgWagB1sXFQL3y
         nVrg==
X-Forwarded-Encrypted: i=1; AHgh+Rrsbq/E9oVXh8DnEUBL1CvJWDsFjUkJ3tGAkB/ksVQk14YzxC/7MQcDxylWcYnVIK9uVS4b7CwDdK6NYaj+JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJ/3pFvHM6SKsA4EFyosZm130qoZKSCcl9lcMLVHXtvIsx36Z
	LbcVKNAbR/n19Je7CstxzlLSrTo0SbFhzR6sjOVmUpIvVU7wflISGJpy
X-Gm-Gg: AR+sD12OvQMDYrrWVJFT6WekSq3xyIBF+1CVbB/q6pyTvbwQyAaGpYljRSNLewACq/v
	WoLMaAP2NV+b/lo1hGGV/QTw2Ubjbq/CeEPibNZShowj39ut+V6IFrgfLerhdfOMG3EGD1kS577
	kqmXui4F96q3ulNk2z/Ce1/sQatbYkzxP/zn2RcIUlxiZQJ3rrsdbWYlCOArn+1x6a2FZ6geBgi
	qg+ks8zIZEnrcHmqe9g+gZWQ67jl4ipJRNQNS2zYWl4X/koMklnTMsGBkwGJn7jaH983RcX5Kq4
	paVxU1mhh10cwx+cgWpY7DaOgDEoOxKrtpmtZUJ7eRoymrJbG6ejRLBNZ6niZzdUby58/cdLdAB
	NIQeuUj68ejcMi+HgLX41Flpy/2go2Q8XTChPaQKQUBEFfXtCnslwmYT23xUTryZbuWQphL9Po9
	h4bK7ImtcGYe5Il1ljTDf+Bkobg+xrU5CcI+KObZCAbROiM4sfmc0whuDiyXj8
X-Received: by 2002:a05:6a00:1bcb:b0:848:587f:8acc with SMTP id d2e1a72fcca58-84e2c20833amr7114627b3a.54.1784884505358;
        Fri, 24 Jul 2026 02:15:05 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237c3fsm4410519b3a.9.2026.07.24.02.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:15:05 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v2 0/3] watchdog: ma35d1: Add support for MA35D1 Watchdog
Date: Fri, 24 Jul 2026 17:14:24 +0800
Message-Id: <20260724091427.1689980-1-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces watchdog timer support for the Nuvoton MA35D1
SoC platform.

The MA35D1 watchdog timer hardware provides a programmable countdown timer
capable of triggering a system reset upon timeout expiration or generating
an interrupt to wake up the system from low-power states.

Key features supported in this driver:
 - Standard watchdog operations (start, stop, ping, set_timeout).
 - Boot status detection to identify watchdog reset events (WDIOF_CARDRESET).
 - Power management support including suspend/resume and wakeup functionality.

Series breakdown:
 - Patch 1: Add DT binding documentation for Nuvoton MA35D1 watchdog.
 - Patch 2: Add the watchdog driver implementation for MA35D1.
 - Patch 3: Add the watchdog node in the MA35D1 SoC DeviceTree file.

Testing:
 - Tested on the Nuvoton MA35D1 development board using standard watchdog
   test utilities (e.g., watchdog-test from tools/testing/selftests/watchdog).

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
Changes in v2:
 - Added `watchdog_stop_on_reboot()` and `watchdog_stop_on_unregister()`.
Addressed automated review feedback (Sashiko AI) and reviewer comments:
 - Remove redundant 'struct device *dev' from driver private structure.
 - Add ma35d1_wdt_wait_sync() after writing WDTEN to REG_WDT_CTL in
   ma35d1_wdt_start().
 - Preserve wdt_dev->timeout when requested timeout exceeds hardware maximum.
 - Replace dev_pm_set_wake_irq with devm_pm_set_wake_irq.
 - Set WDOG_HW_RUNNING if watchdog was already enabled by bootloader.
 - Fix IRQ variable type from u32 to int.
 - Removed unnecessary `select MFD_SYSCON` from Kconfig.

 Note: RMW operations on REG_WDT_CTL have no runtime side-effects on W1C
       flags as IF/WKF are only utilized during PM suspend/resume window.

Zi-Yu Chen (3):
  dt-bindings: watchdog: Add MA35D1 Watchdog binding
  watchdog: Add Nuvoton MA35D1 watchdog driver support
  arm64: dts: nuvoton: Add WDT node for MA35D1 SoC

 .../bindings/watchdog/nuvoton,ma35d1-wdt.yaml |  55 +++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |   7 +
 drivers/watchdog/Kconfig                      |  10 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/ma35d1_wdt.c                 | 358 ++++++++++++++++++
 5 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,ma35d1-wdt.yaml
 create mode 100644 drivers/watchdog/ma35d1_wdt.c

-- 
2.34.1

