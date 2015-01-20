Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33970 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbbATQpW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Jan 2015 11:45:22 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so35608514iec.9
        for <linux-watchdog@vger.kernel.org>; Tue, 20 Jan 2015 08:45:22 -0800 (PST)
Date: Tue, 20 Jan 2015 16:45:15 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 2/8] mfd: Add atmel-st driver
Message-ID: <20150120164515.GF30656@x1>
References: <1421077023-30954-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421077023-30954-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20150119094224.GJ21886@x1>
 <20150119225923.GG5014@piout.net>
 <20150120094739.GM5767@x1>
 <20150120150501.GH5014@piout.net>
 <54BE7916.4060204@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54BE7916.4060204@atmel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2015, Nicolas Ferre wrote:

> Le 20/01/2015 16:05, Alexandre Belloni a =C3=A9crit :
> > On 20/01/2015 at 09:47:39 +0000, Lee Jones wrote :
> >>>> This driver looks pretty pointless.  Why can't you request the sys=
conf
> >>>> registers from within the drivers themselves?
> >>>>
> >>>
> >>> How would you probe the watchdog driver then? Would you had the
> >>> "atmel,at91rm9200-st" compatible there?
> >>>
> >>> At some point in time, we should add the reset driver, would you al=
so
> >>> match it on "atmel,at91rm9200-st"?
> >>>
> >>> I'm fine with that as this allows to avoid the mfd driver.
> >>
> >> I'm sorry, I don't follow.  Why can't each driver have their own
> >> compatible strings?
> >>
> >=20
> > The same IP provides a clocksource, a watchdog and is also the reset
> > controller. I think that the DT guidelines requires that the DT
> > describes the hardware and so use one compatible for that IP;
>=20
> I would add also that the registers within the IP are kind of mixed,
> there is no way to separate by logical functions.

How is that different from any other syscon based device?

BTW, did you see "mfd: syscon: fix syscon probing from dt"

It may be the solution to your problem.

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
