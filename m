Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37411 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbbHFMA1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Aug 2015 08:00:27 -0400
Received: by wibhh20 with SMTP id hh20so20874861wib.0
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2015 05:00:26 -0700 (PDT)
Date: Thu, 6 Aug 2015 13:00:24 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Lee Jones <lee.jones@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH v3 3/3] iTCO_wdt: Add support for TCO on Intel
 Sunrisepoint
Message-ID: <20150806120024.GG4332@codeblueprint.co.uk>
References: <1438293541-26131-1-git-send-email-matt@codeblueprint.co.uk>
 <1438293541-26131-4-git-send-email-matt@codeblueprint.co.uk>
 <1438332064.29746.141.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438332064.29746.141.camel@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

(Sorry for the delay in replying)

On Fri, 31 Jul, at 11:41:04AM, Andy Shevchenko wrote:
> >  
> > +	if (val32 & enable_bit)
> > +		ret = -EIO;
> > +
> >  	return ret; /* returns: 0 = OK, -EIO = Error */
> 
> What about removing ret at all?
> 
> if (val32 & enable_bit)
>  return -EIO;
> 
> return 0;
 
Yeah, good catch. I'll make this change.

> >  }
> >  
> > @@ -503,12 +512,19 @@ static int iTCO_wdt_probe(struct 
> > platform_device *dev)
> >  		pdata->name, pdata->version, (u64)TCOBASE);
> >  
> >  	/* Clear out the (probably old) status */
> > -	if (iTCO_wdt_private.iTCO_version == 3) {
> > +	switch (iTCO_wdt_private.iTCO_version) {
> > +	case 4:
> > +		outw(0x0008, TCO1_STS);	/* Clear the Time 
> > Out Status bit */
> > +		outw(0x0002, TCO2_STS);	/* Clear 
> > SECOND_TO_STS bit */
> > +		break;
> > +	case 3:
> >  		outl(0x20008, TCO1_STS);
> > -	} else {
> > +		break;
> > +	default:
> 
> Same idea here: put cases explicitly for all existing versions?
> 
> case 2:
> case 1:
> default:
 
I intentionally didn't do that because I figured it was implied that
versions 2 and 1 are included in the default case. But I've no problem
with making this change. I'll send a v4.

-- 
Matt Fleming, Intel Open Source Technology Center
