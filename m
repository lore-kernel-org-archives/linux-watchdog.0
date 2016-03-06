Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:48828 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751145AbcCFJwK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 6 Mar 2016 04:52:10 -0500
Date: Sun, 6 Mar 2016 10:51:23 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	linux@roeck-us.net, manabian@gmail.com,
	linux-watchdog@vger.kernel.org, stigge@antcom.de, vz@mleia.com
Subject: Re: [PATCH v7 0/6] watchdog: pnx4008: add restart handler
Message-ID: <20160306095123.GA1685@spo001.leaseweb.nl>
References: <1457117050-13543-1-git-send-email-slemieux.tyco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457117050-13543-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sylvain,

> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> The LPC32xx provide the capability to perform a soft or hard reset;
> a soft reset will no reset the external peripheral
> (i.e. RESOUT_N output not asserted).
> 
> This changeset migrate the restart code from the "mach-lpc32xx" to
> the "pnx-4008" watchdog driver and add the soft reset capability.
> 
> The default behavior (i.e. hard reset) remain unchanged.
> 
> This patchset have a dependency on the following patch:
> watchdog: Add 'action' and 'data' parameters to restart handler callback
> http://permalink.gmane.org/gmane.linux.watchdog/3364/
> 
> Note:
> Patch #5 was generated with the option "--unified=2" to ensure
> it can be apply before or after the changes for the new 
> LPC32xx irqchip driver:
> - http://permalink.gmane.org/gmane.linux.drivers.devicetree/144683
> ---
> Changes from v6 to v7:
> * Update the patch as per the feedback received from:
>   Guenter: http://permalink.gmane.org/gmane.linux.watchdog/3488
>   - remove typecast.
> 
> Changes from v5 to v6:
> * Update the patch as per the feedback received from:
>   Guenter: http://permalink.gmane.org/gmane.linux.watchdog/3420
>   - remove typecast.
> 
> Changes from v4 to v5:
> * Rebased on the following patch:
>   http://permalink.gmane.org/gmane.linux.watchdog/3364/
> 
> Changes from v3 to v4:
> * Update the patch as per the feedback received from:
>   Arnd: http://permalink.gmane.org/gmane.linux.watchdog/3329
>   - Switch patch #5 and #6 order.
> 
> Changes from v2 to v3:
> * Update the patch as per the feedback received from:
>   Joachim: http://permalink.gmane.org/gmane.linux.watchdog/3303
>   - remove explicit clock enable from restart handler.
>   - verify "register_restart_handler" return value.
>   - add call to unregister_restart_handler".
>   - do the restart handling directly in "pnx4008_restart_handler".
> * Move the change to "phy3250.c" into a separate patch and generate
>   the new patch with the "--unified=2" option.
> 
> Changes from v1 to v2:
> * Rename patch title;
>   was "arm: lpc32xx: restart: add support for soft reset"
> * Update the patch as per the feedback received from:
>   Joachim: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/479791
>   - migrate restart code from "mach-lpc32xx" to "pnx-4008" driver.
> * Add soft reset support to "pnx-4008" driver instead of "mach-lpc32xx".
> * Use define available in "pnx-4008" when writting to watchdog register.
> * Remove restart handler from "mach-lpc32xx".
> * Remove restart hook from "phy3250.c".
> * Update driver logging during power-on. 
> 
> Sylvain Lemieux (6):
>   watchdog: pnx4008: update logging during power-on
>   watchdog: pnx4008: add restart handler
>   watchdog: pnx4008: add support for soft reset
>   watchdog: pnx4008: restart: support "cmd" from userspace
>   arm: lpc32xx: phy3250 remove restart hook
>   arm: lpc32xx: remove restart handler
> 
>  arch/arm/mach-lpc32xx/common.c  | 15 ---------------
>  arch/arm/mach-lpc32xx/common.h  |  1 -
>  arch/arm/mach-lpc32xx/phy3250.c |  1 -
>  drivers/watchdog/pnx4008_wdt.c  | 42 +++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 40 insertions(+), 19 deletions(-)
> 
> -- 
> 1.8.3.1
> 

This patchset has been added to linux-watchdog-next.

Kind regards,
Wim.

