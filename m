Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34430 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbbICLF0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Sep 2015 07:05:26 -0400
Date: Thu, 3 Sep 2015 13:05:24 +0200
From: Luis de Bethencourt <luis@debethencourt.com>
To: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/3] watchdog: Fix module autoload for OF platform drivers
Message-ID: <20150903110524.GA17339@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

This series adds the missing MODULE_DEVICE_TABLE() for OF to eport
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (3):
  watchdog: mach-moxart: Fix module autoload for OF platform driver
  watchdog: mena21_wdt: Fix module autoload for OF platform driver
  watchdog: gef_wdt: Fix module autoload for OF platform driver

 drivers/watchdog/gef_wdt.c    | 1 +
 drivers/watchdog/mena21_wdt.c | 1 +
 drivers/watchdog/moxart_wdt.c | 1 +
 3 files changed, 3 insertions(+)

-- 
2.4.6

