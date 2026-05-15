Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B24266BC
	for <linux-watchdog@vger.kernel.org>; Fri, 15 May 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835485; cv=none; b=fCqc/l1adghKSMErzMA952DmBSTSwkQW2ZuXbP4fSJw+SSS+aye6JTfglWOuy2eLeBAGCe64n4BB8Ze6N9S7wuDzQiD3sqPyrTfAOR6GzFmhC1S8Mhga8vyN1M+bRmlOHVQMzwF3Y4AnCq3laVSuZcdIE0HMufqRzJDq+tL11lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835485; c=relaxed/simple;
	bh=dyP4n9uPfOXLtZxIOJmI/uU/nI5UYjP6DCnh6DbN2Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XC8qy5UeiehWCfCWFXdu3KDKEOzl5sUP0GvLxRI6IFuLoTXnJVZjosVY1ic+yjaAa2muGVGrMxMnVzefD2Vi7hI3uSbBUjHNDo6oQYw4lbxF1GymAcEn8tUORc+Drms1xUAY5RSNOjsE+MiKU6r99cyZkBc25jn2X8nRlLgVaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwdJwuu3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwdJwuu3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2babfd18435so45276765ad.1
        for <linux-watchdog@vger.kernel.org>; Fri, 15 May 2026 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835483; x=1779440283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JI5rbOuDA7OsqPK6rS6KZm2RpgqeyURJ5czLB7dxhv4=;
        b=IwdJwuu3fbspKY4M46qwfE07A8WvFOSz4mMgl34oOxhRdGNhwzqBAkAzgmDJONgcWO
         /rfrYcNtRiGEnyAdrmqYH84LLCQeREjdpE0zwj5994JUXOoj/DAkMppV2j5NZuXIPy/Z
         CAFd7/E9sd+mjo+k5Nh9NvOcNjYIuF/OZ+Fisj83doFwXoSObViUphY97xLhYncQSPUL
         VVtx2JdUsemqY9xKlxSj8mwZz7fPIlHoJFxZea9sY4qW5mhQiYPX7IhVOIB7DpFKo0sY
         igrikZblRT7S9fnn8mpMayBfG/pL35ZYWfBObHkmDZ5RJKXklCdxeH9Bg0OAftjaCVKH
         F+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835483; x=1779440283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI5rbOuDA7OsqPK6rS6KZm2RpgqeyURJ5czLB7dxhv4=;
        b=AIbw/HMZlC1oeNXtAMfed146gKjUdAhk3YU3zYAw0I4+uoyOnUmwxUm27xZRZ3uH15
         m6U5vqzWGZ4NO0AoEtR2Tv6Z2eS2qfZ74kv4vBjBsq7C6c+naBmJh/1PWeKfZWfc5XGb
         98SDFEWc8qHoHA31Bgy2BZTEJpPYfLYUy+fcqy3C+d3IQSiXKLAMMQC0ZIGuS5itI+Sl
         liz68yFXXS2F7te6wohAN/EKyX28+9OYijqx2DOStx3jL08M2GLpubyo5UydDXmknN4Y
         tgGTC1P26YasX0pnYqOwsoUOBjpAYg/6lP+LV9I3luQ7YWb3BSmsu3i14ZPLAxDNlARG
         5kQA==
X-Forwarded-Encrypted: i=1; AFNElJ+f+8Cw4rm/r1NYhaawrY97dnXG0QwasxYcmEvKL5g+iz3ixeLvMno2v9uCEhCkt5wgAFX6OaCJ86pv4Vw1IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKFd3kIfLOqHFSBJAafz4ZzJla8U/eoD6JB9KRCNGzJ3Oj00x
	i69EZwnvPybKmAY2leeIKzJYRQH51SNcTdCXYc2rdCxOixWSeyJ8Nrcr
X-Gm-Gg: Acq92OES4cuJbaPITaFS+6EDC/U36WuRAgG40uTKuKmcX0YHiIr/kNL2Q1AMPajlWWh
	9pDm3vijqvj9UBggsGqsKuVHmwiiBdCniTKoBoEZkrJARX7A+jIOirIMqP4fgpw0YeDra55RPAG
	BYHz0A7xVt/To/gbQI6GJr0tEPzp/klIFwvV30j133g18J85bdzc+9XB/JoQs08lLde2vKirPit
	Fqk0EKNYqZjwvadRp7sD3/n8QSMC7i+fDJbLjslyi++meJZ3QC3rjCK2YEtIV2vrrCl6mNMaycY
	IJjCEFb0nhla/r2lygazw1PDQ0umni5Ys1zoEsMqfH5LCXDznneqtAFtL3EEaOShQPZnrB6tPHz
	3jblXqw6rHdkJ9JqxOo8BOmb694RUElukcEh0PhJTDiMjxCef01R+5bTu5wp1K345VYSqj6iNnM
	s7uGPLGH2H9VIZOdbf7F+MuqUuoOVCqGRD2aOgM2+jaoYP3LWORL9DRtJlpWS6BTCt2g==
X-Received: by 2002:a17:903:390b:b0:2bd:1903:6ced with SMTP id d9443c01a7336-2bd7e93cf74mr34268585ad.41.1778835482629;
        Fri, 15 May 2026 01:58:02 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6512sm52249325ad.52.2026.05.15.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:02 -0700 (PDT)
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
Subject: [PATCH v4 0/1] mfd: nct6694: Refactor transport layer and add HIF (eSPI) support
Date: Fri, 15 May 2026 16:57:45 +0800
Message-Id: <20260515085746.114361-1-a0282524688@gmail.com>
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

Changes since version 3:
- Remove redundant module type macro definitions from sub-device drivers
  that are now provided by the shared header <linux/mfd/nct6694.h>,
  fixing -Wmacro-redefined warnings.

Changes since version 2:
- Restore per-device IDA and mfd_add_hotplug_devices()/PLATFORM_DEVID_AUTO
  to avoid child device ID conflicts with multiple NCT6694 chips.
- Validate irq_find_mapping() return value before dispatching IRQs.
- Check superio_enter() return value in nct6694_irq_init().

Changes since version 1:
- Reworked the Super-I/O access helpers.

Ming Yu (1):
  mfd: Add Host Interface (HIF) support for Nuvoton NCT6694

 MAINTAINERS                         |   1 +
 drivers/gpio/gpio-nct6694.c         |   7 -
 drivers/hwmon/nct6694-hwmon.c       |  21 -
 drivers/i2c/busses/i2c-nct6694.c    |   7 -
 drivers/mfd/Kconfig                 |  47 +-
 drivers/mfd/Makefile                |   3 +-
 drivers/mfd/nct6694-hif.c           | 663 ++++++++++++++++++++++++++++
 drivers/mfd/nct6694.c               | 111 +++--
 drivers/net/can/usb/nct6694_canfd.c |   6 -
 drivers/rtc/rtc-nct6694.c           |   7 -
 drivers/watchdog/nct6694_wdt.c      |   7 -
 include/linux/mfd/nct6694.h         |  54 ++-
 12 files changed, 813 insertions(+), 121 deletions(-)
 create mode 100644 drivers/mfd/nct6694-hif.c

-- 
2.34.1

