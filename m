Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34083 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbcGIJna (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 9 Jul 2016 05:43:30 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Martyn Welch <martyn.welch@collabora.com>
Subject: [RESEND PATCH 0/2] watchdog: ziirave_wdt: Support firmware update
Date: Sat,  9 Jul 2016 11:43:18 +0200
Message-Id: <1468057400-5772-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

