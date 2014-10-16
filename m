Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59791 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaJPPRs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Oct 2014 11:17:48 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so3582515pad.25
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Oct 2014 08:17:48 -0700 (PDT)
Date: Thu, 16 Oct 2014 08:17:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: John Crispin <blogic@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH V2] watchdog: add MT7621 watchdog support
Message-ID: <20141016151742.GA17084@roeck-us.net>
References: <1413454099-2836-1-git-send-email-blogic@openwrt.org>
 <543FCC94.1020102@roeck-us.net>
 <543FCE70.80201@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543FCE70.80201@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 16, 2014 at 03:56:00PM +0200, John Crispin wrote:
> Hi
> 
> 
> 
> On 16/10/2014 15:48, Guenter Roeck wrote:
> > On 10/16/2014 03:08 AM, John Crispin wrote:
> >> This patch adds support for the watchdog core found on newer 
> >> mediatek/ralink Wifi SoCs.
> >> 
> >> Signed-off-by: John Crispin <blogic@openwrt.org> --- Changes 
> >> since V1
> >> 
> >> * fix the comments identifying the driver * add a comment to the 
> >> code setting the prescaler * use watchdog_init_timeout * use 
> >> devm_reset_control_get * get rid of the miscdev code
> >> 
> >> .../devicetree/bindings/watchdog/mt7621-wdt.txt    |   12 ++ 
> >> drivers/watchdog/Kconfig                           |    7 + 
> >> drivers/watchdog/Makefile                          |    1 + 
> >> drivers/watchdog/mt7621_wdt.c                      |  186 
> >> ++++++++++++++++++++ 4 files changed, 206 insertions(+) create 
> >> mode 100644 
> >> Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt create 
> >> mode 100644 drivers/watchdog/mt7621_wdt.c
> >> 
> >> diff --git 
> >> a/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt 
> >> b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt new 
> >> file mode 100644 index 0000000..c15ef0e --- /dev/null +++ 
> >> b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt @@ 
> >> -0,0 +1,12 @@ +Ralink Watchdog Timers + +Required properties: +- 
> >> compatible: must be "mediatek,mt7621-wdt" +- reg: physical base 
> >> address of the controller and length of the register range + 
> >> +Example: + +    watchdog@100 { +        compatible = 
> >> "mediatek,mt7621-wdt"; +        reg = <0x100 0x10>; +    }; diff 
> >> --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >> index f57312f..9ee0d32 100644 --- a/drivers/watchdog/Kconfig +++ 
> >> b/drivers/watchdog/Kconfig @@ -1186,6 +1186,13 @@ config 
> >> RALINK_WDT help Hardware driver for the Ralink SoC Watchdog 
> >> Timer.
> >> 
> >> +config MT7621_WDT +    tristate "Mediatek SoC watchdog" + select
> >> WATCHDOG_CORE +    depends on SOC_MT7620 || SOC_MT7621
> > 
> > There is no SOC_MT7621 symbol, at least not in the current kernel.
> 
> the answer has not changed since last time. the patches are sitting in
> the linux-mips patchwork.
> 
> 
> 
> > 
> >> +    help +      Hardware driver for the Mediatek/Ralink SoC 
> >> Watchdog Timer. +
> > How about mentioning the supported chips (7620 ? 7621 ? 7628 ?)
> 
> ok
> 
> > 
> >> # PARISC Architecture
> >> 
> >> # POWERPC Architecture diff --git a/drivers/watchdog/Makefile 
> >> b/drivers/watchdog/Makefile index 468c320..5b2031e 100644 --- 
> >> a/drivers/watchdog/Makefile +++ b/drivers/watchdog/Makefile @@ 
> >> -138,6 +138,7 @@ obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o 
> >> octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o 
> >> obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
> >> obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
> >> +obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
> >> 
> >> # PARISC Architecture
> >> 
> >> diff --git a/drivers/watchdog/mt7621_wdt.c 
> >> b/drivers/watchdog/mt7621_wdt.c new file mode 100644 index 
> >> 0000000..0cb9e0b --- /dev/null +++ 
> >> b/drivers/watchdog/mt7621_wdt.c @@ -0,0 +1,186 @@ +/* + * Ralink 
> >> MT7621/MT7628 built-in hardware watchdog timer + *
> > MT7628 or MT7620 ?
> > 
> 
> MT7621 and MT7628 as it says there. the mt7628 is a subtype of mt7620.
> it is the same core with slightly different peripherals. this is
> covered by the SOC_MT7620. there i a patch for this inside the
> linux-mips patchwork.
> 
> shall i resend a V3 only with the "How about mentioning the supported
> chips (7620 ? 7621 ? 7628 ?)" fixed ?
> 
Yes, that would be great. Also, it might be useful to mention that the 
patch(es) to add support for 7621 are pending in linux-mips. Mention it
after ---, so the information is not added to the commit log.

Question is how to proceed. Are the 7621 patches going into 3.18
or 3.19 ?

Thanks,
Guenter
