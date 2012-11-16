Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:37267 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752865Ab2KPSke (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 16 Nov 2012 13:40:34 -0500
Received: from mail617.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 717EBFF9B57
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Nov 2012 15:03:31 +0100 (CET)
Date: Fri, 16 Nov 2012 14:50:43 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	nicolas.ferre@atmel.com, JM.Lin@atmel.com
Subject: Re: [PATCH 00/11] watchdog/at91sam9_wdt: use watchdog framework,
 support DT
Message-ID: <20121116135043.GI4398@game.jcrosoft.org>
References: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 15:15 Wed 14 Nov     , Wenyou Yang wrote:
> Hi, All
> 
> The patch series is intended to convert to use the watchdog framework,
> and add support to device tree.
> It has been tested on sam9m10g45ek, sam9g20ek, sam9263ek and sam9g25ek.
you need to check Fabio wrok which is present on the ML for a while and  was
reviewed and binding too

Best Regards,
J.
> 
> It is based on v3.7-rc5.
> 
> Best Regards
> Wenyou Yang
> 
> Wenyou Yang (11):
>   watchdog/at91sam9_wdt: remove the file_operations struct
>   watchdog/at91sam9_wdt: change the at91wdt_private struct to the
>     at91wdt_drvdata struct
>   watchdog/at91sam9_wdt: change the wdt_read and wdt_write macro to the
>     inline function
>   watchdog/at91sam9_wdt: change "at91_wdt_settimeout" function name to
>     "at91wdt_enable"
>   watchdog/at91sam9_wdt: add to use the watchdog framework
>   watchdog/at91sam9_wdt: change the timer function name
>   watchdog/at91sam9_wdt: add nowayout helpers to Watchdog Timer Driver
>     Kernel API
>   watchdog/at91sam9_wdt: use module_platform_driver()
>   watchdog/at91sam9_wdt: add support to device tree
>   watchdog/at91sam9_wdt: using dev_info replaces pr_info, dev_crit
>     repalces pr_crit
>   ARM: dts: add the watchdog nodes for atmel SoC
> 
>  .../devicetree/bindings/watchdog/atmel-wdt.txt     |   14 +
>  arch/arm/boot/dts/at91sam9260.dtsi                 |    6 +
>  arch/arm/boot/dts/at91sam9263.dtsi                 |    6 +
>  arch/arm/boot/dts/at91sam9263ek.dts                |    4 +
>  arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |    4 +
>  arch/arm/boot/dts/at91sam9g25ek.dts                |    4 +
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +
>  arch/arm/boot/dts/at91sam9m10g45ek.dts             |    4 +
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |    6 +
>  arch/arm/boot/dts/at91sam9n12ek.dts                |    4 +
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |    6 +
>  drivers/watchdog/Kconfig                           |    1 +
>  drivers/watchdog/at91sam9_wdt.c                    |  294 ++++++++------------
>  13 files changed, 185 insertions(+), 173 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> -- 
> 1.7.9.5
> 
