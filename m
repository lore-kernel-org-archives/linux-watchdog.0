Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46546 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492AbbHRGD3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 02:03:29 -0400
Date: Tue, 18 Aug 2015 11:33:26 +0530
From: Pratyush Anand <panand@redhat.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: linux-watchdog@vger.kernel.org, dyoung@redhat.com,
	dzickus@redhat.com
Subject: Re: [PATCH 28/37] watchdog: digicolor: Fix parent of watchdog_device
Message-ID: <20150818060326.GD27149@dhcppc13.redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
 <d84aa2598fda3d7cc9c3b6092def423b79109ee7.1439524806.git.panand@redhat.com>
 <20150818054136.GT2765@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150818054136.GT2765@tarshish>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Baruch,

Thanks a lot for the question.

On 18/08/2015:08:41:36 AM, Baruch Siach wrote:
> Hi Pratyush Anand,
> 
> On Tue, Aug 18, 2015 at 10:18:01AM +0530, Pratyush Anand wrote:
> > Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
> > is populated.
> > 
> > cc: Baruch Siach <baruch@tkos.co.il>
> > Signed-off-by: Pratyush Anand <panand@redhat.com>
> > ---
> >  drivers/watchdog/digicolor_wdt.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
> > index 31d8e4936611..50abe1bf62a5 100644
> > --- a/drivers/watchdog/digicolor_wdt.c
> > +++ b/drivers/watchdog/digicolor_wdt.c
> > @@ -143,6 +143,7 @@ static int dc_wdt_probe(struct platform_device *pdev)
> >  	}
> >  	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
> >  	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
> > +	dc_wdt_wdd.parent = &pdev->dev;
> 
> Is there a reasonable way do this for all drivers (at least by default) in 
> generic code?

watchdog_register_device does not have a arg with strcut device *.
Probably, we can do it in watchdog_init_timeout as a default.
But, all the driver does not call watchdog_init_timeout :(

$ git grep watchdog_init_timeout drivers/watchdog/ | wc -l
29
$ git grep watchdog_register_device drivers/watchdog/ | wc -l
67

So, Other than the implementation in patch series, 
I do not see a way either without changing watchdog_register_device
prototype, or without calling watchdog_init_timeout from each driver.

~Pratyush
