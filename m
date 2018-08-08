Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 0/5] watchdog: hpwdt: Bug Fixes/Enhancement
Date: Wed,  8 Aug 2018 13:13:22 -0600
Message-Id: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

Changes for v2

1) Patch 0001: Simplify initialization of pretimeout removing #ifdef.
2) Patch 0002: Loosen check on mynmi to accommodate potential FW issue.
3) Patch 0003: Split dev_info into mulitple calls as output was getting long.
4) Patch 0004: New: Add alias to module parameter soft_margin.


-----------------------------

Two defect fixes and one enhancement.  

0001: Initialize pretimeout from module parameter.

Bug Fix.

Pretimeout was getting programmed correctly in the hardware,
but this issue caused it to not be displayed correctly
in sysfs.



0002: Claim NMI from iLO

Bug Fix.

Default configuration worked, but if user were to disable the
pretimeout for the watchdog, then an explicit request to NMI
the system from the iLO virutal button would fail.


0003: Display module parameters

Enhancement.

Display all the module parameters when loading the driver.
Makes it easier to diagnose problems.


Jerry


Jerry Hoemann (5):
  watchdog: hpwdt: Initialize pretimeout from module parameter.
  watchdog: hpwdt: Claim NMI from iLO
  watchdog: hpwdt: Display module parameters.
  watchdog: hpwdt: Module paramerter alias.
  watchdog: hpwdt: Update version number.

 drivers/watchdog/hpwdt.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
1.8.3.1
