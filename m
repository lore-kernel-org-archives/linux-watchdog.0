Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38849 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbbKCIja (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 03:39:30 -0500
Received: by wmeg8 with SMTP id g8so8491385wme.1
        for <linux-watchdog@vger.kernel.org>; Tue, 03 Nov 2015 00:39:29 -0800 (PST)
Date: Tue, 3 Nov 2015 08:39:23 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com, arnd@arndb.de
Subject: Re: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
Message-ID: <20151103083923.GD3503@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446150450-22093-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151030175656.GF4058@x1>
 <20151030200812.GB8666@localhost>
 <20151102091253.GS4058@x1>
 <20151102181334.GA7200@localhost>
 <20151103083817.GC3503@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20151103083817.GC3503@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Nov 2015, Lee Jones wrote:

> On Mon, 02 Nov 2015, Damien Riegel wrote:
> > On Mon, Nov 02, 2015 at 09:12:53AM +0000, Lee Jones wrote:
> > > [Cc'ing Arnd]
> > >=20
> > > On Fri, 30 Oct 2015, Damien Riegel wrote:
> > > > On Fri, Oct 30, 2015 at 05:56:56PM +0000, Lee Jones wrote:
> > > > > On Thu, 29 Oct 2015, Damien Riegel wrote:
> > > > >=20
> > > > > > Driver for TS-4800 syscon. These registers belong to a FPGA t=
hat is
> > > > > > memory mapped and are used for counters, enable various IPs i=
n the FPGA,
> > > > > > control LEDs, control IOs, etc.
> > > > > >=20
> > > > > > Currently, only the watchdog is handled.
> > > > >=20
> > > > > Why do you require your own syscon driver?
> > > > >=20
> > > > > What's wrong with the generic one?
> > > > >=20
> > > >=20
> > > > The generic one uses a regmap_config with reg_stride set to 4 and=
 val_bits
> > > > to 32.
> > > >=20
> > > > TS-4800 syscon registers are 16-bit wide and must be accessed wit=
h 16
> > > > bit read and writes:
> > > > http://wiki.embeddedarm.com/wiki/TS-4800#Syscon
> > > >=20
> > > > I will address the other issues in the next version (split commit=
,
> > > > license issue, style, and superfluous remove).
> > >=20
> > > The Syscon driver was written to be generic so that each
> > > vendor/platform didn't require their own incarnation.  How unique i=
s
> > > the TS-4800?
> > >=20
> > > Perhaps it might be better to supply a generic 16 bit Syscon for
> > > devices akin to the TS-4800?
> >=20
> > The TS-4800 syscon could use a generic 16-bit syscon. There is nothin=
g
> > specific that requires a driver besides that.
> >=20
> > We could add some optional properties to the generic syscon node to
> > configure reg_bits, val_bits, and reg_stride (and pad_bits ?). Would
> > that be a good solution ?
>=20
> Without looking at the ramifications of such an addition, the premise
> sounds good to me.  So long as the current behaviour remains the
> default.

Perhaps a "syscon-16bit" compatible might be in order?

> > > Arnd, any opinion on this?
>=20

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
