Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08A3D3482
	for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091227; cv=none; b=b23GRFnzpHA+OZ7blnz1QGaFRePLty4htN44xI25oxtKfU3yyTUiDC0z0VOYpGKcfgwLi6vypHOT42VLa8/jbDR6YIibzE8lMpuVNNLoJkK10eSsDcON2mkhE86tXrkYEHW3rQPgCipeteNyOBNkqizN9qSYFdpHC12inhsw/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091227; c=relaxed/simple;
	bh=RNiwmJ1TK0PnXYEOtD4RKMW7QVbr2T6DLPPl1qaAN9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qESs+1EZnqkfTXDFc/ezVRXcufcwpXurJaMVm7hwKBwLSIA0gnl8WX5xuIF+NZktZEQbRd5izKAEsycZzfDhlZ/kkpqDFhL79vTCEYBMzuuupaiG7sPh9gZXmzIrPE99viD47fnzAbTyXFbVdN1sn5fxYu60rsF6+w+OuAbE54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4tMEBXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4tMEBXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFF4C2BCB7;
	Mon, 18 May 2026 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779091226;
	bh=RNiwmJ1TK0PnXYEOtD4RKMW7QVbr2T6DLPPl1qaAN9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4tMEBXQci/6LCM3wztN7MW5qz+UYt11CwK/RaVhJJyWHpN9B6WIghQkU79QtxbPS
	 NbL9knsbtCwrFNAo0II8IjEziG6vBjRFXXItFytd3iMT8kPSKdDOJHgcOZkQLb9XyN
	 Y99jst/GDNAIaT+nJU/K1J8O5ZFTxb/q/B45Sh8aEf7urtq/fxy5AR7icMq8F8dwvF
	 GIoda0w7u54oyc6CsZd9M+mle/7e4dfW7aeE6lnRv9zhpoVAnusznJdE0A2Uhk/L/b
	 0+pn8fwI6X+eLzyJBtcUCR8OiKChajp/5YPHnVd0u5+g7SDdxXqgPLX/egKMFAoejK
	 WgZ84HRJih5vA==
Date: Mon, 18 May 2026 09:00:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thierry Reding <treding@nvidia.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	"wim@iguana.be" <wim@iguana.be>
Subject: Re: Please update watchdog and watchdog-next branch references
Message-ID: <b229c4dc-7d23-471e-87e5-1bb822f97237@sirena.org.uk>
References: <d6b1c417-1e3b-4d5f-ad3a-6de1ec23a8f2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F8c+oxCvLgPPXQ+o"
Content-Disposition: inline
In-Reply-To: <d6b1c417-1e3b-4d5f-ad3a-6de1ec23a8f2@roeck-us.net>
X-Cookie: She sells cshs by the cshore.


--F8c+oxCvLgPPXQ+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 08:49:25AM -0700, Guenter Roeck wrote:

> watchdog (fixes):
> 	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> 		branch "watchdog"
>=20
> watchdog (commit window pull requests):
> 	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> 		branch "watchdog-next"

I have updated the watchdog tree and added the watchdog-fixes tree from
today, both with you replacing Wim as the contact.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--F8c+oxCvLgPPXQ+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoKxxYACgkQJNaLcl1U
h9DYtQf/WZM6MgqIiL9JTcqNL4wtNuelrWzTe8+8uj5kCrrcLW0gwYtSomE2mqYv
2W+f9udJgKiylU0y/F+UpVuF6S8r27yAShtx/lISmZG6Wk+963El5TV2iqFKCd6W
2Z/7qeM/rFptG2rFsajCBaRKi5Zi3OVbTkl5VvT0lXwZxG3z6ObPJ7bu4D2M7/xp
pwXs5mgrTQbQtopOeKFgTN4J5YDkVO3HawqQTEtuNxNhNbktaOmdXggB6LhStqtu
ZXen6WsXk+L3WCV0fbZm6jDzRUp+UlbcqOJXCPEhWW5HiXO1TcFyXNmj+B46o13K
gVQ25IYFe40oYZvKoWiwGT5nWTvLfA==
=u0k3
-----END PGP SIGNATURE-----

--F8c+oxCvLgPPXQ+o--
