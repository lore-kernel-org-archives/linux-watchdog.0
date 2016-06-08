Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56286 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbcFHHIN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 03:08:13 -0400
Date: Wed, 8 Jun 2016 09:08:04 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] watchdog: pretimeout: add panic pretimeout
 governor
Message-ID: <20160608070804.GD1521@katana>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-6-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <1465321127-19522-6-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +static void pretimeout_panic(struct watchdog_device *wdd)
> +{
> +	panic("panic on watchdog pretimeout event\n");
> +}

And here we have the same redundant message again ("panic on") :( Did
you look at my patches at all? To me, it looks like you didn't or you
are intentionally trying to leave my changes out. I don't think they
were all bad. In the previous patch in watchdog_notify_pretimeout() you
used the shortened message BTW.


--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXV8RUAAoJEBQN5MwUoCm21lcP/19xaLoyVM7qEOPoqo0ifDpq
jX4q4lR9AzDwRFb0oswqmulwjtnhDC08FCd2PQzSIMDVg9at0KTUf/dwVuwDd3Hd
sMydh1+9LVuLK/xMEXI4nZMwAxRq4RYWwIxi0IlmCcDcVwQHZDRvQclcGc3rAjf+
EQQCXX+KQN/bEZMCMc59zimCMHMKRs5WeMYnH8WI0hBvjIf+ymA6xYYuEv2EMx/j
nW6Pl0HP/IUyz8EF/1fcvBjAUv/n5x+E1ygMj2tWkTLD8NMTwTM8OQCORZY5hhQZ
Tnt/2I2IgYoFr0sM5b8f3w4owRcKEMHAoLvoi7UCbLRbNthePbmWN1Fy7z8W+sul
m2GD5KI50SyoWcUqAGxXlIxQTiE4RbzwkzYOdxpbhnqc5zi+D+x/MfT7tHBlHEhJ
vT1o8dqZHhziec/j3/FEch8OX9330NxBmiePsvTmTaWTEaCgLODUmDGhn22cF2dS
NoE/DGH2wvZ6BROhBj8G89hQb6PDjJ1b8CxXT4ivhw0J3NISjlGcfEXC0BJnrozt
nVJtXbUgGIVJ30OSHtErxdLSWdUeQ3dwnukYMwwiNN3Tcwl6/bBHs6aNsyIrpg8U
CeMjWBGQ+fvLnWQSpg5PzU1vutCzQ1/YlT98xMM4ny1noprKIaFh4KurTlKzX/KU
9ECVB17XR0/OsfVcsqPT
=ldbR
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
