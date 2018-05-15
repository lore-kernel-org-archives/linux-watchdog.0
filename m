Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43053 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeEOSoR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 May 2018 14:44:17 -0400
Date: Tue, 15 May 2018 11:44:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marco Felsch <mfe@pengutronix.de>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "fzuuzf@googlemail.com" <fzuuzf@googlemail.com>,
        Guenter Roeck <groeck7@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
Message-ID: <20180515184412.GC16006@roeck-us.net>
References: <20180509123243.21170-1-m.felsch@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7019417EA41@SW-EX-MBX02.diasemi.com>
 <bec3deb4-6163-ff1c-d84c-47a413845445@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bec3deb4-6163-ff1c-d84c-47a413845445@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 09, 2018 at 04:10:15PM +0200, Marco Felsch wrote:
> Hi Steve,
> 
> On 05/09/2018 03:50 PM, Steve Twiss wrote:
> >Hi Marco,
> >
> >On 09 May 2018 13:33, Marco Felsch wrote:
> >
> >>To: wim@linux-watchdog.org; linux@roeck-us.net
> >>Subject: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
> >>
> >>The DA9063 watchdog always resets the system when it changes the timeout
> >>value after the bootloader (e.g. Barebox) has it already set.
> >>
> >>To update the timeout value we have to disable the watchdog, clear the
> >>watchdog counter value and write the new timeout value to the watchdog.
> >>Clearing the counter value is a feature to be on the safe side, because
> >>the
> >>data sheet doesn't describe the behaviour of the watchdog counter value
> >>after a watchdog disabling-enable-sequence.
> >>
> >>The patch is based on Philipp Zabel's <p.zabel@pengutronix.de>previous
> >>patch but doesn't wait 150us because the DA9063 doesn't need this delay.
> >https://www.dialog-semiconductor.com/products/DA9063
> >
> >Yes, according to the Dialog datasheet DA9063_2v1, there is no 150us
> >minimum
> >assert time limit. But ... that doesn't seem correct to me, because the
> >DA9062
> >driver and DA9062 datasheet both show a minimum assertion time, like you
> >said.
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/watchdog/da9062_wdt.c?h=v4.17-rc3#n67
> >
> >So let me check with the hardware engineers.
> 
> That would be great looking forward to hear from you. I will prepare a v3 if
> it is.
> 
Any updates ?

Guenter

> >>+
> >>  static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int
> >>regval)
> >>  {
> >>+    int ret;
> >>+
> >>+    /*
> >>+     * The watchdog trigger a reboot if a timeout value is already
> >>+     * programmed. Because the timeout value combines two functions in
> >>+     * one: indicating the counter limit and starting the watchdog. To
> >>be
> >>+     * able to set the watchdog a second time (first time was done by
> >>the
> >>+     * bootloader) disable the watchdog clear the counter value
> >>manually and
> >>+     * set the new timeout value.
> >>+     */
> >>+    ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> >>+                 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
> >>+    if (ret)
> >>+        dev_warn(da9063->dev,
> >>+             "Failed to disable watchdog before setting new
> >>timeout\n");
> >>+
> >>+    ret = _da9063_wdt_reset_timer(da9063);
> >>+    if (ret)
> >>+        dev_warn(da9063->dev, "Failed to reset watchdog counter\n");
> 
> BTW. can you ask them if it is necessary to reset the counter value register
> manually or if this is done by disabling the watchdog.
> 
> Regards,
> Marco
