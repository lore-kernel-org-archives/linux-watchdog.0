Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:34959 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964934Ab3BMXZ6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 18:25:58 -0500
Date: Thu, 14 Feb 2013 00:25:56 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Wenyou Yang <wenyou.yang@atmel.com>, fabio.porcedda@gmail.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com,
	JM.Lin@atmel.com
Subject: Re: [PATCH v4 0/8] watchdog/at91sam9_wdt: Convert to use the new framework
Message-ID: <20130213232556.GI7867@spo001.leaseweb.com>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com> <51139188.8030601@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51139188.8030601@atmel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Nicolas,

> > The purpose of the patch series is to convert at91sam9_wdt to use the watchdog framework,
> >  
> > Because the Watchdog Mode Register(WDT_MR) which WDDIS bit to disable or disable the watchdog
> > can be written only once after reset. so if you want to use the watchdog in the kernel, 
> > you must be sure the watchdog doesn't be disabled in the at91bootstrap.
> > 
> > It is tested on at91sam9m10g45ek both DT and non-DT support, at91sam9g25ek with DT support
> > by building Documentation/watchdog/src/watchdog-simple.c.
> > 
> > It is based on v3.8-rc6 + Arnd Bergmann's at91_wdt_dt_ids cannot be __init
> > 			+ Fabio Porcedda's add timeout-sec property binding
> 
> On my side, I give my acknowledgement to the whole patch series:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> I hope that once Fabio Porcedda's series is merged, this series can be
> applied on top of it seamlessly and quickly.
> 
> Wim,
> Tell us if you need that we resend this series or rebase it on top of
> another git tree.
> 
> Thanks for your work and for your reviews.

This is how I'm going to do it:
1) We are going to add my reworked version of Fabio's v7 patch of the core timeout-sec part.
2) then we are going to do the conversion of the at91sam9 driver but without doing the other changes that Wenyou proposed.
3) Then we add the driver related part of Fabio's patches (I don't want non converted drivers to have the watchdog_core select, hence we do the conversion of at91sam9 first in step 2).
4) then we can see what is still needed of Wenyou's patches.
-> all will go through the linuw-watchdog trees.

Note: I know we have another patch in Greg's driver tree that changes the module_platform_driver_probe, but that should not interfere with these patches.

Kind regards,
Wim.
