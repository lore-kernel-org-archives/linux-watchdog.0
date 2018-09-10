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
Subject: [PATCH v2 0/2] rtc: abx80x: add basic watchdog support
Date: Mon, 10 Sep 2018 15:36:52 -0600
Message-Id: <20180910213654.26059-1-jgebben@sweptlaser.com>
List-ID: <linux-watchdog@vger.kernel.org>

This patch series adds watchod support for abracon RTC chips which
include basic watchdog functionality.

Changes in v2:
* split out priv structure into a separate patch
* remove new Kconfig option
* fix CONFIG_WATCHDOG dependency
* fix WDT interrupt message


Jeremy Gebben (2):
  rtc: abx80x: use a 'priv' struct for client data
  rtc: abx80x: add basic watchdog support

 drivers/rtc/rtc-abx80x.c | 159 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 147 insertions(+), 12 deletions(-)

-- 
2.17.1
