Return-path: <alexandre.belloni@free-electrons.com>
Date: Thu, 2 Mar 2017 18:54:30 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Wenyou.Yang@microchip.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] watchdog: sama5d4: fix race condition
Message-ID: <20170302175430.4b3j7ptij525vrhm@piout.net>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
 <20170302173114.28508-3-alexandre.belloni@free-electrons.com>
 <20170302174224.GC28554@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170302174224.GC28554@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 02/03/2017 at 09:42:24 -0800, Guenter Roeck wrote:
> On Thu, Mar 02, 2017 at 06:31:12PM +0100, Alexandre Belloni wrote:
> > WDT_MR and WDT_CR must not updated within three slow clock periods after
> > the last ping (write to WDT_CR or WDT_MR). Ensure enough time has elapsed
> > before writing those registers.
> > wdt_write() waits for 4 periods to ensure at least 3 edges are seen by the
> > IP.
> > 
> 
> Would it be possible to use min_hw_heartbeat_ms for this purpose ?
> 

I don't think so unless you want the core to also use that delay between
__watchdog_ping, watchdog_start, watchdog_set_timeout and watchdog_stop.
Currently, it is only between two calls of __watchdog_ping,

> Thanks,
> Guenter
> 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  drivers/watchdog/sama5d4_wdt.c | 33 +++++++++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> > index 5cee20caca78..362fd229786d 100644
> > --- a/drivers/watchdog/sama5d4_wdt.c
> > +++ b/drivers/watchdog/sama5d4_wdt.c
> > @@ -6,6 +6,7 @@
> >   * Licensed under GPLv2.
> >   */
> >  
> > +#include <linux/delay.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> > @@ -29,6 +30,7 @@ struct sama5d4_wdt {
> >  	struct watchdog_device	wdd;
> >  	void __iomem		*reg_base;
> >  	u32			mr;
> > +	unsigned long		last_ping;
> >  };
> >  
> >  static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
> > @@ -49,8 +51,29 @@ MODULE_PARM_DESC(nowayout,
> >  #define wdt_read(wdt, field) \
> >  	readl_relaxed((wdt)->reg_base + (field))
> >  
> > -#define wdt_write(wtd, field, val) \
> > -	writel_relaxed((val), (wdt)->reg_base + (field))
> > +/* 4 slow clock periods is 4/32768 = 122.07µs*/
> > +#define WDT_DELAY	usecs_to_jiffies(123)
> > +
> > +static void wdt_write(struct sama5d4_wdt *wdt, u32 field, u32 val)
> > +{
> > +	/*
> > +	 * WDT_CR and WDT_MR must not be modified within three slow clock
> > +	 * periods following a restart of the watchdog performed by a write
> > +	 * access in WDT_CR.
> > +	 */
> > +	while (time_before(jiffies, wdt->last_ping + WDT_DELAY))
> > +		usleep_range(30, 125);
> > +	writel_relaxed(val, wdt->reg_base + field);
> > +	wdt->last_ping = jiffies;
> > +}
> > +
> > +static void wdt_write_nosleep(struct sama5d4_wdt *wdt, u32 field, u32 val)
> > +{
> > +	if (time_before(jiffies, wdt->last_ping + WDT_DELAY))
> > +		udelay(123);
> > +	writel_relaxed(val, wdt->reg_base + field);
> > +	wdt->last_ping = jiffies;
> > +}
> >  
> >  static int sama5d4_wdt_start(struct watchdog_device *wdd)
> >  {
> > @@ -164,11 +187,12 @@ static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
> >  	 * Else, we have to disable it properly.
> >  	 */
> >  	if (wdt_enabled) {
> > -		wdt_write(wdt, AT91_WDT_MR, wdt->mr);
> > +		wdt_write_nosleep(wdt, AT91_WDT_MR, wdt->mr);
> >  	} else {
> >  		reg = wdt_read(wdt, AT91_WDT_MR);
> >  		if (!(reg & AT91_WDT_WDDIS))
> > -			wdt_write(wdt, AT91_WDT_MR, reg | AT91_WDT_WDDIS);
> > +			wdt_write_nosleep(wdt, AT91_WDT_MR,
> > +					  reg | AT91_WDT_WDDIS);
> >  	}
> >  	return 0;
> >  }
> > @@ -193,6 +217,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
> >  	wdd->ops = &sama5d4_wdt_ops;
> >  	wdd->min_timeout = MIN_WDT_TIMEOUT;
> >  	wdd->max_timeout = MAX_WDT_TIMEOUT;
> > +	wdt->last_ping = jiffies;
> >  
> >  	watchdog_set_drvdata(wdd, wdt);
> >  
> > -- 
> > 2.11.0
> > 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
