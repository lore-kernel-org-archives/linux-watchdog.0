Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AF3AD525;
	Fri,  7 Aug 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091852; cv=none; b=q59UufGH+5u0oBGVXv8v0TdfW8dr46wldlYwh+IZreFvx7DFtC//MuofHQ9lNRMYQR5ozJYvTsJAGPw/Ld/M2kGDhUmP/P+C31pwzSQPe6qal+zVRkY0gHTcyp/YGeE1J0/zNs4KfT5AxMZ6nbsC5eoOWcqb6L5firnas3A0vJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091852; c=relaxed/simple;
	bh=2qxE1QyEZ8of/xwk9djmWJcN0kDpoxD7oFHhd4dCvaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P4GDl+wjJ7alXkC54XnT3rREWby4CcTLaLLouIa6V30Y7TDNVHhjF37j9vxe+uLC/dJEI/v/nXd2Hg67yDPM2Fao8F0x/cKy/sxEXmNrPHWU1lo4cqmGFsw1cj/yzYH1WwkMyd5vicXJS+Ri+j6zEAYXF+U6f6Lq8GgBguz2X5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E4C251A0021;
	Fri,  7 Aug 2026 10:29:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AB63D1A001C;
	Fri,  7 Aug 2026 10:29:27 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7081818000B1;
	Fri,  7 Aug 2026 16:29:24 +0800 (+08)
From: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: alexandre.belloni@bootlin.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	lakshay.piplani@nxp.com,
	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: [PATCH 0/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Date: Fri,  7 Aug 2026 13:58:51 +0530
Message-Id: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This series adds initial support for the NXP PCF8525 real-time clock.

The NXP PCF8525 is an I2C RTC with the following features:
- Time/date keeping (seconds to years, BCD encoded)
- Alarm with interrupt support on INTA
- Two hardware timestamps (TS1/TS2) exposed via sysfs
- Crystal aging offset correction via the RTC offset interface
- Battery backup with configurable backup switch mode (BSM)
- Optional watchdog timer on INTB
- Optional temperature sensor via hwmon

Patch 1 adds the devicetree binding document (YAML schema).
Patch 2 adds the core RTC driver with time, alarm, timestamp,
        aging offset, and backup switch mode support.
Patch 3 adds optional watchdog support via Watchdog Core on INTB.
Patch 4 adds optional temperature sensor support via hwmon.

Shiv Prakash Gupta (4):
  dt-bindings: rtc: Add NXP PCF8525 RTC
  rtc: pcf8525: Add NXP PCF8525 RTC driver
  rtc: pcf8525: Add watchdog support
  rtc: pcf8525: Add temperature sensor support via hwmon

 .../devicetree/bindings/rtc/nxp,pcf8525.yaml  |   86 ++
 drivers/rtc/Kconfig                           |   26 +
 drivers/rtc/Makefile                          |    1 +
 drivers/rtc/rtc-pcf8525.c                     | 1366 +++++++++++++++++
 4 files changed, 1479 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
 create mode 100644 drivers/rtc/rtc-pcf8525.c

-- 
2.34.1

