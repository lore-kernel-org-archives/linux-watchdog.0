Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33830 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbbKXRWU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 12:22:20 -0500
Received: by wmvv187 with SMTP id v187so220393437wmv.1
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2015 09:22:18 -0800 (PST)
Date: Tue, 24 Nov 2015 17:22:14 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, robh+dt@kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	Arnd Bergmann <arnd@arndb.de>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v4 2/5] mfd: syscon: add a DT property to set value width
Message-ID: <20151124172214.GJ12874@x1>
References: <1448291861-28543-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151124082036.GE807@x1>
 <20151124162439.GC4616@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20151124162439.GC4616@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 24 Nov 2015, Damien Riegel wrote:

> On Tue, Nov 24, 2015 at 08:20:36AM +0000, Lee Jones wrote:
> > On Mon, 23 Nov 2015, Damien Riegel wrote:
> >=20
> > > Currently syscon has a fixed configuration of 32 bits for registe=
r and
> > > values widths. In some cases, it would be desirable to be able to
> > > customize the value width.
> > >=20
> > > For example, certain boards (like the ones manufactured by Techno=
logic
> > > Systems) have a FPGA that is memory-mapped, but its registers are=
 only
> > > 16-bit wide.
> > >=20
> > > This patch adds an optional "bus-width" DT binding for syscon tha=
t
> > > allows to change the width for the data bus (i.e. val_bits). If t=
his
> > > property is provided, it will also adjust the register stride to
> > > bus-width / 8. If not provided, the default configuration is used=
=2E
> > >=20
> > > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/syscon.txt |  3 +++
> > >  drivers/mfd/syscon.c                             | 13 ++++++++++=
+++
> > >  2 files changed, 16 insertions(+)
> >=20
> > Works for me.
> >=20
> > For my own reference:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> This pachset requires a new version to fix something in the watchdog,
> I will add your Ack in the v5.
>=20
> >=20
> > How would you like this set to be handled?
> >=20
>=20
> Not sure what you mean. Actually, I don't know how it works for such
> patchset with changes across multiple subsystems. What are the option=
s?

I'm happy to handle it, I just need Acks from the other Maintainers.

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
