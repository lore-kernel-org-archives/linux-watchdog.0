Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:62637 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaIXOtn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Sep 2014 10:49:43 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar1so11728275iec.21
        for <linux-watchdog@vger.kernel.org>; Wed, 24 Sep 2014 07:49:42 -0700 (PDT)
Date: Wed, 24 Sep 2014 15:49:36 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com,
	linux@roeck-us.net, lm-sensors@lm-sensors.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, cooloney@gmail.com,
	rpurdie@rpsys.net, linux-leds@vger.kernel.org
Subject: [GIT PULL] MFD: Immutable branch between HWMON, LEDs and Watchdog
Message-ID: <20140924144936.GL32069@lee--X1>
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
 =20
  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
 =20
are available in the git repository at:
 =20
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
