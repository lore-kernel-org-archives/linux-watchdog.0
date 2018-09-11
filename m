Return-Path: <jgebben@sweptlaser.com>
Return-path: <jgebben@sweptlaser.com>
From: Jeremy Gebben <jgebben@sweptlaser.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-rtc@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] rtc: abx80x: add basic watchdog support
Date: Tue, 11 Sep 2018 11:28:24 -0600
Message-Id: <20180911172826.7195-1-jgebben@sweptlaser.com>
List-ID: <linux-watchdog@vger.kernel.org>

This patch series adds watchdog support for abracon RTC chips which
include basic watchdog functionality.

Thank you for reviewing.

Changes in v3 (all in patch 2):
* fix CONFIG_WATCHDOG dependency again (hopefully correctly this time)
* don't start hardware when set_timeout is called
* remove unneeded WDOG_HW_RUNNING bit changes
* fix abx80x_setup_watchdog()
* fix formatting of multiline splits
 
Changes in v2:
* split out priv structure into a separate patch
* remove new Kconfig option
* fix CONFIG_WATCHDOG dependency
* fix WDT interrupt message


Jeremy Gebben (2):
  rtc: abx80x: use a 'priv' struct for client data
  rtc: abx80x: add basic watchdog support

 drivers/rtc/Kconfig      |   1 +
 drivers/rtc/rtc-abx80x.c | 143 +++++++++++++++++++++++++++++++++++----
 2 files changed, 132 insertions(+), 12 deletions(-)

-- 
2.17.1
