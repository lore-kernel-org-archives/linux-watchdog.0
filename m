Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38209 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbbEHHZc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 May 2015 03:25:32 -0400
Received: by wiun10 with SMTP id n10so17377339wiu.1
        for <linux-watchdog@vger.kernel.org>; Fri, 08 May 2015 00:25:31 -0700 (PDT)
Date: Fri, 8 May 2015 08:25:27 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH 06/12] watchdog: bindings: Supply
 knowledge of a third supported device - clocksource
Message-ID: <20150508072527.GI16220@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-7-git-send-email-lee.jones@linaro.org>
 <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150507191909.GC16220@x1>
 <20150507195529.GA28554@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150508064918.GF16220@x1>
 <20150508071604.GA2232@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20150508071604.GA2232@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 08 May 2015, Peter Griffin wrote:
> On Fri, 08 May 2015, Lee Jones wrote:
> > > > > > =20
> > > > > > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih4=
16-lpc"
> > > > > > -				  "st,stih415-lpc" "st,stid127-lpc"
> > > > > > +- compatible 	: Must be one of: "st,stih407-lpc"
> > > > >=20
> > > > > The same comment as the RTC DT patch, you are removing the co=
mpatibles
> > > > > documentation for the other supported platforms like stih416-=
lpc.
> > > > > AFAIK they are required in the driver to get the correct sysc=
onfig register.
> > > >=20
> > > > That's intentional.  I haven't yet tested any of this IP on
> > > > STiH41{5,6} & STiH127.  Due to lack of documentation, I'm not e=
ven
> > > > sure if this IP even exists on some of the other platforms.  I =
will
> > > > add them back when support is added to both driver and DTB and =
I've
> > > > been able to test them.
> > >=20
> > > That was kind of my point, the driver code AFAIK already contains=
 support
> > > for these SoC's.
> > >=20
> > > I would either expect the patch to remove support from the DT doc=
s AND the
> > > driver, or leave it as is.
> > >=20
> > > It seems odd to only change the DT docs, and become unaligned to =
the
> > > code (this assumes I'm looking at the latest patchset here=20
> > > https://lkml.org/lkml/2015/3/4/1088 which includes support for th=
ese SoCs).
> >=20
> > The decision to remove these 'supported' platforms was made on the =
RTC
> > side, where there is only support for "st,stih407-lpc" in the drive=
r.
>=20
> The change makes sense in the RTC case then.
>=20
> > I thought it best to mirror that thought over to the Watchdog LPC
> > bindings,
>=20
> Why? This is the bit I disagree with, the wdt DT docs IMHO should mat=
ch the wdt
> driver code.

=46air enough.  I'll add the 'supported' compatibles back in.

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
