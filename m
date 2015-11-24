Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35896 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbbKXRXe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 12:23:34 -0500
Received: by wmww144 with SMTP id w144so148292527wmw.1
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2015 09:23:33 -0800 (PST)
Date: Tue, 24 Nov 2015 17:23:29 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, robh+dt@kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	Arnd Bergmann <arnd@arndb.de>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v4 2/5] mfd: syscon: add a DT property to set value width
Message-ID: <20151124172329.GK12874@x1>
References: <1448291861-28543-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151124082036.GE807@x1>
 <20151124162439.GC4616@localhost>
 <20151124172214.GJ12874@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20151124172214.GJ12874@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 24 Nov 2015, Lee Jones wrote:

> On Tue, 24 Nov 2015, Damien Riegel wrote:
>=20
> > On Tue, Nov 24, 2015 at 08:20:36AM +0000, Lee Jones wrote:
> > > On Mon, 23 Nov 2015, Damien Riegel wrote:
> > >=20
> > > > Currently syscon has a fixed configuration of 32 bits for regis=
ter and
> > > > values widths. In some cases, it would be desirable to be able =
to
> > > > customize the value width.
> > > >=20
> > > > For example, certain boards (like the ones manufactured by Tech=
nologic
> > > > Systems) have a FPGA that is memory-mapped, but its registers a=
re only
> > > > 16-bit wide.
> > > >=20
> > > > This patch adds an optional "bus-width" DT binding for syscon t=
hat
> > > > allows to change the width for the data bus (i.e. val_bits). If=
 this
> > > > property is provided, it will also adjust the register stride t=
o
> > > > bus-width / 8. If not provided, the default configuration is us=
ed.
> > > >=20
> > > > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.co=
m>
> > > > ---
> > > >  Documentation/devicetree/bindings/mfd/syscon.txt |  3 +++
> > > >  drivers/mfd/syscon.c                             | 13 ++++++++=
+++++
> > > >  2 files changed, 16 insertions(+)
> > >=20
> > > Works for me.
> > >=20
> > > For my own reference:
> > >   Acked-by: Lee Jones <lee.jones@linaro.org>
> >=20
> > This pachset requires a new version to fix something in the watchdo=
g,
> > I will add your Ack in the v5.
> >=20
> > >=20
> > > How would you like this set to be handled?
> > >=20
> >=20
> > Not sure what you mean. Actually, I don't know how it works for suc=
h
> > patchset with changes across multiple subsystems. What are the opti=
ons?
>=20
> I'm happy to handle it, I just need Acks from the other Maintainers.

Actually, I just need Wim's Ack.

The 2 ARM patches will go in separately.

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
