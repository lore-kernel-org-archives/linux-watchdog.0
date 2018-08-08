Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:34112 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHVdP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 8 Aug 2018 17:33:15 -0400
Date: Wed, 8 Aug 2018 13:12:10 -0600
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] watchdog: hpwdt: Claim NMI from iLO
Message-ID: <20180808191210.GA6695@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-3-git-send-email-jerry.hoemann@hpe.com>
 <b4de8a19-00c6-fcca-2414-197056ef27bc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4de8a19-00c6-fcca-2414-197056ef27bc@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 04, 2018 at 06:09:05PM -0700, Guenter Roeck wrote:
> On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> > The hwpdt driver is overloaded for handling both the iLO
> > watchdog and the explicit "Generate NMI to System" virutal
> > button.
> > 
> > Claim the iLO NMI virtual button even if we are not claiming
> > the iLO watchdog pretimeout.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> 
> Guess you know what you are doing here.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Unfortunately the underlying documentation isn't publically available.
I am going loosen the check in version two, but current upstream
is definitely wrong for reasons above.

> 
> > ---
> >   drivers/watchdog/hpwdt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 369022d..8a85ddd 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -162,7 +162,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >   	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
> >   		return NMI_DONE;
> > -	if (ilo5 && !pretimeout)
> > +	if (ilo5 && !pretimeout && !(mynmi & 0x4))
> >   		return NMI_DONE;
> >   	hpwdt_stop();
> > 

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
