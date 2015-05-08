Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33500 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbbEHK3n (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 May 2015 06:29:43 -0400
Received: by wgin8 with SMTP id n8so68385788wgi.0
        for <linux-watchdog@vger.kernel.org>; Fri, 08 May 2015 03:29:42 -0700 (PDT)
Date: Fri, 8 May 2015 11:29:38 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net
Subject: Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as sched
 clock' capability
Message-ID: <20150508102938.GD29044@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
 <1431074699.13593.4.camel@x220>
 <20150508093603.GB29044@x1>
 <1431078730.13593.14.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1431078730.13593.14.camel@x220>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Fri, 08 May 2015, Paul Bolle wrote:

> On Fri, 2015-05-08 at 10:36 +0100, Lee Jones wrote:
> > On Fri, 08 May 2015, Paul Bolle wrote:
> > > On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> > > > --- a/drivers/clocksource/Kconfig
> > > > +++ b/drivers/clocksource/Kconfig
> > >=20
> > > > +config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
> > > > +	bool
> > > > +	depends on CLKSRC_ST_LPC
> > > > +	default y
> > > > +	help
> > > > +	  Use Low Power controller timer clock source as sched_clock
> > >=20
> > > This adds, as far as I can see, a Kconfig symbol that will always b=
e in
> > > lockstep with CLKSRC_ST_LPC. Ie, CLKSRC_ST_LPC and
> > > CLKSRC_ST_LPC_TIMER_SCHED_CLOCK will always both be 'n' or both be =
'y'.
> > >=20
> > > Are there plans to break that lockstep in the future?
> >=20
> > What's stopping CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=3Dn?
>=20
> If CLKSRC_ST_LPC=3Dy you mean? The lack of a prompt, I'd say. Ie, you
> would need
> 	bool "A very short description"
>=20
> to be able to set these independently.
>=20
> But now I notice that I missed that there appears to be a problem with
> CLKSRC_ST_LPC too. I'll reply to 2/12 shortly.

Ah, you mean from menuconfig.  I almost forgot what that was. ;)

I can add a menu option, no problem.

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
