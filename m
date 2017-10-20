Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 0/3] watchdog: hpwdt: driver update 
Date: Fri, 20 Oct 2017 16:54:47 -0600
Message-Id: <cover.1508539271.git.jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

Three short patches to the hpwdt driver.

1. Add WDIOC_GETPRETIMEOUT so that user space can determine
   when to expect the NMI arrivial.

2. The SMBIOS check was incorrect.

3. Do not claim NMI unless generated from iLO.

Jerry Hoemann (3):
  watchdog: hpwdt: add ioctl WDIOC_GETPRETIMEOUT
  watchdog: hpwdt: SMBIOS check
  watchdog: hpwdt: Check source of NMI

 drivers/watchdog/hpwdt.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

-- 
1.8.3.1
