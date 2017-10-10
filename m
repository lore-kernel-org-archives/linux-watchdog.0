Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54976 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbdJJQDO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2017 12:03:14 -0400
Date: Tue, 10 Oct 2017 08:05:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: "winton.liu" <18502523564@163.com>, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1374: wdt:support suspend/resume for watchdog
Message-ID: <20171010150514.GB1879@roeck-us.net>
References: <1507641172-6099-1-git-send-email-18502523564@163.com>
 <8b80788f-5906-38a5-4b40-0a78f0ab55d9@roeck-us.net>
 <20171010135134.2zepquujhfwbhxoq@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010135134.2zepquujhfwbhxoq@piout.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 10, 2017 at 03:51:34PM +0200, Alexandre Belloni wrote:
> On 10/10/2017 at 06:41:15 -0700, Guenter Roeck wrote:
> > On 10/10/2017 06:12 AM, winton.liu wrote:
> > > When enable CONFIG_RTC_DRV_DS1374_WDT use as watchdog,
> > > in suspend mode, watchdog is still working but no daemon
> > > patting the watchdog. The system will reboot if timeout.
> > > 
> > > Add support suspend/resume for watchdog.
> > > suspend: disable the watchdog
> > > resume: disable existing watchdog, reload watchdog timer, enable watchdog
> > > 
> > > Signed-off-by: winton.liu <18502523564@163.com>
> > > ---
> > >   drivers/rtc/rtc-ds1374.c | 31 +++++++++++++++++++++++++++++++
> > >   1 file changed, 31 insertions(+)
> > > 
> > > diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> > > index 38a2e9e..642e31d 100644
> > > --- a/drivers/rtc/rtc-ds1374.c
> > > +++ b/drivers/rtc/rtc-ds1374.c
> > > @@ -437,6 +437,29 @@ static void ds1374_wdt_ping(void)
> > >   		pr_info("WD TICK FAIL!!!!!!!!!! %i\n", ret);
> > >   }
> > > +static void ds1374_wdt_resume(void)
> > > +{
> > > +	int ret = -ENOIOCTLCMD;
> > 
> > Useless initialization (yes, I can see that this is widely done in the driver,
> > but that doesn't make it better).
> > 
> > > +	int cr;
> > > +
> > > +	cr = i2c_smbus_read_byte_data(save_client, DS1374_REG_CR);
> > > +
> > > +	/* Disable any existing watchdog/alarm before setting the new one */
> > > +	cr &= ~DS1374_REG_CR_WACE;
> > > +
> > > +	i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
> > > +
> > > +	/* Reload watchdog timer */
> > > +	ds1374_wdt_ping();
> > > +
> > > +	/* Enable watchdog timer */
> > > +	cr |= DS1374_REG_CR_WACE | DS1374_REG_CR_WDALM;
> > > +	cr &= ~DS1374_REG_CR_AIE;
> > > +
> > > +	ret = i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
> > > +
> > Extra empty line. Also, returns void, so what is the point of assigning
> > the result to ret ?
> > 
> > > +}
> > 
> > Unless I am missing something, this unconditionally starts the watchdog
> > at resume time. So if it was not running before, it will be started anyway,
> > and the system will reboot since there will be no ping.
> > 
> 
> Also, I'm still not convinced this is the right thing to do. I have seen
> many systems were it was desirable to let the watchdog run while the
> system is suspended. It ensures it will either wake up or reboot. If you
> don't want that, why not disabling the watchdog from userspace before
> going to suspend?
> 

Usually watchdog drivers supporting suspend/resume do handle it this way.
Maybe that depends on the HW. Expecting user space to do it makes it
even more racy than it already is, since there is no watchdog protection
after it has been disabled, so I am not sure if that is really better.
Does anyone happen to know if/how systemd and watchdogd are handling
this situation ?

> > I assume it is guaranteed that the chip doesn't forget the previously
> > configured timeout on resume.
> > 
> > Overall the driver would really benefit from a conversion to the watchdog
> > subsystem.
> > 
> 
> That is the point of https://www.spinics.net/lists/linux-watchdog/msg12095.html

Ah, yes, and I even provided feedback. Hope I didn't miss an updated
version of that patch. Either case, seems to me we should wait for that
patch to make it in before accepting any further changes to the driver.

Guenter
