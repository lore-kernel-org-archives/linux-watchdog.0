Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34632 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbbKRP2B (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Nov 2015 10:28:01 -0500
Received: by wmvv187 with SMTP id v187so283957621wmv.1
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2015 07:28:00 -0800 (PST)
Date: Wed, 18 Nov 2015 15:27:55 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v3 2/5] mfd: syscon: add a DT property to set value width
Message-ID: <20151118152755.GC3534@x1>
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447700814-5391-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151117091946.GG17829@x1>
 <20151117172649.GA11035@roeck-us.net>
 <20151118082144.GB3534@x1>
 <564C94FF.10004@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <564C94FF.10004@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 18 Nov 2015, Guenter Roeck wrote:

> On 11/18/2015 12:21 AM, Lee Jones wrote:
> [ ... ]
> >>>Or, for more clarity:
> >>>
> >>>   of_property_read_u32(np, "bus-width", &bus_width);
> >>>   if (bus_width)
> >>>
> >>>If you choose this version (which I think is my preferred method, =
don't
> >>>forget to initialise 'bus_width' to zero.
> >>>
> >>Ignoring an error and depending on bus_width=3D=3D0 to determine if=
 the property
> >>was provided seems odd, especially since it would "hide" if the bus=
-width
> >>property is set to 0. In the original code, this would be detected =
as error.
> >
> >I'm not sure what you mean.  If bus_width=3D=3D0, then a problem has
> >occurred and we will not use the value.  If bus_width!=3D0 then we c=
an
> >assume that it's been set and (as the comment describes) the value
> >will be checked for errors in regmap_init_mmio().
> >
>=20
> Your proposed code does not distinguish a missing property from "bus-=
width =3D <0>;".
> It will silently ignore this case.

Okay, so what you're saying is, you'd prefer to throw and error
instead of using the default.  Fair point.  If this is an issue then
feel free to use either of the other two suggestions.

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
