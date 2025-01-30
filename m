Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCC1F12E8;
	Thu, 30 Jan 2025 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262899; cv=none; b=so6YDjwOW3Dm3VM0xuKBr6/p3X+RCFO48VMpQJc2Nkz45We1HUjWXPo02J1hRTS9d2RnF58XDBjQodRzXkALQ4yLXseA4bQcX2aFS6F/f5HBEcP3x1ZloySMbG5pI0ZO8s2cInD5dhRs85dc8uHMQsPDYQi4Uvniao4Rb+kxEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262899; c=relaxed/simple;
	bh=M4II0zr0MftMPwumgoOEcjOdPlhZ4Zq5Rr+hN0fU5sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ58wLCm0PmHBRECGjStYiu8E1fHv0KafY8EyOjoNpw3zNbgWqOAkm2Fh+0JogasRbtjxa3LivRhwKR4FMo5/43ZDD4NgJFrGtCvDR0OjyIBkzQNOGNfH20pIVOm1lP01H24QSEhtdl6wGZafR7REC8MWZQeQz8H07hLEbxJ8C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLnTb2fw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLnTb2fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D61C4CED2;
	Thu, 30 Jan 2025 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262899;
	bh=M4II0zr0MftMPwumgoOEcjOdPlhZ4Zq5Rr+hN0fU5sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLnTb2fwOQTIVS5IxR+sEBhmz7TaHuJWwJV3DD1fESoMqcR3RIptog8HS+ynmQ+WJ
	 rXzWjg4jQuYVNcgngIVMX6CKpnh/ga57arz67d99fkn3lIG2b2a/6hVdia0Pu2Ft8d
	 89SkABRSEdD6T1tbaGRDhJDdB4VVqbMdEMCwf+gs/SGkK0VEoJNIArHC0+W7lj1+MD
	 +HeKJnfD9Mgl7J7gl5CHkHgzHQBp/eL7FzDSdFDscTR8f19syv+PHthWqfKXkb42Qf
	 3vTe0URwSGGWlAuwD6XqwSLEeWHE7+1bXjNa2fC+sbUWASzH6yY861+rbQ4ah+tBI1
	 i1KBzF5awX8JQ==
Date: Thu, 30 Jan 2025 18:48:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Harini T <harini.t@amd.com>
Cc: linux@roeck-us.net, michal.simek@amd.com, srinivas.neeli@amd.com,
	shubhrajyoti.datta@amd.com, srinivas.goud@amd.com,
	wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, git@amd.com
Subject: Re: [PATCH V2] dt-bindings: watchdog: xlnx,versal-wwdt: Add optional
 power-domains property
Message-ID: <20250130-antidote-visible-f66f18b8dcb5@spud>
References: <20250130120233.742879-1-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H8KKBVW5x3KBHCFI"
Content-Disposition: inline
In-Reply-To: <20250130120233.742879-1-harini.t@amd.com>


--H8KKBVW5x3KBHCFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 05:32:33PM +0530, Harini T wrote:
> AMD/Xilinx Versal Window Watchdog Timer has its own power domain, so add
> an optional property to describe it.
>=20
> Signed-off-by: Harini T <harini.t@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--H8KKBVW5x3KBHCFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5vJbgAKCRB4tDGHoIJi
0sTBAQC8ZjArlWelKI1K/wdrhTo3M8DLRODr0SI8A2zDUdWoQgD+P0/oVBYho3oL
29bYov564YboB7+fP0DKP+2y/po+agw=
=GB3D
-----END PGP SIGNATURE-----

--H8KKBVW5x3KBHCFI--
