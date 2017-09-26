Return-Path: <alexandre.belloni@free-electrons.com>
Return-path: <alexandre.belloni@free-electrons.com>
Date: Tue, 26 Sep 2017 12:22:39 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: 18502523564 <18502523564@163.com>
Cc: "a.zummo" <a.zummo@towertech.it>, linux-rtc <linux-rtc@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1374: wdt:support suspend/resume for watchdog
Message-ID: <20170926102239.qjmhfry4vtaow4gk@piout.net>
References: <1506340724-18108-1-git-send-email-18502523564@163.com>
 <20170925120742.ja54wu2orgai6fsr@piout.net>
 <tencent_BD3706918C1500105699D4E6@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_BD3706918C1500105699D4E6@qq.com>
List-ID: <linux-watchdog@vger.kernel.org>

(+Cc wdt maintainers)

On 26/09/2017 at 09:56:32 +0800, 18502523564 wrote:
> Hi Alexandre,
> 
> Thanks for your reply.
> Do you think is this a issue when using as a watchdog in suspend?
> I takes the drivers/watchdog/ subsystem for reference, some drivers in suspend
> also call disable_watchdog.Or do you have any  better suggestion?

I guess this is a question for the watchdog subsystem maintainers.
However, I think that everything can be handled properly from userspace
as I know some atmel based devices have their watchdog enabled while
the platform is suspended.

> Thank you.
> 
> 
> 
> 
> ------------------ Original ------------------
> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Date: 周一,9月 25,2017 20:07
> To: winton.liu <18502523564@163.com>
> Cc: a.zummo <a.zummo@towertech.it>, linux-rtc <linux-rtc@vger.kernel.org>,
> linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] rtc: ds1374: wdt:support suspend/resume for watchdog
> 
> 
> Hi,
> 
> On 25/09/2017 at 19:58:44 +0800, winton.liu wrote:
> > When enable CONFIG_RTC_DRV_DS1374_WDT use as watchdog,
> > in suspend mode, watchdog is still working but no daemon
> > patting the watchdog. The system will reboot if timeout.
> > So disable watchdog in suspend  and recover it in resume.
> >
> 
> That is definitively not what we want. Many people will want to still
> have the watchdog running when the platform is suspended. Your options
> are to either disable the watchdog before going to suspend or wake up
> the platform just in time to ping the watchdog.
> 
> > Signed-off-by: winton.liu <18502523564@163.com>
> > ---
> >  drivers/rtc/rtc-ds1374.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> > index 38a2e9e..e990773 100644
> > --- a/drivers/rtc/rtc-ds1374.c
> > +++ b/drivers/rtc/rtc-ds1374.c
> > @@ -690,6 +690,10 @@ static int ds1374_suspend(struct device *dev)
> >  {
> >       struct i2c_client *client = to_i2c_client(dev);
> >
> > +#ifdef CONFIG_RTC_DRV_DS1374_WDT
> > +     ds1374_wdt_disable();
> > +#endif
> > +
> >       if (client->irq > 0 && device_may_wakeup(&client->dev))
> >               enable_irq_wake(client->irq);
> >       return 0;
> > @@ -699,6 +703,10 @@ static int ds1374_resume(struct device *dev)
> >  {
> >       struct i2c_client *client = to_i2c_client(dev);
> >
> > +#ifdef CONFIG_RTC_DRV_DS1374_WDT
> > +     ds1374_wdt_settimeout(131072);
> > +#endif
> > +
> >       if (client->irq > 0 && device_may_wakeup(&client->dev))
> >               disable_irq_wake(client->irq);
> >       return 0;
> > --
> > 1.9.1
> >
> >
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
