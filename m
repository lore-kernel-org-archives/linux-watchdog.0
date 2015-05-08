Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37233 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbbEHJgI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 May 2015 05:36:08 -0400
Received: by widdi4 with SMTP id di4so20878166wid.0
        for <linux-watchdog@vger.kernel.org>; Fri, 08 May 2015 02:36:07 -0700 (PDT)
Date: Fri, 8 May 2015 10:36:03 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net
Subject: Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as sched
 clock' capability
Message-ID: <20150508093603.GB29044@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
 <1431074699.13593.4.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1431074699.13593.4.camel@x220>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 08 May 2015, Paul Bolle wrote:
> On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
>=20
> > +config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
> > +	bool
> > +	depends on CLKSRC_ST_LPC
> > +	default y
> > +	help
> > +	  Use Low Power controller timer clock source as sched_clock
>=20
> This adds, as far as I can see, a Kconfig symbol that will always be =
in
> lockstep with CLKSRC_ST_LPC. Ie, CLKSRC_ST_LPC and
> CLKSRC_ST_LPC_TIMER_SCHED_CLOCK will always both be 'n' or both be 'y=
'.
>=20
> Are there plans to break that lockstep in the future?

What's stopping CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=3Dn?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
