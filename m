Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43569 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752651AbbL0Qri (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 11:47:38 -0500
Date: Sun, 27 Dec 2015 17:47:35 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 00/13] watchdog: factorize restart handler registration
Message-ID: <20151227164735.GA23719@spo001.leaseweb.nl>
References: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Damien,

> Many drivers implements the exact same piece of code to register a
> restart handler. It can be nice to factorize this in the watchdog core.
> 
> The first patch adds an optional restart watchdog operation. If a driver
> defines this operation, a restart handler is registered. By default, the
> restart handler priority is set to 0, but a helper function
> watchdog_set_restart_priority is provided to change it.
> 
> The following patches bring this change to the current watchdog drivers
> that use watchdog_core.
> 
> This change has been compile-tested on da9063, imx2, lpc18xx, imgpdc.
> It has been tested with (not mainlined yet) ts-4800's watchdog driver.
> 
> Changes in v2:
>  - bcm47xx_wdt.c: move restart function to fix an undefined function
>    error
>  - core: documentation and header: fix "capabilites" typo, reword some
>    comments to fit 80 columns
> 
> Damien Riegel (13):
>   watchdog: core: add restart handler support
>   watchdog: bcm47xx_wdt: use core restart handler
>   watchdog: da9063_wdt: use core restart handler
>   watchdog: digicolor_wdt: use core restart handler
>   watchdog: imgpdc_wdt: use core restart handler
>   watchdog: imx2_wdt: use core restart handler
>   watchdog: lpc18xx_wdt: use core restart handler
>   watchdog: meson_wdt: use core restart handler
>   watchdog: moxart_wdt: use core restart handler
>   watchdog: mtk_wdt: use core restart handler
>   watchdog: qcom-wdt: use core restart handler
>   watchdog: s3c2410_wdt: use core restart handler
>   watchdog: sunxi_wdt: use core restart handler

This patchset has been added to linux-watchdog-next.

Kind regards,
Wim.

