Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36219 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754328AbeGGVT6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 7 Jul 2018 17:19:58 -0400
Date: Sat, 7 Jul 2018 14:19:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Tian, Baofeng" <baofeng.tian@intel.com>
Cc: "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
Message-ID: <20180707211952.GA1951@roeck-us.net>
References: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
 <140371d6-4bbb-6377-a570-5253c5f98e0e@roeck-us.net>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E29D27@SHSMSX101.ccr.corp.intel.com>
 <b83a8cd9-b81e-cce3-1b34-f88d38fe414e@roeck-us.net>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E2A1C0@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E2A1C0@SHSMSX101.ccr.corp.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jul 06, 2018 at 06:25:17AM +0000, Tian, Baofeng wrote:
> Hi, Roeck
> 
> This is an interface from android, with this interface, android can avoid reboot if user want to make it.
> the watchdog use space daemon you mentioned is always there in android, and if remove/disable this daemon system will reboot.
> 
> Keep this simple interface can make "disable reboot" easily.
> 

This would be required in each watchdog driver and add messy code
into the kernel just because Android userspace can not handle
the situation. NACK from my side. There has to be a better solution.

Guenter

> Thanks
> Tim
> 
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
> Sent: Thursday, July 5, 2018 9:05 PM
> To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
> 
> On 07/04/2018 11:28 PM, Tian, Baofeng wrote:
> > Hi, Roeck
> > 
> > Yes, this patch is for add a parameter to TCO to prevent reboot happen 
> > if you don't want to reboot system and want to stay here to check some HW status, logs, etc for debug purpose.
> > 
> > Under some android related stability test, developer want to stay at 
> > the crash and use debug tools(LTB) to check more information, this is the purpose of this patch.
> > 
> The watchdog doesn't even start with the module parameter set.
> If the purpose is to disable the watchdog, just stop it by closing the watchdog daemon, or don't run the watchdog daemon in the first place, or blacklist the module.
> 
> Guenter
> 
> > Thanks
> > Tim
> > 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter 
> > Roeck
> > Sent: Monday, July 2, 2018 9:21 PM
> > To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; 
> > linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" 
> > for iTCO
> > 
> > On 07/02/2018 12:30 AM, Tian, Baofeng wrote:
> >> From: "Tian, Baofeng" <baofeng.tian@intel.com 
> >> <mailto:baofeng.tian@intel.com>>
> >> Subject: [PATCH] watchdog: add module parameter "force_no_reboot" for 
> >> iTCO
> >>
> >> Setting "force_no_reboot" parameter to true (y/Y/1) will have the 
> >> effect to prevent to reset the NO_REBOOT flag thus preventing the 
> >> iTCO to reboot the platform, if not set or set to false, then system 
> >> will reboot after about 30s.
> >>
> >> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com 
> >> <mailto:baofeng.tian@intel.com>>
> > 
> > Your e-mail address is messed up.
> > 
> >> ---
> >>    drivers/watchdog/iTCO_wdt.c | 11 ++++++++++-
> >>    1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/watchdog/iTCO_wdt.c 
> >> b/drivers/watchdog/iTCO_wdt.c index 347f038..255318b 100644
> >> --- a/drivers/watchdog/iTCO_wdt.c
> >> +++ b/drivers/watchdog/iTCO_wdt.c
> >> @@ -131,6 +131,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 
> >> 0);
> >>    MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
> >>         "Turn off SMI clearing watchdog (depends on 
> >> TCO-version)(default=1)");
> >>
> >> +static bool force_no_reboot;
> >> +module_param(force_no_reboot, bool, 0); 
> >> +MODULE_PARM_DESC(force_no_reboot,
> >> +           "Prevents the watchdog rebooting the platform 
> >> +(default=0)");
> >> +
> >>    /*
> >>     * Some TCO specific functions
> >>     */
> >> @@ -243,6 +248,10 @@ static int iTCO_wdt_start(struct watchdog_device
> >> *wd_dev)
> >>         struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
> >>         unsigned int val;
> >>
> >> +     /* force_no_reboot will prevent to unset NO_REBOOT bit */
> >> +     if (force_no_reboot)
> >> +           return -EIO;
> >> +
> > It seems to me that this flag prevents the watchdog from being started, and on top it would return an unreasonable error (-EIO).
> > 
> > I don't see the point of this patch, sorry.
> > 
> > Guenter
> > 
> >>         spin_lock(&p->io_lock);
> >>
> >>         iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout); @@ -250,7
> >> +259,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
> >>         /* disable chipset's NO_REBOOT bit */
> >>         if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
> >>               spin_unlock(&p->io_lock);
> >> -           pr_err("failed to reset NO_REBOOT flag, reboot disabled 
> >> by hardware/BIOS\n");
> >> +           pr_err("failed to reset NO_REBOOT flag, reboot disabled 
> >> +by hardware/BIOS/rc_cmd\n");
> >>               return -EIO;
> >>         }
> >>
> >> --
> >> 2.7.4
> >>
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-watchdog" in the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
