Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:9554 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752295AbdCDWgS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Mar 2017 17:36:18 -0500
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
CC: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v5 1/3] watchdog: add rza_wdt driver
Date: Sat, 4 Mar 2017 22:36:07 +0000
Message-ID: <SG2PR06MB1165967967FCFF06C1BF048F8A2A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170303173201.5597-1-chris.brandt@renesas.com>
 <20170303173201.5597-2-chris.brandt@renesas.com>
 <64cc8948-1940-f219-fb87-800b3d617030@roeck-us.net>
In-Reply-To: <64cc8948-1940-f219-fb87-800b3d617030@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Saturday, March 04, 2017, Guenter Roeck wrote:
> > +#include <linux/platform_device.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/delay.h>
> > +#include <linux/watchdog.h>
> > +#include <linux/clk.h>
> > +
>=20
> Also needs to include <linux/bitops.h>. While at it, please order include
> files alphabetically.

OK.

> > +	platform_set_drvdata(pdev, priv);
>=20
> This is now unnecessary.

OK.


Thank you,
Chris

