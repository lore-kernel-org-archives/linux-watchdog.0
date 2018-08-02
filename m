Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 0/4] watchdog: hpwdt: Bug Fixes/Enhancement
Date: Thu,  2 Aug 2018 15:15:37 -0600
Message-Id: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>


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


0004: Update version number.

Bump version number to reflect changes.




Jerry Hoemann (4):
  watchdog: hpwdt: Initialize pretimeout from module parameter.
  watchdog: hpwdt: Claim NMI from iLO
  watchdog: hpwdt: Display module parameters.
  watchdog: hpwdt: Update version number.

 drivers/watchdog/hpwdt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
1.8.3.1
