Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7225E36D9F8
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Apr 2026 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106935; cv=none; b=MueG7CJXgNQey05lg+7HNgYwGxA6YDByiiiF+/CI+9tmYn8jwH2PDAuKt/rZgh1hNf5inThxxtW6FP+dtq3/NJNhu2j/CBHuMgNhn1IMWbCBRVKvMkcafVlyCaSwppvMyN1OWPOhaUdEhjwEq/XtjdqYuHEM91E1KQnSEldWZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106935; c=relaxed/simple;
	bh=HVoeiC7t5M0u01gC8ZWrF1ZSdndrYAnSTfQH8ssTUVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BDukQXCyq0Pb3lJ9cFCmtfrpY5pM15J5L1gCG/5EeIo9fd6mNn0DHRgicA0fL0rAzLXFMU1lUkPbWRQRez4sV9m88SBFKMSEyidEpI5xqd1taMtkOb/Bwfg9wA4CjtOLvVFViU9SnAoyW9qdGMbMPuTMACGQ6039EB95TdDBkyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aexidzYF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aexidzYF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d95017a68so220191a91.3
        for <linux-watchdog@vger.kernel.org>; Wed, 01 Apr 2026 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775106934; x=1775711734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VRhm1iFIbmMSuYjrKLq45KZf5lir66/ZO2vyNWUJDo=;
        b=aexidzYFvmt3YUxjauyrhjoe8SwDNNMksF916eZytT+OIQSDwv+fk8dut+4JpZJdf1
         FJ6tzmwntIrY5zt/ua4BlUIpJ2yr7BUK5vLmntaa6lM17aaSw1N65UnXEtmU4wQDChPa
         Hrp6o2VIXdXnE9X1zAmRB587COYxbWO3Rc6t3wbJcw9ZFYbhRbcLlz/1gfvPVHNJ9jLv
         jM2tr/bO/UPDAKTx81hkgJrfHdJlbUuBPh0WyDRibWzEJ7MRFDe4JIYLR0neXEaPYw7E
         VeLIu8Zo/y8OYP0GsN3gtGe2cj7cRi2CVT2rxGPmtrh0yvE2JDztD7sOsKR2AuvM/yjq
         ENRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775106934; x=1775711734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VRhm1iFIbmMSuYjrKLq45KZf5lir66/ZO2vyNWUJDo=;
        b=cnD0hLjTUqDhbgDdTEHc+9T0TipuRigT8uAcQp9LNiaaQ+lEGLXmUYW/ZpnqyhY3Un
         73nYNTdrg8uQkiCEyr1tHkZKVZcEQpil6Tsc6DU/vkqyks0kXCFv/lwvUNpzLabIobvc
         ghs1q3Vdc2plUEn7W3g/xUrkF7MGkHPy5aLlDA1mUfo6OfH8QEq3xWOSrjTJtIr345SF
         egL2zJ3poDFnqVyd7huX1a54ClWP1VxFvSBmlE6DTIOml7Ft1P5kMR2G8Ig7tko5rTVU
         eMf4CJIwc4ig1twqKOHzKNZFjpHfNz/hBi4Fgw3ux3bROhu9gnvwv5DDtM62OR4+Mamz
         EyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyCTly9oddkL4XtIVpJPDatF9G+WJG1rLr/MB5UEWtdpl4gEtHnH+5JIWJsqPA5HmeANaoPSMCUiOAQ/gGQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vkK+obETfz4CkzWoyw4PtNS4dpEY3Dx6Dm2mOtnq711lJIK1
	UEPL7WjdtEqzhxMZICsxOBbPrzuaf9CeN9pTzPucrOHyCFUvVnEn4azj1vmpYg==
X-Gm-Gg: AeBDietX7XKuETgP0kNwm35DN5gJj6hAOsJA6a2YQ8Bt5oV5F1W9eE+uqZHiiFakYHr
	l6tkpUdEvuBhI5gserJGt5bc36bzS4JqV5RAtEiTEfl0v9Z+Hhdg2xs1/ZI4fMJ5daRmw5Cb+1o
	Jj7h72mFngo/8panJjWgSuwOIsoVzZowyyn0+VMDSPU6wjIkOCwMdRBylNR+OdcCOnDKLVGL3I/
	5uAI83KKuC9dJ67tHldxPppAP3HJo0RzhiIGCwaM/qSvy9x/82h3Odf1pMF50JnxHZXcZnpP1vJ
	WfJ1dl2afl9Cln7khi2QwO/sYh2KZCpHmYI84Der5+8d6O1gd4MpNWLBD3y2z3TUHQurnP8uyup
	UT78bYGNdAtoIQRC6cTD30/ZjiLRj3FgfQTljWKq36ianvmzBZSe5R5BJAilHe90YhGSTmgAuim
	8UmSBEKRy5JLq7CWEmEMBV7t6dIagLsXYRg+6I9LiAhVYe/TdiLrYhx0LLHcEpBmQrNA==
X-Received: by 2002:a17:90a:c110:b0:35b:9c97:3d18 with SMTP id 98e67ed59e1d1-35dc6eae327mr5651672a91.12.1775106933827;
        Wed, 01 Apr 2026 22:15:33 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe93661fsm6902107a91.11.2026.04.01.22.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:15:33 -0700 (PDT)
From: a0282524688@gmail.com
To: tmyu0@nuvoton.com,
	linusw@kernel.org,
	brgl@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>
Subject: [PATCH v1 0/2] mfd: nct6694: Refactor transport layer and add HIF (eSPI) support
Date: Thu,  2 Apr 2026 13:14:40 +0800
Message-Id: <20260402051442.1426672-1-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

The Nuvoton NCT6694 is a peripheral expander that provides GPIO, I2C,
CAN-FD, Watchdog, HWMON, PWM, and RTC sub-devices. Currently, the
driver only supports USB as the host transport interface.

This series refactors the NCT6694 MFD core to support multiple transport
backends and adds a new Host Interface (HIF) transport driver that
communicates over eSPI using Super-I/O shared memory.

Ming Yu (2):
  mfd: nct6694: Switch to devm_mfd_add_devices() and drop IDA
  mfd: Add Host Interface (HIF) support for Nuvoton NCT6694

 MAINTAINERS                         |   1 +
 drivers/gpio/gpio-nct6694.c         |  26 +-
 drivers/hwmon/nct6694-hwmon.c       |  21 -
 drivers/i2c/busses/i2c-nct6694.c    |  26 +-
 drivers/mfd/Kconfig                 |  47 +-
 drivers/mfd/Makefile                |   3 +-
 drivers/mfd/nct6694-hif.c           | 649 ++++++++++++++++++++++++++++
 drivers/mfd/nct6694.c               | 180 ++++----
 drivers/net/can/usb/nct6694_canfd.c |  18 +-
 drivers/rtc/rtc-nct6694.c           |   7 -
 drivers/watchdog/nct6694_wdt.c      |  27 +-
 include/linux/mfd/nct6694.h         |  57 ++-
 12 files changed, 829 insertions(+), 233 deletions(-)
 create mode 100644 drivers/mfd/nct6694-hif.c

-- 
2.34.1

