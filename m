Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44408 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeAPUQs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 16 Jan 2018 15:16:48 -0500
Date: Tue, 16 Jan 2018 12:16:47 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lyude Paul <lyude@redhat.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>
Subject: Re: [03/12] watchdog: sp5100_tco: Use request_muxed_region where
 possible
Message-ID: <20180116201647.GB9484@roeck-us.net>
References: <1514149457-20273-4-git-send-email-linux@roeck-us.net>
 <1516131863.18904.8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1516131863.18904.8.camel@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 16, 2018 at 02:44:23PM -0500, Lyude Paul wrote:
> On Sun, 2017-12-24 at 13:04 -0800, Guenter Roeck wrote:
> > Use request_muxed_region for multiplexed IO memory regions.
> > Also, SP5100_IO_PM_INDEX_REG/SP5100_IO_PM_DATA_REG are only
> > used during initialization; it is unnecessary to keep the
> > address range reserved.
> 
> Patches like this should probably be done at a rate of one patch/per
> functional change so it's easier to bisect in the future if something breaksw.
> Could you split this patch into two, one for switching over to
> request_muxed_region() and the other for removing the release_region() calls?

The release_region calls are not removed; they only moved into
sp5100_tco_setupdevice(). I saw that as one change, but I won't argue.
I'll split into two patches if the series does not make it into 4.16.

Thanks,
Guenter

> > 
> > Cc: Zoltán Böszörményi <zboszor@pr.hu>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/watchdog/sp5100_tco.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> > index 05f9d27a306a..11109ac959e2 100644
> > --- a/drivers/watchdog/sp5100_tco.c
> > +++ b/drivers/watchdog/sp5100_tco.c
> > @@ -379,8 +379,8 @@ static unsigned char sp5100_tco_setupdevice(void)
> >  	}
> >  
> >  	/* Request the IO ports used by this driver */
> > -	if (!request_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE,
> > -			    dev_name)) {
> > +	if (!request_muxed_region(SP5100_IO_PM_INDEX_REG,
> > +				  SP5100_PM_IOPORTS_SIZE, dev_name)) {
> >  		pr_err("I/O address 0x%04x already in use\n",
> >  		       SP5100_IO_PM_INDEX_REG);
> >  		goto exit;
> > @@ -468,6 +468,7 @@ static unsigned char sp5100_tco_setupdevice(void)
> >  	 */
> >  	tco_timer_stop();
> >  
> > +	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
> >  	/* Done */
> >  	return 1;
> >  
> > @@ -521,7 +522,6 @@ static int sp5100_tco_init(struct platform_device *dev)
> >  exit:
> >  	iounmap(tcobase);
> >  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> > -	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
> >  	return ret;
> >  }
> >  
> > @@ -535,7 +535,6 @@ static void sp5100_tco_cleanup(void)
> >  	misc_deregister(&sp5100_tco_miscdev);
> >  	iounmap(tcobase);
> >  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> > -	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
> >  }
> >  
> >  static int sp5100_tco_remove(struct platform_device *dev)
> -- 
> Cheers,
> 	Lyude Paul
