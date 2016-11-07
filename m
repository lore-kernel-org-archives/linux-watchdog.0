Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ve1eur01on0110.outbound.protection.outlook.com ([104.47.1.110]:45280
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750988AbcKGU6Z (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 Nov 2016 15:58:25 -0500
From: Cor Peters <cpeters@victronenergy.com>
To: <linux-watchdog@vger.kernel.org>
Subject: omap watchdog boot status
Date: Mon, 7 Nov 2016 15:26:02 +0100
Message-ID: <1837421.P2zRp1Vi4u@corpeters>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello everybody

I was looking into an issue with the omap-wdt.c. The  watchdog driver not is 
reporting a different boot status when a reset is being triggered by the 
watchdog.

>From what I gathered, the issue is that in the omap_wdt_probe function,
pdev->dev->platform_data requires to be a reference to the PRM module,
however it has not been set, and I was wondering how this should work in 
an environment that uses the device tree method. (Link to usage:
http://lxr.free-electrons.com/source/drivers/watchdog/omap_wdt.c#L268[1] ).

My questions are as follows:
1) Is my assertion correct that the current method does not work when 
  the driver is being initialised from an device tree instead of a old style 
  board file.
2) If that is the case, what would be the best method of fixing this situation.

Thank you very much in advance.
-- 

Met vriendelijke groet,
With kind regards,
   Cor Peters

Victron Energy B.V.
Koldingweg 9a, 9723HL Groningen
Tel. +31 36 535 9774   Fax. +31 36 531 1666
www.victronenergy.com

--------
[1] http://lxr.free-electrons.com/source/drivers/watchdog/omap_wdt.c#L268
