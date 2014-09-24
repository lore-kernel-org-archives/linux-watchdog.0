Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:53006 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbaIXOsi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Sep 2014 10:48:38 -0400
Received: by mail-ig0-f182.google.com with SMTP id hn15so6627306igb.15
        for <linux-watchdog@vger.kernel.org>; Wed, 24 Sep 2014 07:48:37 -0700 (PDT)
Date: Wed, 24 Sep 2014 15:48:29 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com,
	linux@roeck-us.net, lm-sensors@lm-sensors.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, cooloney@gmail.com,
	rpurdie@rpsys.net, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Introduce MEN 14F021P00 BMC driver series
Message-ID: <20140924144829.GK32069@lee--X1>
References: <cover.1409161615.git.andreas.werner@men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1409161615.git.andreas.werner@men.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Guenter, Bryan, Wim,

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980c=
ef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-hwmo=
n-leds-watchdog-v3.18

for you to fetch changes up to 964356938fcd3c0001a786f55b9f0a0fbe47656a:

  hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver (2014-09-24 =
15:36:33 +0100)

----------------------------------------------------------------
Immutable branch between MFD, HWMON, LEDs and Watchdog for v3.18

----------------------------------------------------------------
Andreas Werner (4):
      mfd: menf21bmc: Introduce MEN 14F021P00 BMC MFD Core driver
      watchdog: menf21bmc_wdt: Introduce MEN 14F021P00 BMC Watchdog drive=
r
      leds: leds-menf21bmc: Introduce MEN 14F021P00 BMC LED driver
      hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver

 Documentation/hwmon/menf21bmc    |  50 +++++++++
 drivers/hwmon/Kconfig            |  10 ++
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/menf21bmc_hwmon.c  | 230 +++++++++++++++++++++++++++++++++=
++++++
 drivers/leds/Kconfig             |   9 ++
 drivers/leds/Makefile            |   1 +
 drivers/leds/leds-menf21bmc.c    | 131 ++++++++++++++++++++++
 drivers/mfd/Kconfig              |  15 +++
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/menf21bmc.c          | 132 ++++++++++++++++++++++
 drivers/watchdog/Kconfig         |  10 ++
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/menf21bmc_wdt.c | 203 +++++++++++++++++++++++++++++++++=
+
 13 files changed, 794 insertions(+)
 create mode 100644 Documentation/hwmon/menf21bmc
 create mode 100644 drivers/hwmon/menf21bmc_hwmon.c
 create mode 100644 drivers/leds/leds-menf21bmc.c
 create mode 100644 drivers/mfd/menf21bmc.c
 create mode 100644 drivers/watchdog/menf21bmc_wdt.c

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
