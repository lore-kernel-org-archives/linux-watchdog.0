Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 0/3] watchdog: hpwdt: driver update
Date: Mon, 23 Oct 2017 16:46:15 -0600
Message-Id: <cover.1508797127.git.jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>


Changes v2
----------
1. Re-order patches

2. Provide additional details for SMBIOS check patch.


Three short patches to the hpwdt driver.

1. An hpwdt SMBIOS check is incorrect due to a change in
   the specification and firmware.

2. Do not claim NMI unless generated from iLO.

3. Add WDIOC_GETPRETIMEOUT so that user space can determine
   when to expect the NMI arrivial.


Jerry Hoemann (3):
  watchdog: hpwdt: SMBIOS check
  watchdog: hpwdt: Check source of NMI
  watchdog: hpwdt: add ioctl WDIOC_GETPRETIMEOUT

 drivers/watchdog/hpwdt.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

-- 
1.8.3.1
