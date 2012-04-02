Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64656 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab2DBNHW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Apr 2012 09:07:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 4/7] arm: mach-pnx4008: Adjust i2c.c to updated i2c-pnx.c
Date: Mon, 2 Apr 2012 13:07:15 +0000
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	w.sang@pengutronix.de, srinivas.bakki@nxp.com, kevin.wells@nxp.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, wim@iguana.be
References: <1333371364-21347-1-git-send-email-stigge@antcom.de> <1333371364-21347-5-git-send-email-stigge@antcom.de>
In-Reply-To: <1333371364-21347-5-git-send-email-stigge@antcom.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204021307.16072.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 02 April 2012, Roland Stigge wrote:
> The i2c bus driver i2c-pnx.c (used by mach-pnx4008 and mach-lpc32xx) was
> updated to support device tree. In this process, the struct i2c_pnx_data was
> eliminated. Therefore, the platform data of pnx4008 is adjusted with this patch
> to use default resources for mem and irq. DT support for pnx4008 is still not
> available, but i2c-pnx.c now supports both DT and non-DT.
> 
> arch/arm/mach-pnx4008/include/mach/i2c.h can safely be removed now since its
> contents is integrated in the updated i2c-pnx.c driver and was duplicated
> between platforms pnx4008 and lpc32xx.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Hi Roland,

The i2c changes look ok, but the order breaks bisection through the series.

Since the changes in pnx4008 are fairly localized, I would suggest merging
all three patches through the i2c tree and reorganizing the changes so
that each change is atomic. I would suggest an order like:

1. fix suspend
2. move contents of mach/i2c.h from pnx4008 and lpc32xx to i2c driver
3. change driver and platform device definitions to use resources instead
   of platform data
4. add support for device tree based probing

	Arnd
