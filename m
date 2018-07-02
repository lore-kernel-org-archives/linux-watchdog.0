Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42836 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeGBNUp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 2 Jul 2018 09:20:45 -0400
Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
To: "Tian, Baofeng" <baofeng.tian@intel.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <140371d6-4bbb-6377-a570-5253c5f98e0e@roeck-us.net>
Date: Mon, 2 Jul 2018 06:20:43 -0700
MIME-Version: 1.0
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/02/2018 12:30 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
> 
> Setting "force_no_reboot" parameter to true (y/Y/1) will have
> the effect to prevent to reset the NO_REBOOT flag thus
> preventing the iTCO to reboot the platform, if not set
> or set to false, then system will reboot after about 30s.
> 
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>

Your e-mail address is messed up.

> ---
>   drivers/watchdog/iTCO_wdt.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 347f038..255318b 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -131,6 +131,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
>   MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
>        "Turn off SMI clearing watchdog (depends on TCO-version)(default=1)");
> 
> +static bool force_no_reboot;
> +module_param(force_no_reboot, bool, 0);
> +MODULE_PARM_DESC(force_no_reboot,
> +           "Prevents the watchdog rebooting the platform (default=0)");
> +
>   /*
>    * Some TCO specific functions
>    */
> @@ -243,6 +248,10 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>        struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
>        unsigned int val;
> 
> +     /* force_no_reboot will prevent to unset NO_REBOOT bit */
> +     if (force_no_reboot)
> +           return -EIO;
> +
It seems to me that this flag prevents the watchdog from being started,
and on top it would return an unreasonable error (-EIO).

I don't see the point of this patch, sorry.

Guenter

>        spin_lock(&p->io_lock);
> 
>        iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
> @@ -250,7 +259,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>        /* disable chipset's NO_REBOOT bit */
>        if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
>              spin_unlock(&p->io_lock);
> -           pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
> +           pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS/rc_cmd\n");
>              return -EIO;
>        }
> 
> -- 
> 2.7.4
> 

