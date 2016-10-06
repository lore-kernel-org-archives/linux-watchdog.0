Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.150]:32647 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966775AbcJFJKH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Oct 2016 05:10:07 -0400
Message-ID: <cover.1475743411.git.stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Thu, 6 Oct 2016 09:43:31 +0100
Subject: [PATCH V1 00/10]  da9061: DA9061 driver submission
To: DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
CC: Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

This patch set adds support for the Dialog DA9061 Power Management IC.
Support is made by altering the existing DA9062 device driver.

In this patch set the following is provided:

[PATCH V1 01/10] MFD core support
[PATCH V1 02/10] BUCKs and LDOs
[PATCH V1 03/10] Onkey 
[PATCH V1 04/10] Watchdog
[PATCH V1 05/10] PMIC temperature monitoring
[PATCH V1 06/10] Binding for onkey
[PATCH V1 07/10] Binding for watchdog
[PATCH V1 08/10] Binding for thermal supervisor
[PATCH V1 09/10] Binding for MFD and regulators
[PATCH V1 10/10] MAINTAINERS update

This patch applies against linux-next and v4.8 

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

Steve Twiss (10):
  mfd: da9061: MFD core support
  regulator: da9061: BUCK and LDO regulator driver
  Input: da9061: onkey driver
  watchdog: da9061: watchdog driver
  thermal: da9062/61: Thermal junction temperature monitoring driver
  Documentation: dt: input: temperature driver
  Documentation: dt: watchdog: da9062/61 Watchdog timer binding
  Documentation: dt: thermal: da9062/61 TJUNC temperature binding
  Documentation: dt: mfd: da9062/61 MFD binding
  MAINTAINERS: da9062/61 updates to the Dialog Semiconductor search
    terms

 .../devicetree/bindings/input/da9062-onkey.txt     |  19 +-
 Documentation/devicetree/bindings/mfd/da9062.txt   |  45 +-
 .../devicetree/bindings/thermal/da9062-thermal.txt |  30 ++
 .../devicetree/bindings/watchdog/da9062-wdt.txt    |  11 +
 MAINTAINERS                                        |   4 +
 drivers/input/misc/Kconfig                         |   7 +-
 drivers/input/misc/da9063_onkey.c                  |  24 +-
 drivers/mfd/Kconfig                                |   5 +-
 drivers/mfd/da9062-core.c                          | 454 ++++++++++++++++++++-
 drivers/regulator/Kconfig                          |   4 +-
 drivers/regulator/da9062-regulator.c               | 299 +++++++++++++-
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/da9062-thermal.c                   | 313 ++++++++++++++
 drivers/watchdog/Kconfig                           |   4 +-
 drivers/watchdog/da9062_wdt.c                      |  24 +-
 include/linux/mfd/da9062/core.h                    |  27 +-
 include/linux/mfd/da9062/registers.h               |   2 +
 18 files changed, 1212 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 create mode 100644 drivers/thermal/da9062-thermal.c

-- 
end-of-patch for PATCH V1

