Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rwright@hpe.com,
	maurice.a.saldivar@hpe.com,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 00/10] watchdog/hpwdt: Update driver to use watchdog core.
Date: Tue,  6 Feb 2018 15:58:45 -0700
Message-Id: <20180206225855.30582-1-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

The primary purposes of this patch set are to

1) Update the hpwdt driver to use the watchdog core.
2) Reduce complexity by removing unnecessary features.
3) Add customer requested features like optional pretimeout.
4) Enhance readability/maintainability of the driver.

The size of the resultant driver is reduced from over 900
lines to 350 lines.

Patch 1& 2 remove legacy NMI sourcing.
Patch 3	adds useful indication of NMI cause to panic message
Patch 4 & 5 are general cleanup
Patch 6 & 7 updates the driver to user the watchdog core.
Patch 8 makes the pretimeout NMI programmable.
Patch 9 modifies whether the NMI handler claims the NMI.
Patch 10 retracts the allow_kdump module parameter.


Jerry Hoemann (10):
  watchdog/hpwdt: Remove legacy NMI sourcing.
  watchdog/hpwdt: remove include files no longer needed.
  watchdog/hpwdt: Update nmi_panic message.
  watchdog/hpwdt: white space changes
  watchdog/hpwdt: Update Module info.
  watchdog/hpwdt: Modify to use watchdog core.
  watchdog/hpwdt: Select WATCHDOG_CORE
  watchdog/hpwdt: Programable Pretimeout NMI
  watchdog/hpwdt: condition early return of NMI handler on iLO5
  watchdog/hpwdt: remove allow_kdump module parameter.

 drivers/watchdog/Kconfig |   1 +
 drivers/watchdog/hpwdt.c | 843 ++++++++---------------------------------------
 2 files changed, 135 insertions(+), 709 deletions(-)

-- 
2.13.6
