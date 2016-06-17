Return-path: <enric.balletbo@collabora.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 0/2] watchdog: ziirave_wdt: Support firmware update
Date: Fri, 17 Jun 2016 12:52:32 +0200
Message-Id: <1466160754-15599-1-git-send-email-enric.balletbo@collabora.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

Here a small patch series to add support for firmware update to the ziirave
watchdog driver. The first patch is a fix found during the development of this
new feature, the second patch is the one that adds support for firmware update.

Best regards,

Enric Balletbo i Serra (2):
  watchdog: ziirave_wdt: Correct I2C device id to fix module
    autoloading.
  watchdog: ziirave_wdt: Add support to upload the firmware.

 drivers/watchdog/ziirave_wdt.c | 428 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 427 insertions(+), 1 deletion(-)

-- 
2.1.0
