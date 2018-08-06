Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:14094 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbeHGBaZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 6 Aug 2018 21:30:25 -0400
Date: Mon, 6 Aug 2018 17:19:01 -0600
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog: hpwdt: Display module parameters.
Message-ID: <20180806231901.GA32467@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-4-git-send-email-jerry.hoemann@hpe.com>
 <ba07e5f3-282f-0417-236d-57289d33f56c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba07e5f3-282f-0417-236d-57289d33f56c@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 04, 2018 at 06:13:20PM -0700, Guenter Roeck wrote:
> On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> > Print module parameters when the driver is loaded.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >   drivers/watchdog/hpwdt.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 8a85ddd..f098371 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -326,8 +326,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
> >   	}
> >   	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
> > -			", timer margin: %d seconds (nowayout=%d).\n",
> > -			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
> > +		", timeout : %d seconds (nowayout=%d) pretimeout=%s.\n",
> > +		HPWDT_VERSION, hpwdt_dev.timeout, nowayout,
> > +		pretimeout ? "on" : "off");
> When touching that, you might as well address
> 
> WARNING: quoted string split across lines


k. Think I'll split into two dev_info calls as line is too long
to fit into 80 chars w/o splitting.


> 
> Why did you add a space before ':' ? Personal preference ?

I think you're referring to "timeout : %d seconds".  Bad editting when
going from "timer margin:" to "timeout :".  I'll fix.

If you referring to the spaces around the ternary operator, that is
in coding-style although checkpatch accepts w/o spaces around the
operators.


> 
> Guenter
> 
> >   	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
> >   		ilo5 = true;
> > 

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
