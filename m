Return-Path: <wimvs@spo001.leaseweb.com>
Date: Sat, 22 Feb 2014 19:46:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
	monstr@monstr.eu, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 07/11] watchdog: xilinx: Use of_property_read_u32
Message-ID: <20140222184604.GB21504@spo001.leaseweb.com>
References: <cover.1392212059.git.michal.simek@xilinx.com> <7cbb10853a343c9d488346596f604909ab0668b9.1392212059.git.michal.simek@xilinx.com> <20140212171509.GB20012@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140212171509.GB20012@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi All,

> Hi Michal,
> 
> On Wed, Feb 12, 2014 at 02:41:21PM +0100, Michal Simek wrote:
> > Use of_property_read_u32 functions to clean probe function.
> > 
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > 
> > Changes in v3:
> > - Remove one if checking and use variable directly
> > 
> 
> Looks good.
> 
> Another comment/remark.
> 
> > 
> > -	pfreq = (u32 *)of_get_property(pdev->dev.of_node,
> > -					"clock-frequency", NULL);
> > -
> > -	if (pfreq == NULL) {
> > +	rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &pfreq);
> > +	if (rc) {
> >  		dev_warn(&pdev->dev,
> >  			 "The watchdog clock frequency cannot be obtained\n");
> >  		no_timeout = true;
> >  	}
> > 
> > -	tmptr = (u32 *)of_get_property(pdev->dev.of_node,
> > -					"xlnx,wdt-interval", NULL);
> > -	if (tmptr == NULL) {
> > +	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-interval",
> > +				  &xdev->wdt_interval);
> > +	if (rc) {
> >  		dev_warn(&pdev->dev,
> >  			 "Parameter \"xlnx,wdt-interval\" not found\n");
> >  		no_timeout = true;
> > -	} else {
> > -		xdev->wdt_interval = *tmptr;
> >  	}
> > 
> > -	tmptr = (u32 *)of_get_property(pdev->dev.of_node,
> > -					"xlnx,wdt-enable-once", NULL);
> > -	if (tmptr == NULL) {
> > +	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-enable-once",
> > +				  &enable_once);
> > +	if (rc)
> >  		dev_warn(&pdev->dev,
> >  			 "Parameter \"xlnx,wdt-enable-once\" not found\n");
> > -		watchdog_set_nowayout(xilinx_wdt_wdd, true);
> > -	}
> 
> All the above properties are optional. Is a warning really
> warranted in this case ? I usually associate a warning with
> something that is wrong, which is not the case here.
> 
> I would encourage you to drop those warnings, but that should be
> a separate patch.

I agree with Guenter: these are not really warnings. Seperate patch is thus welcome.

Kind regards,
Wim.
