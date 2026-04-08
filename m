Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2D1A6817
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Apr 2026 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775626257; cv=none; b=YyrNBeZot6pDCoq9ZFIah8EB8c98kYj0wUcs9N0iGQg4pMo1IhUV3/W6GGOerMT+bsoET/p4JC9BbB24jVvsUikf08EiSS4T4HKg7evqudbrkqfmoL751nPUltTolV5Tzx3POdTGQeCF1Su6Ga1gvhF2YfYL0EBNb017DzRFzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775626257; c=relaxed/simple;
	bh=2bvutzs7rtzWgmeamR13PJ6ItU9+5Cs+DqdG83Mabhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bv3Z57GdrzFlTmVhWMCvz8XZvptaN7buLxP5jG8y83Y+O0m1NJcqvHExagEN1om7+J45fzbCXYfP6I3oNgML0jZUPrXRBTlK4ukWEn9UGVwnPRQx/CNWi5FMDusGzfKoQbxxKhmtMx6VZgwldm/Mt23o4d3/bcSMp6lbf7dvEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8ZWPWMq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8ZWPWMq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab077e3f32so24405495ad.3
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Apr 2026 22:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775626255; x=1776231055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G261iPgwxdDm9fBlFNsCEO8KxZODyeiwStlQ3uz07JM=;
        b=V8ZWPWMqIM0a1pIwCeYyr7S7yp7Dco1DstdcGm8g9rxA29Efde1Roj1i5rcE4iBJPn
         fsHLZhnXE8c5cggjmHM42eT3uoMXlTw9pZqUvlB3J4qUmJGuMa8PihJgxOtHA7TJKbWq
         iczR2H/A2QgWbT1TY4Px2AKvigew9sNEWySTDTHoYPFVuKUmjdfKRNzOoAee4afwiNHW
         p2NCoIgnkBIC9MQKNROYRzF+hy7M35Rt4B4StKYoRWTerL4bCioqceGnedGlFVb1zLiy
         RA1vi4luuCyS44b25VMz0M6Q1tLapccjDStg10ebjYnZvPar3u5zqJ6xshcsqGpBIk6e
         8Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775626255; x=1776231055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G261iPgwxdDm9fBlFNsCEO8KxZODyeiwStlQ3uz07JM=;
        b=hhUWMNHmZD9RqEn5Y8RGfH5DEUXMimerTb0DgpbsNXtDWDHyZjS4O4YLbwp9468gBV
         d8KVpTC0IuP7/RcUlQhtef01sm9g1n7OQw3ttgAuARNrTwkZRTDQImf4+UT1NabpwKd9
         SKH0KxYHTHREVfGu4ARixfCjrhxTSVJrdK5CB+YSpcVEmKmF+ADsE98zJ+BzDFAx7fBs
         mTtafxUWhdDKJCctQaJ+XCkL2ARhOvNG2y/yJbaZrpDJvGEaL0BplXXjbTaw+FaT6ip8
         qYvQoR+Mn5GRV9wm22EDhv0lpNFoVX5YN/oFS5eLTNS+yMIw1x+TsZoCX2J01GeLUu94
         MZUg==
X-Forwarded-Encrypted: i=1; AJvYcCXMjCoo3EAQZ/pYugey1MPVYVzMHWwlevSd5llKGCXdpnZPiHHHZI/eTEUthM/sgx5weq2O9YNSx1n0AR3K3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9CWgXsvY+ipr8vUmsntgWJvs4aQz58vt0ECWl0sN6POS8jDk
	XK+ZUsaKr7jjVlhoLQadUP3U+c7ShV0TCofZyif+hanhohypzwEuJ/6r
X-Gm-Gg: AeBDiesl+NAIXQnxQbu7WmSmvwo3c2H8IQLfxhNKxmOcQ1TWvNT7lJYxpavAT6EZxpP
	UTb7rXrx0UnoLlC2vFYck+dyBNvtx8Wb7rIjckinN5GhIWjYKpM6+kpUt8phgZAmuqTrtq4LlAC
	Cd/Fa4YCzsJaxuS1w8XK+t49JyxQ4Ye38N3qRzg12mTP0jdByE3F2pUAVoogpr+p0ZCyR7KMu88
	M28VX7sxjDN4focy06ojCfF6nrKtDMFia63kPmt6Y847oaJoadDNIdDY+LElRe3jYGKdeXuAz0I
	gRkpfRnmoE4NzkBkt6Q8yJKWauPnO2dkfMxogq5aj3LKU+X+bwv76o63rtf1Y0QP+sf/UCQr/SV
	Nv+ALLRSEoOYWYiOY9nzgzsJm9jVbQi5O/zQZFPunXJEGvZRrZg0gERKw1M5CkxlgOiJZn4hUqR
	r3yQnyc33PTy6ZRxwFDss1lH5trp3kGXOvQ8xMuKBptCdOhB2y1zrc3cwdob7tFAaA2aY6qbquB
	r4h
X-Received: by 2002:a17:902:e78b:b0:2b2:57df:264d with SMTP id d9443c01a7336-2b28178c3b7mr208603985ad.33.1775626255168;
        Tue, 07 Apr 2026 22:30:55 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d098sm181673475ad.13.2026.04.07.22.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 22:30:54 -0700 (PDT)
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
Subject: [PATCH v2 0/2] mfd: nct6694: Refactor transport layer and add HIF (eSPI) support
Date: Wed,  8 Apr 2026 13:30:35 +0800
Message-Id: <20260408053037.1867092-1-a0282524688@gmail.com>
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

Changes since version 1:
- Reworked the Super-I/O access helpers.

Ming Yu (2):
  mfd: nct6694: Switch to devm_mfd_add_devices() and drop IDA
  mfd: Add Host Interface (HIF) support for Nuvoton NCT6694

 MAINTAINERS                         |   1 +
 drivers/gpio/gpio-nct6694.c         |  26 +-
 drivers/hwmon/nct6694-hwmon.c       |  21 -
 drivers/i2c/busses/i2c-nct6694.c    |  26 +-
 drivers/mfd/Kconfig                 |  47 ++-
 drivers/mfd/Makefile                |   3 +-
 drivers/mfd/nct6694-hif.c           | 634 ++++++++++++++++++++++++++++
 drivers/mfd/nct6694.c               | 180 ++++----
 drivers/net/can/usb/nct6694_canfd.c |  18 +-
 drivers/rtc/rtc-nct6694.c           |   7 -
 drivers/watchdog/nct6694_wdt.c      |  27 +-
 include/linux/mfd/nct6694.h         |  57 ++-
 12 files changed, 814 insertions(+), 233 deletions(-)
 create mode 100644 drivers/mfd/nct6694-hif.c

-- 
2.34.1

