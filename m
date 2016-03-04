Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36072 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbcCDOwT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Mar 2016 09:52:19 -0500
Received: by mail-io0-f195.google.com with SMTP id m184so5220253iof.3
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Mar 2016 06:52:19 -0800 (PST)
Subject: Re: [PATCH v6 4/6] watchdog: pnx4008: restart: support "cmd" from
 userspace
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	manabian@gmail.com, linux-watchdog@vger.kernel.org, wim@iguana.be,
	stigge@antcom.de, vz@mleia.com
In-Reply-To: <56D98FD2.7040403@roeck-us.net>
References: <1457040025-1108-1-git-send-email-slemieux.tyco@gmail.com>
	 <1457040025-1108-5-git-send-email-slemieux.tyco@gmail.com>
	 <56D98FD2.7040403@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Mar 2016 09:52:15 -0500
Message-ID: <1457103135.4541.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 2016-03-04 at 05:38 -0800, Guenter Roeck wrote:
> On 03/03/2016 01:20 PM, Sylvain Lemieux wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> >
> > Added support to verify if a "cmd" is passed from the userspace program rebooting the system;
> > - if a valid "cmd" is available, handle it;
> > - If the received "cmd" is not supported, use the default reboot mode.
> >
> > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > ---
> > Changes from v5 to v6:
> > - remove typecast.
> >
> > Changes from v4 to v5:
> > - no logical change; updated to work with new revision of patch #2.
> >
> > Changes from v3 to v4:
> > - none.
> >
> > Changes from v2 to v3:
> > - no logical change; updated to work with new revision of patch #2.
> >
> > Changes from v1 to v2:
> > - Rename patch title;
> >    was "arm: lpc32xx: restart: support "cmd" from userspace"
> > - Add change to "pnx-4008" driver instead of "mach-lpc32xx".
> >
> >   drivers/watchdog/pnx4008_wdt.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> > index 51be66e..4162135 100644
> > --- a/drivers/watchdog/pnx4008_wdt.c
> > +++ b/drivers/watchdog/pnx4008_wdt.c
> > @@ -129,6 +129,21 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
> >   static int pnx4008_restart_handler(struct watchdog_device *wdd,
> >   				   unsigned long mode, void *cmd)
> >   {
> > +	const char *boot_cmd = (const char *)cmd;
> 
> This typecast is unnecessary.
> 
> Guenter

OK; will send a new revision later today.

Sylvain
> 
> > +
> > +	/*
> > +	 * Verify if a "cmd" passed from the userspace program rebooting
> > +	 * the system; if available, handle it.
> > +	 * - For details, see the 'reboot' syscall in kernel/reboot.c
> > +	 * - If the received "cmd" is not supported, use the default mode.
> > +	 */
> > +	if (boot_cmd) {
> > +		if (boot_cmd[0] == 'h')
> > +			mode = REBOOT_HARD;
> > +		else if (boot_cmd[0] == 's')
> > +			mode = REBOOT_SOFT;
> > +	}
> > +
> >   	if (mode == REBOOT_SOFT) {
> >   		/* Force match output active */
> >   		writel(EXT_MATCH0, WDTIM_EMR(wdt_base));
> >
> 


