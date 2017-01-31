Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from dukecmmtar03.coxmail.com ([68.99.120.44]:34917 "EHLO
        dukecmmtar03.coxmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdAaQd7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 31 Jan 2017 11:33:59 -0500
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: linux-watchdog@vger.kernel.org
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH v3 0/2] watchdog: cleanup ep93xx platform drivers
Date: Tue, 31 Jan 2017 09:33:28 -0700
Message-Id: <20170131163330.20092-1-hsweeten@visionengravers.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The ep93xx_wdt driver is used by EP93xx based platforms for the internal
watchdog of the EP93xx processor. The TS-72xx platforms have an additional
watchdog provided by the CPLD on those boards.

Cleanup both drivers.

v2: Address issues pointed out by Guenter Roeck
    1) leave the 'timeout' module parameter in both drivers
    2) use devm_watchdog_register_device() in both drivers
    3) use wdd->max_hw_heartbeat_ms in the ts72xx_wdt driver to allow
       larger timeouts
    
    The ts72xx_wdt driver does not need to disable the watchdog when the
    driver is first probed. It will be disabled by arch_decomp_setup()
    before the uncompress of the kernel.

v3: Address a couple more issues pointed out by Guenter Roeck
    1) fix the 'timeout' module parameters so that the core will actually
       look for a device tree parameter
    2) increase the default timeout for the ts72xx_wdt driver to 30 seconds
    3) remove unnecessary platform_set_drvdata()
    4) fix the set_timeout logic in the ts72xx_wdt driver

H Hartley Sweeten (2):
  watchdog: ep93xx_wdt: cleanup and let the core handle the heartbeat
  watchdog: ts72xx_wdt: convert driver to watchdog core

 drivers/watchdog/ep93xx_wdt.c | 114 +++++------
 drivers/watchdog/ts72xx_wdt.c | 447 +++++++++---------------------------------
 2 files changed, 133 insertions(+), 428 deletions(-)

-- 
2.10.0

