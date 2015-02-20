Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:40925 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbbBTXp4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 18:45:56 -0500
Received: by wesx3 with SMTP id x3so8316081wes.7
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Feb 2015 15:45:55 -0800 (PST)
From: James Hogan <james.hogan@imgtec.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: James Hogan <james@albanarts.com>,
	James Hogan <james.hogan@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: [PATCH 0/2] watchdog: imgpdc: Runtime fixes
Date: Fri, 20 Feb 2015 23:45:43 +0000
Message-Id: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

A couple of basic runtime fixes for the IMG PDC watchdog driver. These
were found by attempting to enable the driver for TZ1090 and running
under Meta QEMU. Note that QEMU doesn't emulate the actual watchdog
functionality beyond the soft reset register, so I cannot claim to have
tested the driver's watchdog timer functionality yet.

James Hogan (2):
  watchdog: imgpdc: Fix probe NULL pointer dereference
  watchdog: imgpdc: Fix default heartbeat

 drivers/watchdog/imgpdc_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: Jude Abraham <Jude.Abraham@imgtec.com>
Cc: linux-watchdog@vger.kernel.org
-- 
2.0.5

