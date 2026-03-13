Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF83947A6
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421801; cv=none; b=dirzuswguhLfSGjsK6WOGTN11P6JWf2ITdUjRi6L2TgIvdd94pxQ7DwHXpn7fKtxdN8/InilovjTx7itAXtzCOD5VlyfzkrEzSnKyRq/lPiU9UmpGrSSyCAEAs0b+2bcf7Qv0ts4hODtTIKg2CUBVL7QAIyFUWq3sOiSKtBHU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421801; c=relaxed/simple;
	bh=zgKdsEGdjdvUuCuj3NXoEiAo/0AGLqUvRArM22toq5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUCzBCOmfosuywNDR9fp5r4CsCbN2s6InWwBe6YYhjsB9GwbQQWtGQHAIEouhR8nz+bEL+8vumbvs3WSvFHJVS8FsJuvVhR3ptFKRNOnm1i8VwnqfAOdMPOVQcf867kJJWmXyuVqaE/BeNEhxYxlBrV/KwP9Qo++PV8ggj7HZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Kfukbwqp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Kfukbwqp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=zgKd
	sEGdjdvUuCuj3NXoEiAo/0AGLqUvRArM22toq5c=; b=KfukbwqpzJhNoAxRs1CM
	usGPS8xUhNq/i0LNijPkJ5tsnRW7JS2r3Muh8oAaRnPmruMbo8YpjJFshAyVw2kx
	WDaWXlJOIfmzuxlVfkm8fSAvB1WhxWGkLbAo/1u6HL3ChLY8r05hn+pi7lI161Bc
	gWkApd5TCAHJvuNH5vqmcTne0hCuOzOP5aF4eLupZ4PHQhJT4n1chU9DO6e6cN47
	qBilPS2nJ6DrmfGnxuoVVz7FfgMe/3iX1Zl60ClRU1poS9oes8WWpZHJkUttgh0x
	m997CSXkdCfe+NKFUQMjh46Siln+qUPgab6Fr9zd8qbJpkw4SRpN5ucj0Oq/o6M9
	1A==
Received: (qmail 387518 invoked from network); 13 Mar 2026 18:09:46 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Mar 2026 18:09:46 +0100
X-UD-Smtp-Session: l3s3148p1@yLGd7+pMtJ0ujnuR
Date: Fri, 13 Mar 2026 18:09:46 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/3] watchdog: rzn1: Fix reverse xmas tree declaration
Message-ID: <abRE2v-raiGhGuQ2@ninjato>
References: <20260313092417.294356-1-herve.codina@bootlin.com>
 <20260313092417.294356-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uqZG+egNaPCPpGfS"
Content-Disposition: inline
In-Reply-To: <20260313092417.294356-2-herve.codina@bootlin.com>


--uqZG+egNaPCPpGfS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 10:24:14AM +0100, Herve Codina (Schneider Electric)=
 wrote:
> Variables declared in probe() don't follow the reverse xmas
> tree convention.
>=20
> Fix the declaration in order to follow the convention.
>=20
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>

Not a fan of such changes. But it works and I am not opposing it:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--uqZG+egNaPCPpGfS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmm0RNYACgkQFA3kzBSg
KbYikw//cv3cIz0tCzQsRnSS2RRZIjN+OyIBjFzKFjBdxShhG41SWNZ5/pwN/7Ah
u7VMLIP9b30N8Ec9yGOdyKReEGCe2rW4ESf6Mp7ePdIoi++RnBsNZ0EjXVy04wcG
vktacTR9K/N3NowEjlfnPdY6e1hap6gPDIhTTYWSWacmlsLcRe/LzpwFJV9RujYz
kPwv7XAZ9E+citlLfC+JndMqQ6JS6IpDnEU7bjrfsq58xkSHzLQc7PkEuWJuH847
Vg2NPYDwMnQOV3USX9aLyOX4yYhXHI0SynmuEKc8x4YCxh+z942ozaJfXmuqwVD4
X5Ib158VRwOjw6iZXuYQsi746OXfMiiTtm7qszC5NbQ41nBIkl59zWlkNlvIfPUk
jxyopg/rDEVvUPJWSQIN3DEaYeW6IO291x8IEaYjGO/CUMEkpfhGuGjTJeoY0wNL
eH2wFC+y9LdgQBa3e+Y3SXgmJJ3bnu6jdjySuRDfCNsFUuxzgSbMruM/wkT8c2ZT
plj/1rTGcyGRdxR9wx3B9BdxD0GOtQ9RNaKe7YH34nUKkoj54aSN1Gw5wBygvxIB
gtwbxXziF0+FIkPuWfQq9wzrphLyy0fUKO8xo5rR8R8ZAt/oQiFr3RV34tZbwXSS
OZIf11GV9SFhpHZELwOPc8ZL1lv4FOXztxoXlzHzpdEuaeNKFZ4=
=j4b3
-----END PGP SIGNATURE-----

--uqZG+egNaPCPpGfS--
