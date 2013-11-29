Return-Path: <markus.mayer@linaro.org>
From: "Markus Mayer" <markus.mayer@linaro.org>
To: "Guenter Roeck" <linux@roeck-us.net>,
	"Wim Van Sebroeck" <wim@iguana.be>
cc: "Linux Watchdog List" <linux-watchdog@vger.kernel.org>,
	"Markus Mayer" <markus.mayer@linaro.org>
Subject: [RFC 0/2] Proposal for Watchdog Timer Resolution
Date: Fri, 29 Nov 2013 13:20:28 -0800
Message-ID: <1385760030-24264-1-git-send-email-markus.mayer@linaro.org>
MIME-Version: 1.0
Return-path: markus.mayer@linaro.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

I would like to propose the following extension to the watchdog
framework to allow userland programs access to the resolution of the
watchdog timer should the hardware support such a feature. The first
driver to make use of this feature would be the BCM Kona watchdog
driver.

I would also like to propose introducing a sysfs interface to the
watchdog framework in a later phase of updating the watchdog framework.
The sysfs interface would exist in addition to the existing ioctl
interface. In the future, the ioctl interface could be deprecated in
favour of the sysfs interface or both interfaces could be kept
indefinitely.

Phase 1:

Add get resolution/set resolution ioctls.
Add necessary flags and call-back functions.
Extend bcm_kona_wdt.c to make use of the new functionality.

Phase 2:

Abstract the ioctl interface (into watchdog_ioctl.c) with a new set of
per-driver ops, similar to what other frameworks are already doing.

Phase 3:

Introduce a sysfs interface (watchdog_sysfs.c) hooking into the already
established per-driver ops. ioctl and sysfs calls would use the same
framework and driver functions, requiring no code duplication.

Please let me know if this sounds sensible or whether an alternate
approach would be preferred.

To give you an idea I am attaching an initial patch series for phase 1.
Please keep in mind that the series is not meant to be applied as is.
The code may need a bit more cleaning up. Also, I didn't add any
documentation for the new features. Lastly, the series is currently
only broken down into 2 patches (all framework changes and the actual
driver changes), without further regard as to how this series may be
applied.

Patch 2/2 is dependent on the previous bcm_kona_wdt series:

http://www.spinics.net/lists/linux-watchdog/msg03328.html

Regards,
-Markus


Markus Mayer (2):
  watchdog: Add support to set timer resolution
  watchdog: bcm281xx: Support for timer resolution ioctls

 drivers/watchdog/bcm_kona_wdt.c  |   57 +++++++++++++++++++++-----------------
 drivers/watchdog/watchdog_core.c |   14 ++++++++++
 drivers/watchdog/watchdog_dev.c  |   41 +++++++++++++++++++++++++++
 include/linux/watchdog.h         |   12 ++++++++
 include/uapi/linux/watchdog.h    |    3 ++
 5 files changed, 101 insertions(+), 26 deletions(-)

-- 
1.7.9.5
