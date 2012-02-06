Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:26500
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755008Ab2BFMnY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Feb 2012 07:43:24 -0500
Subject: [PATCH 00/07] DA9052 patch series
From: Ashish Jangam <ashish.jangam@kpitcummins.com>
To: <linux-kernel@vger.kernel.org>
CC: Dajun <dajun.chen@diasemi.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	<linux-watchdog@vger.kernel.org>, <lm-sensors@lm-sensors.org>,
	<sameo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 6 Feb 2012 18:05:55 +0530
Message-ID: <1328531755.30549.67.camel@dhruva>
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF=EF=BB=BFThe following patch series adds support for the various=
 features of
Dialog Semiconductor DA9052/53 PMICs.

The DA9052/53 PMICs support many functionalities like GPIOs, regulators,
power-supply, touchscreen, rtc, backlight, etc. So these patches are
applicable to different sub-systems of the kernel separately.

This patch series adds support for ADC functionality in MFD, HWMON,
LEDS, Backlight, Watchdog, RTC and TSI. Support for rest of the devices
will be added later.

The HWMON patch depends on the patch for ADC functionality in MFD
module.

Ashish Jangam (7):
	[MFD]: Incremental ADC support. HWMON patch also depends on this
	[HWMON]: HWMON driver for DA9052/53 PMICs.
	[LEDS]: Support for DA9052/53 LEDS.
	[Backlight]: Support for DA9052/53 white LED / backlight.
	[Watchdog]: Watchdog driver for DA9052/53 PMICs.
	[RTC]: RTC driver for DA9052/53 PMICs.
	[TSI]: Support for Touch screen interface for DA9052/53 PMICs.

 Documentation/hwmon/da9052                     |   59 ++++
 Documentation/watchdog/watchdog-parameters.txt |    5 +
 drivers/hwmon/Kconfig                          |   10 +
 drivers/hwmon/Makefile                         |    1 +
 drivers/hwmon/da9052-hwmon.c                   |  343
+++++++++++++++++++++++
 drivers/input/touchscreen/Kconfig              |    7 +
 drivers/input/touchscreen/Makefile             |    1 +
 drivers/input/touchscreen/da9052_tsi.c         |  353
++++++++++++++++++++++++
 drivers/leds/Kconfig                           |    8 +
 drivers/leds/Makefile                          |    1 +
 drivers/leds/leds-da9052.c                     |  214 ++++++++++++++
 drivers/mfd/da9052-core.c                      |  134 +++++++++
 drivers/rtc/Kconfig                            |    7 +
 drivers/rtc/Makefile                           |    1 +
 drivers/rtc/rtc-da9052.c                       |  293
++++++++++++++++++++
 drivers/video/backlight/Kconfig                |    6 +
 drivers/video/backlight/Makefile               |    1 +
 drivers/video/backlight/da9052_bl.c            |  187 +++++++++++++
 drivers/watchdog/Kconfig                       |    6 +
 drivers/watchdog/Makefile                      |    1 +
 drivers/watchdog/da9052_wdt.c                  |  333
++++++++++++++++++++++
 include/linux/mfd/da9052/da9052.h              |   17 ++
 22 files changed, 1988 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/da9052
 create mode 100644 drivers/hwmon/da9052-hwmon.c
 create mode 100644 drivers/input/touchscreen/da9052_tsi.c
 create mode 100644 drivers/leds/leds-da9052.c
 create mode 100644 drivers/rtc/rtc-da9052.c
 create mode 100644 drivers/video/backlight/da9052_bl.c
 create mode 100644 drivers/watchdog/da9052_wdt.c


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
