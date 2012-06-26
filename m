Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:42762 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751028Ab2FZTIe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jun 2012 15:08:34 -0400
Date: Tue, 26 Jun 2012 21:08:31 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: viresh kumar <viresh.linux@gmail.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
	"w.sang@pengutronix.de" <w.sang@pengutronix.de>,
	"sshtylyov@mvista.com" <sshtylyov@mvista.com>
Subject: Re: [PATCH V2 00/22] watchdog: ARM watchdogs: sp805 & mpcore updates & fixes
Message-ID: <20120626190831.GH735@spo001.leaseweb.com>
References: <cover.1331524811.git.viresh.kumar@st.com> <4F83FEE0.8020709@st.com> <4F8E4C4C.5030702@st.com> <CAOh2x=kFZ8KemoqyczBqObwk=+qx0XL_FMQ-qwJvWK++631K_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAOh2x=kFZ8KemoqyczBqObwk=+qx0XL_FMQ-qwJvWK++631K_g@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

> On Wed, Apr 18, 2012 at 6:08 AM, Viresh Kumar <viresh.kumar@st.com> wro=
te:
> > On 4/10/2012 3:05 PM, Viresh KUMAR wrote:
> >> On 3/12/2012 9:51 AM, Viresh KUMAR wrote:
> >>> Hello,
> >>>
> >>> This patchset contains fixes and updates for ARM watchdog drivers s=
p805 and
> >>> mpcore.
> >>>
> >>> Changes since V1:
> >>> - Included patches for sp805 driver.
> >>> - Removed: wdt->clk =3D NULL from mpcore driver, and use IS_ERR() t=
o check if
> >>> =A0 clock is supported or not.
> >>> - Adapted to watchdog core for both the drivers.
> >>> - two patches for watchdog core added
> >>> - add patch to use __raw_readl{writel} instead of readl{writel}
> >>> - taken care of few more review comments.
> >>>
> >>
> >> Hi Wim,
> >>
> >> Have you applied patches left in this patchset for linux-next?
> >
> > Ping!!
>=20
> You planned to push them in v-3.5. Isn't it?

The sp805_wdt patches are in and are for v3.5. The sp805_wdt driver
however allocates its watchdog device dynamically, so you will need
to add ref and unref functions. (See also commits:
e907df32725204d6d2cb79b872529911c8eadcdf ,
54e2dc9341aca23d5241699e3b74c8dce609fa2d ,
664a0d7862a6b10c709d4b4a3655fe2c59a20064 ).

The mpcore ones are not in. Here I need to reread the discussion
on the interrupt handling and/or the SMP issues. This will be for v3.6
at the earliest. I will add the mpcore patches to linux-next next week.

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
