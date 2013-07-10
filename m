Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [213.199.154.187] ([213.199.154.187]:53513 "EHLO
	db8outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752561Ab3GJO4m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Jul 2013 10:56:42 -0400
Message-ID: <1373468148.8797.0.camel@linux-builds1>
Subject: Re: [PATCH] watchdog: dw: Enable OF support for DW watchdog timer.
From: Dinh Nguyen <dinguyen@altera.com>
To: Jamie Iles <jamie@jamieiles.com>
CC: <linux-watchdog@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <dinh.linux@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>
Date: Wed, 10 Jul 2013 09:55:48 -0500
In-Reply-To: <20130710104101.GA3552@page>
References: <1373411377-5170-1-git-send-email-dinguyen@altera.com>
	 <20130710104101.GA3552@page>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 2013-07-10 at 11:41 +0100, Jamie Iles wrote:
> Hi Dinh,
> 
> On Tue, Jul 09, 2013 at 06:09:37PM -0500, dinguyen@altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add device tree support to the DW watchdog timer.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > Cc: Jamie Iles <jamie@jamieiles.com>
> > Cc: Viresh Kumar <viresh.kumar@st.com>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > Cc: Pavel Machek <pavel@denx.de>
> > ---
> >  .../devicetree/bindings/watchdog/dw_wdt.txt        |   16 ++++++++++++++++
> >  drivers/watchdog/dw_wdt.c                          |    7 +++++++
> >  2 files changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> >
> > diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> > index 2037669..f7eec38 100644
> > --- a/drivers/watchdog/dw_wdt.c
> > +++ b/drivers/watchdog/dw_wdt.c
> > @@ -343,12 +343,19 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id dw_wdt_of_match[] = {
> > +	{ .compatible = "snps,dw-wdt", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, dw_wdt_of_match);
> > +
> >  static struct platform_driver dw_wdt_driver = {
> >  	.probe		= dw_wdt_drv_probe,
> >  	.remove		= dw_wdt_drv_remove,
> >  	.driver		= {
> >  		.name	= "dw_wdt",
> >  		.owner	= THIS_MODULE,
> > +		.of_match_table = dw_wdt_of_match,
> 
> I think we want:
> 
> 		.of_match_table = of_match_ptr(dw_wdt_of_match),
> 
> as the module doesn't have an OF dependency.

Thanks Jamie, I'll send a v2 with your Ack and comment.

Dinh
> 
> Otherwise looks good to me.
> 
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> 
> Thanks,
> 
> Jamie
> 



