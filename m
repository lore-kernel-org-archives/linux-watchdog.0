Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48532 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbcGEO6w (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 10:58:52 -0400
Date: Tue, 5 Jul 2016 23:58:41 +0900
From: Wolfram Sang <wsa@the-dreams.de>
To: Stefan Christ <s.christ@phytec.de>
Cc: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 0/6] Implement I2C restart handler
Message-ID: <20160705145839.GA3641@tetsubishi>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> this is a request for feedback about a lockdep-warning-free I2C
> restart_handler.  I would like to know whether someone had the problem al=
ready
> and how the best and mainline friendliest solution looks like.
> I have an embedded board with the PMIC chip DA9063 that is also used as a
> voltage regulator for DVFS. For a clean reboot/reset of the system I have=
 to
> set the bit nSHUTDOWN in the PMIC via I2C. The restart_handler call chain
> is of type
>=20
>     static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
>=20
> So any code running as a restart_handler cannot (should not) wait, for ot=
her
> locks. When you use i2c_transfer/regmap you get lockdep warnings like [1].

Yes, this problem has come up occasionally. And it is not only about
sleeping. IRQs are disabled, too.

My idea was to introduce master_xfer_irqless or similar to struct
i2c_algorithm. I even discussed this shortly with Mark Brown how to
interact with regmap; but this was too long ago, so I forgot what we
agreed on :(

> Any comments?=20

I just skimmed very lightly over the patchset. Yet, seeing an I2C client
messing directly with 'struct adapter' breaks so many abstractions, it
hits my instant-NACK nerve ;)

Thanks,

   Wolfram


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXe8sfAAoJEBQN5MwUoCm2MjsQAKFZb+8MHf6pr9BOgVeozgDb
uLRVqoNJDWV9wVDPUShXkKbl0GJA+SORJb4iNWOQu+IV04T6ndtjbhxjfDnXDsSj
iG/3nEhotkhEJiwDnafWtko+fwLOoPLJfbqf61KususjDQumqNblmePPKfcVZCtl
SAzlUXaNweXguD4XECtPdUm/w7Vy4sk3gJI1YtWMQDCUHIZtwLNiYcXR7lcmlsqC
BoEDgCanYc3rfsQiBqQcAvjKfzUL3ppwcp13sSFB5N/QRdiq46lRB+KOC5HXeVHK
L4/HoOex/OrGbUiDK+XBLn4+93wl48y8Z8FSaA+nBgE/V+CUWDLc7Wp4MutloiAV
JWhs+Zis+KCTsZoUr9X7/4JBBCOaaSJByHKStaPpBiOJX0e/WirogoMTM/1VMCgj
M+DDu73zTHOfogOFVXIifPYGRRTMCQyFCSsqhPZZGrQGlBYFwB0W5Gef9tg37Wud
M2L0rAAaYYZVX3uvGyJ3rlxSg4U3bnzmTriRq9q9lORYJz8/LSw30d+LZN5+/dkP
pkHHk02Ol6kXuE1EogNgXiPTdM72ekfFD4uFG6wwrFdT0NvUWXr3JYRMTWPGGMiQ
EddNr64Yyl9clGVQCuga2fx+7tRk0bt6N8aQ56h8rD1IkvS1qelXTs+G145yn86o
4ujm5aJGFa01IL7JOQ7q
=5/2o
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
