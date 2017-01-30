Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from dukecmmtar03.coxmail.com ([68.99.120.44]:36530 "EHLO
        dukecmmtar03.coxmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754235AbdA3VBe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 30 Jan 2017 16:01:34 -0500
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: linux-watchdog@vger.kernel.org
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH v2 0/2] watchdog: cleanup ep93xx platform drivers
Date: Mon, 30 Jan 2017 14:01:07 -0700
Message-Id: <20170130210109.71699-1-hsweeten@visionengravers.com>
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

H Hartley Sweeten (2):
  watchdog: ep93xx_wdt: cleanup and let the core handle the heartbeat
  watchdog: ts72xx_wdt: convert driver to watchdog core

 drivers/watchdog/ep93xx_wdt.c | 111 ++++-------
 drivers/watchdog/ts72xx_wdt.c | 447 +++++++++---------------------------------
 2 files changed, 135 insertions(+), 423 deletions(-)

-- 
2.10.0

