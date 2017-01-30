Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from dukecmwbtp06.coxmail.com ([68.99.120.54]:57875 "EHLO
        dukecmwbtp06.coxmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753756AbdA3STG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 30 Jan 2017 13:19:06 -0500
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 0/2] watchdog: cleanup ep93xx platform drivers
Date: Mon, 30 Jan 2017 09:55:46 -0700
Message-Id: <20170130165548.40965-1-hsweeten@visionengravers.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The ep93xx_wdt driver is used by EP93xx based platforms for the internal
watchdog of the EP93xx processor. The TS-72xx platforms have an additional
watchdog provided by the CPLD on those boards.

Cleanup both drivers.

H Hartley Sweeten (2):
  watchdog: ep93xx_wdt: cleanup and let the core handle the heartbeat
  watchdog: ts72xx_wdt: convert driver to watchdog core

 drivers/watchdog/ep93xx_wdt.c | 115 +++++------
 drivers/watchdog/ts72xx_wdt.c | 447 +++++++++---------------------------------
 2 files changed, 139 insertions(+), 423 deletions(-)

-- 
2.10.0

