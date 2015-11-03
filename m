Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38545 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbbKCKMW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 05:12:22 -0500
Received: by wmeg8 with SMTP id g8so10398569wme.1
        for <linux-watchdog@vger.kernel.org>; Tue, 03 Nov 2015 02:12:20 -0800 (PST)
Date: Tue, 3 Nov 2015 10:12:17 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
Message-ID: <20151103101217.GE3503@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151103083817.GC3503@x1>
 <20151103083923.GD3503@x1>
 <4911273.Q2mbQ2gvpn@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4911273.Q2mbQ2gvpn@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Nov 2015, Arnd Bergmann wrote:

> On Tuesday 03 November 2015 08:39:23 Lee Jones wrote:
> > On Tue, 03 Nov 2015, Lee Jones wrote:
> >=20
> > > On Mon, 02 Nov 2015, Damien Riegel wrote:
> > > > On Mon, Nov 02, 2015 at 09:12:53AM +0000, Lee Jones wrote:
> > > > > [Cc'ing Arnd]
> > > > >=20
> > > > > On Fri, 30 Oct 2015, Damien Riegel wrote:
> > > > > > On Fri, Oct 30, 2015 at 05:56:56PM +0000, Lee Jones wrote:
> > > > > > > On Thu, 29 Oct 2015, Damien Riegel wrote:
> > > > > > >=20
> > > > > > > > Driver for TS-4800 syscon. These registers belong to a FP=
GA that is
> > > > > > > > memory mapped and are used for counters, enable various I=
Ps in the FPGA,
> > > > > > > > control LEDs, control IOs, etc.
> > > > > > > >=20
> > > > > > > > Currently, only the watchdog is handled.
> > > > > > >=20
> > > > > > > Why do you require your own syscon driver?
> > > > > > >=20
> > > > > > > What's wrong with the generic one?
> > > > > > >=20
> > > > > >=20
> > > > > > The generic one uses a regmap_config with reg_stride set to 4=
 and val_bits
> > > > > > to 32.
> > > > > >=20
> > > > > > TS-4800 syscon registers are 16-bit wide and must be accessed=
 with 16
> > > > > > bit read and writes:
> > > > > > http://wiki.embeddedarm.com/wiki/TS-4800#Syscon
> > > > > >=20
> > > > > > I will address the other issues in the next version (split co=
mmit,
> > > > > > license issue, style, and superfluous remove).
> > > > >=20
> > > > > The Syscon driver was written to be generic so that each
> > > > > vendor/platform didn't require their own incarnation.  How uniq=
ue is
> > > > > the TS-4800?
> > > > >=20
> > > > > Perhaps it might be better to supply a generic 16 bit Syscon fo=
r
> > > > > devices akin to the TS-4800?
> > > >=20
> > > > The TS-4800 syscon could use a generic 16-bit syscon. There is no=
thing
> > > > specific that requires a driver besides that.
> > > >=20
> > > > We could add some optional properties to the generic syscon node =
to
> > > > configure reg_bits, val_bits, and reg_stride (and pad_bits ?). Wo=
uld
> > > > that be a good solution ?
> > >=20
> > > Without looking at the ramifications of such an addition, the premi=
se
> > > sounds good to me.  So long as the current behaviour remains the
> > > default.
> >=20
> > Perhaps a "syscon-16bit" compatible might be in order?
> >=20
> >=20
>=20
> I think a 'buswidth=3D<16>;' property in addition to 'compatible=3D"sys=
con"'
> is more in line with what other subsystems do.

Perfect.  Are you happy coding this up Damien?

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
