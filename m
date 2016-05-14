Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34765 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751955AbcENQpp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 12:45:45 -0400
Date: Sat, 14 May 2016 18:45:43 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/4] watchdog: add driver for Renesas Gen3 WDT watchdogs
Message-ID: <20160514164543.GA20335@spo001.leaseweb.nl>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

> Here is V2 of this series with the following changes:
> 
> * include bitops.h
> * s/unsigned/unsigned int/
> * drop set_timeout() because core does it already
> * add get_timeleft()
> * don't make "nowayout" a readable parameter
> * use "watchdog" instead of "wdt" in the dt bindings
> 
> The dts and defconfig changes should go via Simon's tree once the driver is
> accepted.
> 
> To use this driver, you need a recent firmware/uboot which initializes the
> WDTRSTCR register which can only be changed in secure mode. 'md 0xe6160054 4'
> should give you 0x8002 or something else with bit 15 set and bit 0 cleared.
> 
> Also, you need the clock enablement patches which just have been posted in
> their newest version to the renesas-soc mailing list and are also in
> close-to-be-applied state.
> 
> A complete branch to test can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/v8-wdt
> 
> Please review, test, comment...
> 
> Thanks,
> 
>    Wolfram
> 
> 
> Wolfram Sang (4):
>   watchdog: renesas-wdt: add driver
>   arm64: dts: r8a7795: Add RWDT node
>   arm64: dts: salvator-x: Enable watchdog timer
>   arm64: defconfig: enable Renesas Watchdog Timer
> 
>  .../devicetree/bindings/watchdog/renesas-wdt.txt   |  25 +++
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   5 +
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   8 +
>  arch/arm64/configs/defconfig                       |   2 +
>  drivers/watchdog/Kconfig                           |   8 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/renesas_wdt.c                     | 213 +++++++++++++++++++++
>  7 files changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
>  create mode 100644 drivers/watchdog/renesas_wdt.c
> 
> -- 
> 2.7.0
>

Patch 1 and 4 have been added to linux-watchdog-next.

Kind regards,
Wim.
 
