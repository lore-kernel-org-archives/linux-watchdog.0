Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53589 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbcCDNia (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Mar 2016 08:38:30 -0500
Subject: Re: [PATCH v6 4/6] watchdog: pnx4008: restart: support "cmd" from
 userspace
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
	linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	manabian@gmail.com
References: <1457040025-1108-1-git-send-email-slemieux.tyco@gmail.com>
 <1457040025-1108-5-git-send-email-slemieux.tyco@gmail.com>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, stigge@antcom.de,
	vz@mleia.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D98FD2.7040403@roeck-us.net>
Date: Fri, 4 Mar 2016 05:38:26 -0800
MIME-Version: 1.0
In-Reply-To: <1457040025-1108-5-git-send-email-slemieux.tyco@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/03/2016 01:20 PM, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
>
> Added support to verify if a "cmd" is passed from the userspace program rebooting the system;
> - if a valid "cmd" is available, handle it;
> - If the received "cmd" is not supported, use the default reboot mode.
>
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
> Changes from v5 to v6:
> - remove typecast.
>
> Changes from v4 to v5:
> - no logical change; updated to work with new revision of patch #2.
>
> Changes from v3 to v4:
> - none.
>
> Changes from v2 to v3:
> - no logical change; updated to work with new revision of patch #2.
>
> Changes from v1 to v2:
> - Rename patch title;
>    was "arm: lpc32xx: restart: support "cmd" from userspace"
> - Add change to "pnx-4008" driver instead of "mach-lpc32xx".
>
>   drivers/watchdog/pnx4008_wdt.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index 51be66e..4162135 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -129,6 +129,21 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
>   static int pnx4008_restart_handler(struct watchdog_device *wdd,
>   				   unsigned long mode, void *cmd)
>   {
> +	const char *boot_cmd = (const char *)cmd;

This typecast is unnecessary.

Guenter

> +
> +	/*
> +	 * Verify if a "cmd" passed from the userspace program rebooting
> +	 * the system; if available, handle it.
> +	 * - For details, see the 'reboot' syscall in kernel/reboot.c
> +	 * - If the received "cmd" is not supported, use the default mode.
> +	 */
> +	if (boot_cmd) {
> +		if (boot_cmd[0] == 'h')
> +			mode = REBOOT_HARD;
> +		else if (boot_cmd[0] == 's')
> +			mode = REBOOT_SOFT;
> +	}
> +
>   	if (mode == REBOOT_SOFT) {
>   		/* Force match output active */
>   		writel(EXT_MATCH0, WDTIM_EMR(wdt_base));
>

