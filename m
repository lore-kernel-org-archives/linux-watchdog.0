Return-Path: <SRS0=mVcR=4X=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF63DC10DCE
	for <linux-watchdog@archiver.kernel.org>; Fri,  6 Mar 2020 13:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77152072D
	for <linux-watchdog@archiver.kernel.org>; Fri,  6 Mar 2020 13:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFNiC (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:38:02 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:37294 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFNiC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Mar 2020 08:38:02 -0500
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2020 08:38:01 EST
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 703FC8030704;
        Fri,  6 Mar 2020 13:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g_5CN1YJjStz; Fri,  6 Mar 2020 16:27:57 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] watchdog: dw_wdt: Take Baikal-T1 DW WDT peculiarities into account
Date:   Fri, 6 Mar 2020 16:27:40 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306132758.703FC8030704@mail.baikalelectronics.ru>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Serge Semin <fancer.lancer@gmail.com>

There were a few features enabled at the time of the Baikal-T1 SoC DW WDT
IP synthesis, which weren't taken into account in the DW WDT driver available
in the kernel. First of all the SoC engineers synthesized the watchdog core
with WDT_USE_FIX_TOP set to false (don't really know why, but they did).
Due to this the timer reset values weren't fixed as the driver expected
but were initialized with a pre-defined values selected by the engineers.
Secondly the driver expected that the watchdog APB bus and the timer had
synchronous reference clocks, while Baikal-T1 SoC DW WDT was created with
asynchronous ones. So the driver should enable two clock devices: APB bus
clocks and a separate timer reference clock. Finally DW Watchdog Timer is
capable of generating a pre-timeout interrupt if corresponding config is
enabled. The problem was that the pre-timeout IRQ happens when the set
timeout elapses, while the actual WDT expiration and subsequent reboot take
place in the next timeout. This makes the pre-timeout functionality
implementation a bit tricky, since in this case we would have to find a
WDT timeout twice smaller the requested timeout. All of the changes described
above are provided by the patches in this patchset.

In addition traditionally we replaced the legacy plain text-based dt-binding
file with yaml-based one, made some cleanups in the watchdog core code (just
replaced time-unit numerical literals with corresponding macro) and added
DebugFS nodes to ease the driver debug procedure.

This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
commit 98d54f81e36b ("Linux 5.6-rc4").

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (7):
  dt-bindings: watchdog: dw-wdt: Replace legacy bindings file with
    YAML-based one
  dt-bindings: watchdog: dw-wdt: Add watchdog TOPs array property
  watchdog: watchdog_dev: Use generic msec-per-sec macro
  watchdog: dw_wdt: Support devices with non-fixed TOP values
  watchdog: dw_wdt: Support devices with asynch clocks
  watchdog: dw_wdt: Add pre-timeouts support
  watchdog: dw_wdt: Add DebugFS files

 .../devicetree/bindings/watchdog/dw_wdt.txt   |  24 -
 .../bindings/watchdog/snps,dw-wdt.yaml        |  96 ++++
 drivers/watchdog/dw_wdt.c                     | 460 ++++++++++++++++--
 drivers/watchdog/watchdog_dev.c               |   4 +-
 4 files changed, 523 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml

-- 
2.25.1

