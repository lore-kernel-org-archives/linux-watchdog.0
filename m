Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:44846 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbbBYLIU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Feb 2015 06:08:20 -0500
Received: by wggx12 with SMTP id x12so2844298wgg.11
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Feb 2015 03:08:19 -0800 (PST)
Date: Wed, 25 Feb 2015 11:08:09 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH v3 7/8] rtc: st: add new driver for ST's
 LPC RTC
Message-ID: <20150225110809.GH21323@x1>
References: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
 <1424260154-12868-8-git-send-email-lee.jones@linaro.org>
 <20150223101223.GA14142@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150223101223.GA14142@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Feb 2015, Peter Griffin wrote:
> On Wed, 18 Feb 2015, Lee Jones wrote:
>=20
> > ST's Low Power Controller (LPC) controls two devices; watchdog and RT=
C.
> > Only one of the devices can be used at any one time.  This is enforce=
d
> > by the correlating MFD driver.  This portion of the driver-set contro=
ls
> > the Real Time Clock.
>=20
> <snip>
>=20
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&rtc->lock, flags);
> > +
> > +	writel(1, rtc->ioaddr + LPC_WDT_OFF);
> > +
> > +	writel(msb, rtc->ioaddr + LPC_LPA_MSB_OFF);
> > +	writel(lsb, rtc->ioaddr + LPC_LPA_LSB_OFF);
> > +	writel(1, rtc->ioaddr + LPC_LPA_START_OFF);
> > +
> > +	writel(0, rtc->ioaddr + LPC_WDT_OFF);
>=20
> I think all the writel IO accessors in this driver can be replaced
> with the *_relaxed variant. This will avoid the overhead of taking a
> spinlock in the l2 outer cache part of writel.

Yes, there is no technical reason why we can't use the relaxed
variants.  Will fix.

> > +#ifdef CONFIG_PM_SLEEP
> > +static int st_rtc_suspend(struct device *dev)
> > +{
> > +	struct st_rtc *rtc =3D dev_get_drvdata(dev);
> > +
> > +	if (device_may_wakeup(dev))
> > +		return 0;
> > +
> > +	writel(1, rtc->ioaddr + LPC_WDT_OFF);
> > +	writel(0, rtc->ioaddr + LPC_LPA_START_OFF);
> > +	writel(0, rtc->ioaddr + LPC_WDT_OFF);
>=20
> Is there a reason for not disabling the IP clock in suspend / resume fu=
nctions?

There is.  It will stop the alarm timer, which is undesirable.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
