Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58519 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab2DBTjZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Apr 2012 15:39:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH v2 0/8]: arm: lpc32xx: Device tree support
Date: Mon, 2 Apr 2012 19:39:12 +0000
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	w.sang@pengutronix.de, srinivas.bakki@nxp.com, kevin.wells@nxp.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, wim@iguana.be, jonsmirl@gmail.com
References: <1333391587-26290-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1333391587-26290-1-git-send-email-stigge@antcom.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204021939.12731.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 02 April 2012, Roland Stigge wrote:
> This is the first series of patches to introduce device tree support for the
> LPC32xx SoC. This series includes patches for the various subsystems to support
> device tree to be used later by the machine's initialization.
> 
> The patches apply to various subsystems:
> 
>  * staging/iio/adc (1)
>  * rtc (1)
>  * net (1)
>  * wdt (1)
>  * i2c (4)
>  * arm-soc (i2c related in the former, to be merged via i2c, as suggested by
>             Arnd Bergmann)

Looks good, please add

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

for the entire series.

	Arnd
