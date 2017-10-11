Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36098 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdJKSqF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Oct 2017 14:46:05 -0400
Date: Wed, 11 Oct 2017 11:46:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Lowering the log level in watchdog_dev_register when err==-EBUSY
Message-ID: <20171011184603.GB8756@roeck-us.net>
References: <1507743991.3486.5.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507743991.3486.5.camel@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 11, 2017 at 06:46:31PM +0100, Radu Rendec wrote:
> Hello,
> 
> In a project I'm working on we have a valid use case where we activate
> both the i6300esb and softdog watchdogs. We always activate i6300esb
> first (which uses the "legacy" watchdog API) and then softdog. This
> gets us two "error" level messages (coming from watchdog_cdev_register)
> although softdog falls back to the "new" API and registers its char
> device just fine.
> 
> Since watchdog_cdev_register/watchdog_dev_register seem to be used only
> by watchdog_register_device and the latter always falls back to the
> "new" API, I'm thinking about lowering the log level of these messages
> when err is -EBUSY. Something along the lines of:
> 
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -928,11 +928,14 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>                 watchdog_miscdev.parent = wdd->parent;
>                 err = misc_register(&watchdog_miscdev);
>                 if (err != 0) {
> -                       pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
> -                               wdd->info->identity, WATCHDOG_MINOR, err);
> -                       if (err == -EBUSY)
> -                               pr_err("%s: a legacy watchdog module is probably present.\n",
> -                                       wdd->info->identity);
> +                       if (err == -EBUSY) {
> +                               pr_info("%s: cannot register miscdev on minor=%d (err=%d).\n",
> +                                               wdd->info->identity, WATCHDOG_MINOR, err);
> +                               pr_info("%s: a legacy watchdog module is probably present.\n",
> +                                               wdd->info->identity);
> +                       } else
> +                               pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
> +                                       wdd->info->identity, WATCHDOG_MINOR, err);
>                         old_wd_data = NULL;
>                         kfree(wd_data);
>                         return err;
> 
> Does this look like a good approach? If not, what would you recommend?
> In any case, I want to upstream the change, so better ask first :)
> 

I would suggest to convert the offending driver to use the watchdog subsystem
(and along the line remove the restriction of only supporting a single
instance). You have the hardware, so that should be a straightforward change.

Thanks,
Guenter
