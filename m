Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34749 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933522AbcBZOgQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Feb 2016 09:36:16 -0500
Subject: Re: [PATCH v4 0/6] watchdog: pnx4008: add restart handler
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
	linux-arm-kernel@lists.infradead.org, arnd@arndb.de, wim@iguana.be,
	manabian@gmail.com
References: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
Cc: linux-watchdog@vger.kernel.org, stigge@antcom.de, vz@mleia.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D062DD.1060707@roeck-us.net>
Date: Fri, 26 Feb 2016 06:36:13 -0800
MIME-Version: 1.0
In-Reply-To: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/25/2016 10:31 AM, Sylvain Lemieux wrote:
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
> The core restart handler support added by this change:
> 2165bf524da5f5e496d - "watchdog: core: add restart handler support"
> is not use in this changeset; it does not support the reboot mode.

I finally had the time to look into this. Sorry for the late reply.

Changing the watchdog core to pass the restart mode (or action)
and the cmd/data pointer to the driver would be trivial and should
be done instead.

I wrote a patch to do just that. I'll send it out later today for review,
assuming it passes my internal tests.

Guenter

>
> Note:
> Patch #5 was generated with the option "--unified=2" to ensure
> it can be apply before or after the changes for the new
> LPC32xx irqchip driver:
> - http://permalink.gmane.org/gmane.linux.drivers.devicetree/144683
> ---
> Changes from v3 to v4:
> * Update the patch as per the feedback received from:
>    Arnd: http://permalink.gmane.org/gmane.linux.watchdog/3329
>    - Switch patch #5 and #6 order.
>
> Changes from v2 to v3:
> * Update the patch as per the feedback received from:
>    Joachim: http://permalink.gmane.org/gmane.linux.watchdog/3303
>    - remove explicit clock enable from restart handler.
>    - verify "register_restart_handler" return value.
>    - add call to unregister_restart_handler".
>    - do the restart handling directly in "pnx4008_restart_handler".
> * Move the change to "phy3250.c" into a separate patch and generate
>    the new patch with the "--unified=2" option.
>
> Changes from v1 to v2:
> * Rename patch title;
>    was "arm: lpc32xx: restart: add support for soft reset"
> * Update the patch as per the feedback received from:
>    Joachim: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/479791
>    - migrate restart code from "mach-lpc32xx" to "pnx-4008" driver.
> * Add soft reset support to "pnx-4008" driver instead of "mach-lpc32xx".
> * Use define available in "pnx-4008" when writting to watchdog register.
> * Remove restart handler from "mach-lpc32xx".
> * Remove restart hook from "phy3250.c".
> * Update driver logging during power-on.
>
> Sylvain Lemieux (6):
>    watchdog: pnx4008: update logging during power-on
>    watchdog: pnx4008: add restart handler
>    watchdog: pnx4008: add support for soft reset
>    watchdog: pnx4008: restart: support "cmd" from userspace
>    arm: lpc32xx: phy3250 remove restart hook
>    arm: lpc32xx: remove restart handler
>
>   arch/arm/mach-lpc32xx/common.c  | 15 ------------
>   arch/arm/mach-lpc32xx/common.h  |  1 -
>   arch/arm/mach-lpc32xx/phy3250.c |  1 -
>   drivers/watchdog/pnx4008_wdt.c  | 51 +++++++++++++++++++++++++++++++++++++++--
>   4 files changed, 49 insertions(+), 19 deletions(-)
>

