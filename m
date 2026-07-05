Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC323233938;
	Sun,  5 Jul 2026 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262202; cv=none; b=WI5L3zRXLw2e2u1S7QzTxcQKwjSHN6U/pxRgLo/VhWMFyzBm7T1kGnjkA9hGhPzWwnoIUbgkgaTXWushKVkjOWDz2qQsPy1Vr4ZYHlZ0P3oMO/pIMqqNlQ+osNEeuuqTwhsiuJGGRNf5HYN2ziN6sM0OEvBXtGWQms/8jLyHgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262202; c=relaxed/simple;
	bh=eJ6cc+1shGQjpddnIvz+Ep+PRkYa0ZhICnQlhVxew0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaAB5071gQnfqGMsBasBon9Pl+uak2bJfgJsPPxi5nYbdPsRk0B/yN6GPCyZnxr0Ijdrei3gopMQlMWdHrrLL3m3r+c5ekyKv0C1LagtD4TngiIwc2V0EenZhlrznpB8pE24FfIaRLsxfFibWySJ5phY0/2CR0fPY5kZTA2FgnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEr2sd3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEr2sd3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF6C1F00A3F;
	Sun,  5 Jul 2026 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783262201;
	bh=+IDjOgvMZgIQmetcLrnnpwM1F1TovTt/ay9+vlVBx9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nEr2sd3zLoF5/BTzOLBehR/gZ+XtkN9iD2D+uHFYFKG+UJ8K2j71ODrygr5sKy1lt
	 z6ypXkTjFi7ksiVdP8bZ+BVjdG6v4esdT+yxndNyuobZod8lFBSztQNdTY3UNrIU8Y
	 pV2yvpW5IqOTPNbBpROMAO1tbomLeCMkWZFzQHBsoHV9f2diuB9dQsTDe6sP44OIBw
	 yItLWDbAmkotsklsKX23AZU+vJi2NTkcLqLFC/NjlmMRXuyFLnvxXn4Rcfixk/ni7k
	 78jEKGPmD/E5Unr6XRU8NKGnuC1pqIbvSe5aEcAwIR76cm8/2r1NifxZTg4zTYDiA4
	 RqzPoE8N5RUtA==
Date: Sun, 5 Jul 2026 15:36:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: andrew@codeconstruct.com.au, wim@linux-watchdog.org, linux@roeck-us.net,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	openbmc@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, avifishman70@gmail.com,
	tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
	benjaminfair@google.com, corbet@lwn.net, skhan@linuxfoundation.org,
	joel@jms.id.au
Subject: Re: [PATCH v3 1/3] dt-bindings: watchdog: npcm: add GCR syscon
 property
Message-ID: <20260705-gruffly-curing-ae3ab1044a94@spud>
References: <20260705140100.1543486-1-tmaimon77@gmail.com>
 <20260705140100.1543486-2-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UuJ/2UbYFy531ONn"
Content-Disposition: inline
In-Reply-To: <20260705140100.1543486-2-tmaimon77@gmail.com>

--UuJ/2UbYFy531ONn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 05:00:58PM +0300, Tomer Maimon wrote:
> NPCM750 and NPCM845 latch watchdog reset indications in the SoC
> GCR block rather than in the watchdog block itself.
>=20
> Add the optional nuvoton,sysgcr phandle so watchdog nodes can
> reference the shared GCR reset-status registers that hold those
> latched watchdog reset indications.
>=20
> This is needed by the following reset-status support, which reads
> those latches and reports watchdog-caused resets through bootstatus.
>=20
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Since the 450 doesn't support this, please make it conditional.
pw-bot: changes-requested

Thanks,
Conor.

> ---
>  .../devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-w=
dt.yaml b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.ya=
ml
> index 7aa30f5b5c49..99c225f166db 100644
> --- a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
> @@ -40,6 +40,12 @@ properties:
>    clock-frequency:
>      description: Frequency in Hz of the clock that drives the NPCM timer.
> =20
> +  nuvoton,sysgcr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      a phandle to access the GCR reset-status registers that latch
> +      watchdog reset indications on NPCM750 and NPCM845.
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.34.1
>=20

--UuJ/2UbYFy531ONn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakpr8AAKCRB4tDGHoIJi
0jzXAP9V+LH1kp6iYX1iEVWw/AAWNuNW+o54gflPkE8U5Q8X3AD+I57wifDzW5ES
KiTAcjkS45d13+QxSzYtdn2yBkuizg0=
=coSg
-----END PGP SIGNATURE-----

--UuJ/2UbYFy531ONn--
