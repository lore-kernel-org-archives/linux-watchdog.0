Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34983 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbdACXja (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 18:39:30 -0500
Date: Tue, 3 Jan 2017 15:38:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH 2/4] watchdog: iTCO_wdt: Use device managed resources
Message-ID: <20170103233851.GA13952@roeck-us.net>
References: <1483454364-28650-1-git-send-email-linux@roeck-us.net>
 <1483454364-28650-2-git-send-email-linux@roeck-us.net>
 <CAHp75VeUC+Nn4am-O2chdS-j953R1Bo-U9DFu4ViLTyjgM2qLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeUC+Nn4am-O2chdS-j953R1Bo-U9DFu4ViLTyjgM2qLA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 04, 2017 at 12:41:56AM +0200, Andy Shevchenko wrote:
> On Tue, Jan 3, 2017 at 4:39 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > Using device managed resources simplifies error handling and cleanup,
> > and to reduce the likelyhood of errors.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Does it make sense to convert to dev_err() at some point?
> 
Sounds like an idea. Let me play with it.

Thanks,
Guenter

> > ---
> >  drivers/watchdog/iTCO_wdt.c | 80 ++++++++++-----------------------------------
> >  1 file changed, 17 insertions(+), 63 deletions(-)
> >
> > diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> > index a35a9164ccd0..eed1dee6de19 100644
> > --- a/drivers/watchdog/iTCO_wdt.c
> > +++ b/drivers/watchdog/iTCO_wdt.c
> > @@ -401,27 +401,6 @@ static const struct watchdog_ops iTCO_wdt_ops = {
> >   *     Init & exit routines
> >   */
> >
> > -static void iTCO_wdt_cleanup(struct iTCO_wdt_private *p)
> > -{
> > -       /* Stop the timer before we leave */
> > -       if (!nowayout)
> > -               iTCO_wdt_stop(&p->wddev);
> > -
> > -       /* Deregister */
> > -       watchdog_unregister_device(&p->wddev);
> > -
> > -       /* release resources */
> > -       release_region(p->tco_res->start,
> > -                       resource_size(p->tco_res));
> > -       release_region(p->smi_res->start,
> > -                       resource_size(p->smi_res));
> > -       if (p->iTCO_version >= 2) {
> > -               iounmap(p->gcs_pmc);
> > -               release_mem_region(p->gcs_pmc_res->start,
> > -                               resource_size(p->gcs_pmc_res));
> > -       }
> > -}
> > -
> >  static int iTCO_wdt_probe(struct platform_device *dev)
> >  {
> >         struct itco_wdt_platform_data *pdata = dev_get_platdata(&dev->dev);
> > @@ -458,41 +437,28 @@ static int iTCO_wdt_probe(struct platform_device *dev)
> >                 p->gcs_pmc_res = platform_get_resource(dev,
> >                                                        IORESOURCE_MEM,
> >                                                        ICH_RES_MEM_GCS_PMC);
> > -
> > -               if (!p->gcs_pmc_res)
> > -                       return -ENODEV;
> > -
> > -               if (!request_mem_region(p->gcs_pmc_res->start,
> > -                                       resource_size(p->gcs_pmc_res),
> > -                                       dev->name))
> > -                       return -EBUSY;
> > -
> > -               p->gcs_pmc = ioremap(p->gcs_pmc_res->start,
> > -                                    resource_size(p->gcs_pmc_res));
> > -               if (!p->gcs_pmc) {
> > -                       ret = -EIO;
> > -                       goto unreg_gcs_pmc;
> > -               }
> > +               p->gcs_pmc = devm_ioremap_resource(&dev->dev, p->gcs_pmc_res);
> > +               if (IS_ERR(p->gcs_pmc))
> > +                       return PTR_ERR(p->gcs_pmc);
> >         }
> >
> >         /* Check chipset's NO_REBOOT bit */
> >         if (iTCO_wdt_unset_NO_REBOOT_bit(p) &&
> >             iTCO_vendor_check_noreboot_on()) {
> >                 pr_info("unable to reset NO_REBOOT flag, device disabled by hardware/BIOS\n");
> > -               ret = -ENODEV;  /* Cannot reset NO_REBOOT bit */
> > -               goto unmap_gcs_pmc;
> > +               return -ENODEV; /* Cannot reset NO_REBOOT bit */
> >         }
> >
> >         /* Set the NO_REBOOT bit to prevent later reboots, just for sure */
> >         iTCO_wdt_set_NO_REBOOT_bit(p);
> >
> >         /* The TCO logic uses the TCO_EN bit in the SMI_EN register */
> > -       if (!request_region(p->smi_res->start,
> > -                           resource_size(p->smi_res), dev->name)) {
> > +       if (!devm_request_region(&dev->dev, p->smi_res->start,
> > +                                resource_size(p->smi_res),
> > +                                dev->name)) {
> >                 pr_err("I/O address 0x%04llx already in use, device disabled\n",
> >                        (u64)SMI_EN(p));
> > -               ret = -EBUSY;
> > -               goto unmap_gcs_pmc;
> > +               return -EBUSY;
> >         }
> >         if (turn_SMI_watchdog_clear_off >= p->iTCO_version) {
> >                 /*
> > @@ -504,12 +470,12 @@ static int iTCO_wdt_probe(struct platform_device *dev)
> >                 outl(val32, SMI_EN(p));
> >         }
> >
> > -       if (!request_region(p->tco_res->start,
> > -                           resource_size(p->tco_res), dev->name)) {
> > +       if (!devm_request_region(&dev->dev, p->tco_res->start,
> > +                                resource_size(p->tco_res),
> > +                                dev->name)) {
> >                 pr_err("I/O address 0x%04llx already in use, device disabled\n",
> >                        (u64)TCOBASE(p));
> > -               ret = -EBUSY;
> > -               goto unreg_smi;
> > +               return -EBUSY;
> >         }
> >
> >         pr_info("Found a %s TCO device (Version=%d, TCOBASE=0x%04llx)\n",
> > @@ -555,37 +521,25 @@ static int iTCO_wdt_probe(struct platform_device *dev)
> >                         WATCHDOG_TIMEOUT);
> >         }
> >
> > -       ret = watchdog_register_device(&p->wddev);
> > +       ret = devm_watchdog_register_device(&dev->dev, &p->wddev);
> >         if (ret != 0) {
> >                 pr_err("cannot register watchdog device (err=%d)\n", ret);
> > -               goto unreg_tco;
> > +               return ret;
> >         }
> >
> >         pr_info("initialized. heartbeat=%d sec (nowayout=%d)\n",
> >                 heartbeat, nowayout);
> >
> >         return 0;
> > -
> > -unreg_tco:
> > -       release_region(p->tco_res->start, resource_size(p->tco_res));
> > -unreg_smi:
> > -       release_region(p->smi_res->start, resource_size(p->smi_res));
> > -unmap_gcs_pmc:
> > -       if (p->iTCO_version >= 2)
> > -               iounmap(p->gcs_pmc);
> > -unreg_gcs_pmc:
> > -       if (p->iTCO_version >= 2)
> > -               release_mem_region(p->gcs_pmc_res->start,
> > -                                  resource_size(p->gcs_pmc_res));
> > -       return ret;
> >  }
> >
> >  static int iTCO_wdt_remove(struct platform_device *dev)
> >  {
> >         struct iTCO_wdt_private *p = platform_get_drvdata(dev);
> >
> > -       if (p->tco_res || p->smi_res)
> > -               iTCO_wdt_cleanup(p);
> > +       /* Stop the timer before we leave */
> > +       if (!nowayout)
> > +               iTCO_wdt_stop(&p->wddev);
> >
> >         return 0;
> >  }
> > --
> > 2.7.4
> >
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
