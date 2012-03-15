Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:38150 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754114Ab2COV1J (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Mar 2012 17:27:09 -0400
Date: Thu, 15 Mar 2012 22:27:05 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>,
	Linus Walleij <linus.walleij@stericsson.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] watchdog/coh901327: convert to use watchdog core
Message-ID: <20120315212705.GH10698@spo001.leaseweb.com>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com> <20120307164240.GA1130@pengutronix.de> <CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Linus,

> On Wed, Mar 7, 2012 at 5:42 PM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
>=20
> >> =A0 =A0 =A0 case WDIOC_GETTIMELEFT:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(clk);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read repeatedly until the value is st=
able! */
> >
> > I was wondering if it pays to put this IOCTL to watchdog_dev and add =
another
> > callback to watchdog_ops? I'd think so. Wim, Linus, what do you think=
?
>=20
> OK with me, shall I hack a patch?

I think Viresh did something allready.

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
