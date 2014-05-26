Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56463 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751359AbaEZSup (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 14:50:45 -0400
Date: Mon, 26 May 2014 20:50:41 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
	Guenter Roeck <linux@roeck-us.net>, carlo.caione@gmail.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunxi: Fix compilation with C=2
Message-ID: <20140526185041.GA21283@spo001.leaseweb.com>
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar> <533EF39D.6090907@roeck-us.net> <536FD3B3.3030100@elopez.com.ar> <20140515085214.GP29258@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140515085214.GP29258@lukather>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Maxime,

> On Sun, May 11, 2014 at 04:46:59PM -0300, Emilio L=F3pez wrote:
> > El 04/04/14 15:02, Guenter Roeck escribi=F3:
> > >On 04/04/2014 10:24 AM, Emilio L=F3pez wrote:
> > >>When compiling sunxi_defconfig while using C=3D2, the following e=
rror
> > >>causes the compilation to fail:
> > >>
> > >>     drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 i=
s not
> > >>a valid number
> > >>
> > >>Fix it by using hex notation instead of the non-standard binary o=
ne
> > >>
> > >>Signed-off-by: Emilio L=F3pez <emilio@elopez.com.ar>
> > >
> > >Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > >
> >=20
> > Wim, Maxime, any comments on this?
>=20
> I'm fine with this. Wim? Do you want to take this patch, or can we
> have an Acked-by?

I'm taking the patch.

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
