Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53587 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeCDTTh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 4 Mar 2018 14:19:37 -0500
Date: Sun, 4 Mar 2018 20:19:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: =?utf-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=
        <torso.nafi@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: A case of watchdog+LED shared GPIO pin
Message-ID: <20180304191934.GA14207@amd>
References: <CAEo2pztutpwd0wvJWVmQ2XaT43nQ99StFbDMT7MQ5dkrMdkJvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <CAEo2pztutpwd0wvJWVmQ2XaT43nQ99StFbDMT7MQ5dkrMdkJvw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We (the development team at my current employer company) are having a
> specific case of hardware configuraton. Namely, the same GPIO pin is
> used for both watchdog keepalive signaling and status LED blinking.
> The thing is, there are multiple blinking frequency modes for this
> LED, each with its own meaning (i.e. system/firmware states), so
> there's a need for changing the frequency/period dynamically from
> userspace.
>=20
> Previously I've done the thing implementing the timer period
> configuration by updating a special sysfs file with new values in the
> gpio_wdt driver. However since recently (commit 03bca15 in the kernel
> Git repo) the timer has been swapped out with the keepalive callback
> thing, which, as far as I can tell, supports updating the timeout
> period via the WDIOC_SETTIMEOUT ioctl. However this ioctl is
> insufficient for our purposes, in the sense that its minimum
> resolution is 1 whole second, while we need a 100 millisecond
> granularity at the very most.
>=20
> I could also simply disable the gpio_wdt altogether and just use a LED
> trigger driven configuration, but I highly doubt this would be a wise
> thing, since the whole point of the watchdog is monitoring
> responsiveness of the userspace. Also I gather that controlling the
> GPIO entirely from a userspace process is rather undesirable, too, as
> it might lead to confusing latencies sometimes, for a start.
>=20
> I'd like to hear your opinions on the preferred way(s) of implementing
> this for our product hardware on the most recent kernels, which could
> be sent to upstream to secure further backwards compatibility.

Improving WDIOC_SETTIMEOUT is obvious solution. I'd go for that.

But actually, controlling GPIO entirely from userspace should work
well, too. User is not going to notice the jitter in miliseconds...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqcRsYACgkQMOfwapXb+vLP7ACcDr3vRl6yNhhxNLvlFz0UKQkF
P/AAmwbw8g9sYjK8mVKLqXBMrZqUSJTV
=g6w/
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
