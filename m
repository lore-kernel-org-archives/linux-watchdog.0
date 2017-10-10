Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44431 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755866AbdJJNvf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2017 09:51:35 -0400
Date: Tue, 10 Oct 2017 15:51:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "winton.liu" <18502523564@163.com>, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1374: wdt:support suspend/resume for watchdog
Message-ID: <20171010135134.2zepquujhfwbhxoq@piout.net>
References: <1507641172-6099-1-git-send-email-18502523564@163.com>
 <8b80788f-5906-38a5-4b40-0a78f0ab55d9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b80788f-5906-38a5-4b40-0a78f0ab55d9@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/10/2017 at 06:41:15 -0700, Guenter Roeck wrote:
> On 10/10/2017 06:12 AM, winton.liu wrote:
> > When enable CONFIG_RTC_DRV_DS1374_WDT use as watchdog,
> > in suspend mode, watchdog is still working but no daemon
> > patting the watchdog. The system will reboot if timeout.
> > 
> > Add support suspend/resume for watchdog.
> > suspend: disable the watchdog
> > resume: disable existing watchdog, reload watchdog timer, enable watchdog
> > 
> > Signed-off-by: winton.liu <18502523564@163.com>
> > ---
> >   drivers/rtc/rtc-ds1374.c | 31 +++++++++++++++++++++++++++++++
> >   1 file changed, 31 insertions(+)
> > 
> > diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> > index 38a2e9e..642e31d 100644
> > --- a/drivers/rtc/rtc-ds1374.c
> > +++ b/drivers/rtc/rtc-ds1374.c
> > @@ -437,6 +437,29 @@ static void ds1374_wdt_ping(void)
> >   		pr_info("WD TICK FAIL!!!!!!!!!! %i\n", ret);
> >   }
> > +static void ds1374_wdt_resume(void)
> > +{
> > +	int ret = -ENOIOCTLCMD;
> 
> Useless initialization (yes, I can see that this is widely done in the driver,
> but that doesn't make it better).
> 
> > +	int cr;
> > +
> > +	cr = i2c_smbus_read_byte_data(save_client, DS1374_REG_CR);
> > +
> > +	/* Disable any existing watchdog/alarm before setting the new one */
> > +	cr &= ~DS1374_REG_CR_WACE;
> > +
> > +	i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
> > +
> > +	/* Reload watchdog timer */
> > +	ds1374_wdt_ping();
> > +
> > +	/* Enable watchdog timer */
> > +	cr |= DS1374_REG_CR_WACE | DS1374_REG_CR_WDALM;
> > +	cr &= ~DS1374_REG_CR_AIE;
> > +
> > +	ret = i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
> > +
> Extra empty line. Also, returns void, so what is the point of assigning
> the result to ret ?
> 
> > +}
> 
> Unless I am missing something, this unconditionally starts the watchdog
> at resume time. So if it was not running before, it will be started anyway,
> and the system will reboot since there will be no ping.
> 

Also, I'm still not convinced this is the right thing to do. I have seen
many systems were it was desirable to let the watchdog run while the
system is suspended. It ensures it will either wake up or reboot. If you
don't want that, why not disabling the watchdog from userspace before
going to suspend?

> I assume it is guaranteed that the chip doesn't forget the previously
> configured timeout on resume.
> 
> Overall the driver would really benefit from a conversion to the watchdog
> subsystem.
> 

That is the point of https://www.spinics.net/lists/linux-watchdog/msg12095.html

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
