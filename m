Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:11303 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725999AbeIGBXI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Sep 2018 21:23:08 -0400
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: RE: [PATCH v2 1/2] watchdog: rza_wdt: Support longer timeouts
Date: Thu, 6 Sep 2018 20:45:50 +0000
Message-ID: <TY1PR01MB15624B6461C2E00D08C54AFB8A010@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180906183738.81238-1-chris.brandt@renesas.com>
 <20180906183738.81238-2-chris.brandt@renesas.com>
 <20180906185247.GA25433@roeck-us.net>
In-Reply-To: <20180906185247.GA25433@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday, September 06, 2018, Guenter Roeck wrote:
> > +static void rza_wdt_calc_timeout(struct rza_wdt *priv, int timeout)
> > +{
> > +	int rate =3D clk_get_rate(priv->clk);
>=20
> clk_get_rate() returns unsigned long.

OK, I'll change it.

> > +	u16 counter;
> > +
> > +	if (priv->cks =3D=3D CKS_4BIT) {
> > +		counter =3D DIV_ROUND_UP((timeout * rate),  4194304) + 1;
>=20
> two spaces ?

Oh, did see that.

> Also, I am not sure how this prevents overflows. Was't the concern
> that timeout * rate might overflow an int ?

Actually, since 32 second is the max timeout for this WDT, I think at=20
first I'll check to see if "timeout" is greater than 32. If it is, there=20
is no reason to do any math. Then I won't have to worry about any=20
overflows from math.

	if (timeout > 32)=20
		counter =3D 256;
	else
		counter =3D DIV_ROUND_UP((timeout * rate), 4194304) + 1;


> Also, why still "+ 1" ? Wasn't DIV_ROUND_UP() supposed to take care
> of that ?

Ooops, I forgot to remove the "+ 1"

> > +		if (counter > 255)
> > +			counter =3D 0;
>=20
> This is difficult to understand.

As you suggested, I'll change this to:
	if (counter > 256)
		counter =3D 256;

Chris
