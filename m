Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19786 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaBGBsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 20:48:10 -0500
From: Andrew Chew <AChew@nvidia.com>
To: Guenter Roeck <linux@roeck-us.net>,
	"wim@iguana.be" <wim@iguana.be>,
	"rob@landley.net" <rob@landley.net>,
	"swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"abrestic@chromium.org" <abrestic@chromium.org>,
	"dgreid@chromium.org" <dgreid@chromium.org>,
	"katierh@chromium.org" <katierh@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Date: Thu, 6 Feb 2014 17:48:08 -0800
Subject: RE: [PATCH v4 1/1] watchdog: Add tegra watchdog
Message-ID: <643E69AA4436674C8F39DCC2C05F76386319985EC6@HQMAIL03.nvidia.com>
References: <1391724356-17034-1-git-send-email-achew@nvidia.com>
 <52F438A9.9000908@roeck-us.net>
In-Reply-To: <52F438A9.9000908@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

> On 02/06/2014 02:05 PM, Andrew Chew wrote:
> > Add a driver for the hardware watchdogs in NVIDIA Tegra SoCs (Tegra30
> > and later).  This driver will configure one watchdog timer that will
> > reset the system in the case of a watchdog timeout.
> >
> > This driver binds to the nvidia,tegra30-timer device node and gets it=
s
> > register base from there.
> >
> > Signed-off-by: Andrew Chew <achew@nvidia.com>
> > ---
>=20
> Hi Andrew,
>=20
> > +
> > +	/* This is the timer base. */
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "incorrect resources\n");
> > +		return -ENODEV;
> > +	}
> > +
>=20
> I thought I mentioned that before - dem_iomap_resource() creates the ve=
ry
> same error message and returns an error if NULL is passed as res argume=
nt
> to it. So the above error message (and error check) is really redundant=
.

Sorry about that.  I guess I misunderstood.  I'll send a new one out shor=
tly.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
