Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:41305 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389066AbeHGSBW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 7 Aug 2018 14:01:22 -0400
Date: Tue, 7 Aug 2018 09:46:26 -0600
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: hpwdt: Initialize pretimeout from module
 parameter.
Message-ID: <20180807154626.GA21979@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-2-git-send-email-jerry.hoemann@hpe.com>
 <1635a9b2-6b2a-fd57-13ea-d99494dbfdec@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635a9b2-6b2a-fd57-13ea-d99494dbfdec@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 04, 2018 at 06:08:17PM -0700, Guenter Roeck wrote:
> On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> > When the pretimeout is specified as a module parameter, the
> > value should be reflected in hpwdt_dev.pretimeout.  The default
> > (on) case is correct.  But, when disabling pretimeout, the value
> > should be set to zero in hpwdt_dev.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >   drivers/watchdog/hpwdt.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 9dc62a4..369022d 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -313,6 +313,11 @@ static int hpwdt_init_one(struct pci_dev *dev,
> >   	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
> >   		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
> > +#ifdef CONFIG_HPWDT_NMI_DECODING
> > +	if (!pretimeout)
> > +		hpwdt_dev.pretimeout = 0;
> > +#endif
> > +
> 
> Seems to me that
> 	hpwdt_dev.pretimeout = pretimeout ? PRETIMEOUT_SEC : 0;
> would accomplish the same without ifdef. Also, that would make
> the conditional initialization in hpwdt_dev unnecessary,
> saving us some more ifdefs.
> 
> Guenter

Will do.

Thanks.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
