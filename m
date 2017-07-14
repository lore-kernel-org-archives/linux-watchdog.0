Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56607 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdGNT1L (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 15:27:11 -0400
Date: Fri, 14 Jul 2017 12:27:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Moritz Fischer <mdf@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        wim@iguana.be, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 2/2] mfd: ds1374: Add Dallas/Maxim DS1374 Multi Function
 Device
Message-ID: <20170714192708.GB16125@roeck-us.net>
References: <1499975665-14581-1-git-send-email-mdf@kernel.org>
 <1499975665-14581-2-git-send-email-mdf@kernel.org>
 <c37eaed9-10aa-190e-fa0e-bdce9277664b@roeck-us.net>
 <20170714165423.GA9283@tyrael.ni.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714165423.GA9283@tyrael.ni.corp.natinst.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jul 14, 2017 at 09:54:23AM -0700, Moritz Fischer wrote:
> Hi Guenter,
> 
> On Thu, Jul 13, 2017 at 08:57:52PM -0700, Guenter Roeck wrote:
> > On 07/13/2017 12:54 PM, Moritz Fischer wrote:
> > > From: Moritz Fischer <moritz.fischer@ettus.com>
> > > 
> > > Add support for the Maxim/Dallas DS1374 RTC/WDT with trickle charger.
> > > The device can either be configured as simple RTC, as simple RTC with
> > > Alarm (IRQ) as well as simple RTC with watchdog timer.
> > > 
> > > Break up the old monolithic driver in drivers/rtc/rtc-ds1374.c into:
> > > - rtc part in drivers/rtc/rtc-ds1374.c
> > > - watchdog part under drivers/watchdog/ds1374-wdt.c
> > > - mfd part drivers/mfd/ds1374.c
> > > 
> > > The MFD part takes care of trickle charging and mode selection,
> > > since the usage modes of a) RTC + Alarm or b) RTC + WDT
> > > are mutually exclusive.
> > > 
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > 
> > [ Only reviewing watchdog part ]
> > 
[ ... ]

> > > +}
> > > +
> > > +static int ds1374_wdt_start(struct watchdog_device *wdog)
> > > +{
> > > +	int err;
> > > +	struct ds1374_wdt *ds1374_wdt = watchdog_get_drvdata(wdog);
> > > +
> > > +	err = ds1374_wdt_set_timeout(wdog, wdog->timeout);
> > > +	if (err) {
> > > +		dev_err(ds1374_wdt->dev, "%s: failed to set timeout (%d) %u\n",
> > > +			__func__, err, wdog->timeout);
> > > +		return err;
> > > +	}
> > > +
> > > +	err = ds1374_wdt_ping(wdog);
> > > +	if (err) {
> > > +		dev_err(ds1374_wdt->dev, "%s: failed to ping (%d)\n", __func__,
> > > +			err);
> 
> I assume you'd want to get rid of that one too?

Yes.

> > 
> > This may bypass MAGICCLOSE: If the watchdog daemon is killed and the module removed,
> > the watchdog will be stopped. Is this really what you want ? If so, why set MAGICCLOSE
> > in the first place ?
> 
> So your suggestion would be:
> 
> - if (!nowayout)
> -	ds1374_wdt_stop(&priv->wdd)
> 
Correct. Just drop the remove function.

Thanks,
Guenter
