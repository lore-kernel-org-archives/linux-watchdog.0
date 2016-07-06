Return-path: <s.christ@phytec.de>
Date: Wed, 6 Jul 2016 10:42:44 +0200
From: Stefan Christ <s.christ@phytec.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [RFC 1/6] watchdog: da9063_wdt: don't trigger watchdog too fast
Message-ID: <20160706084244.GA7031@lws-christ>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
 <1467724943-13416-2-git-send-email-s.christ@phytec.de>
 <577BD34F.7000804@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <577BD34F.7000804@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Tue, Jul 05, 2016 at 08:33:35AM -0700, Guenter Roeck wrote:
> On 07/05/2016 06:22 AM, Stefan Christ wrote:
> >Triggering the watchdog faster than T=5FWDMIN=3D256ms leads to resets of=
 the
> >da9063 chip. The datasheet says that the watchdog must only be triggered
> >in the timeframe T=5FWDMIN to T=5FWDMAX. The T=5FWDMAX is configured in =
the
> >driver.
> >
> >This problem was already mentioned in the patch:
> >
> >     http://comments.gmane.org/gmane.linux.watchdog/1708
> >
> >You also could say that this behavior is a feature. When the userspace
> >goes wild, triggering the watchdog to fast, the system is reseted. But
> >there is currently no information in the watchdog ABI to report a
> >minimum wait time between two watchdog heartbeats.
> >
>=20
> There isn't ? What is the problem with min=5Fhw=5Fheartbeat=5Fms which was
> introduced exactly for that purpose ?
>=20

Ah your right. Sorry, I didn't noticed it. I'm sending a v2 patch for it.
Thanks.

Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
	Stefan Christ

> Thanks,
> Guenter
>=20
