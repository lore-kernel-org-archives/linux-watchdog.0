Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0938AC90;
	Thu, 16 Jul 2026 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186781; cv=none; b=LjeoHkdBypDiYFyB45bB/mcS/qDHXLoRj+svtf+QHCqBcotxEWsjjrVACHItvnhqPTAB6hDUS6qyAcJHD17SuAPX24aY/HR/TTGTij7can2c61hut/ux2Ulpz06Q0/paGVH9xnCcMTDrPn60atawBAe2D2zwq0QyXsxSLNFgOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186781; c=relaxed/simple;
	bh=rSMky4NBMz4mCwwkSBWrp24PhKUMutXTZKuowSHmBVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzrNYngu/g3Nt2Ec7ODd2TIIwjeY/NQCWubc0xF1zXVKGpOY96RE9+fresdk7De+s2esS3S4k/47JOugpy/lNCaow3QebajfXluMHHYCAzYBGS/VKNlcAAFB1a43dWbyY8TCRr8Ns2Vk4k3+wAfpHXW32tZqYjN8tL1JtLewrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4K9jQ8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4K9jQ8d"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EC2B51F000E9;
	Thu, 16 Jul 2026 07:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186775;
	bh=rSMky4NBMz4mCwwkSBWrp24PhKUMutXTZKuowSHmBVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z4K9jQ8dZgB/nOZ3nEahhDL5jTD0H1CZ2VxGlWej1lstUdkYAtrl309g5ixYgiGm8
	 +CrFbz2hwP+ZrZ3RnZThMzte/JhYmoGkTbB//d3A9fpHeytmb9XpMrEd8RGfK0mkEf
	 XIW7/uNn2waLekYgKSPiE5bMsPIOI39zkBZJn5KLvUutShFiOTBdNhT1udXcpJyXBP
	 /KqXHWhwvCqrf1LKrEA+EA/yOwS7VPAlwgFsAq519GVXVpbqXquWAyXMLAfWWj/lKM
	 nmlCtBwa1aNafoC2TLEVCLPVUQg38RwYPN7H1f+z7SH7HR59v6HrDTgIE5ZLy1WDM7
	 R3efJpG4DCznw==
Date: Thu, 16 Jul 2026 09:26:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Andi Shyti <andi.shyti@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 08/10] dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and
 t6031 compatibles
Message-ID: <aliHVGRlJPHJCr0H@monoceros>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <20260715-apple-t603x-initial-devices-v2-8-df65b2485710@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lnle4boaomlspvdf"
Content-Disposition: inline
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-8-df65b2485710@jannau.net>


--lnle4boaomlspvdf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 08/10] dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and
 t6031 compatibles
MIME-Version: 1.0

Hello,

On Wed, Jul 15, 2026 at 11:11:55AM +0200, Janne Grunau wrote:
> The PWM controller on Apple silicon M3 Pro, Max and Ultra SoCs is
> compatible with the t8103 (M1) one. Add "apple,t6030-fpwm" for M3 Pro
> and "apple,t6031-fpwm" for M3 Max and Ultra as per-SoC compatibles.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

The cover letter states that merging through arm-soc is preferred,
that's fine for me. So take my

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

for this pwm patch.

Best regards
Uwe

--lnle4boaomlspvdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpYh5IACgkQj4D7WH0S
/k4tSwf+Kn4gjN7dijDNgaApRD1Ut9S5RvHfCZ1SrrfJb1+Oset4/sHjEFTtfzAE
+Ll6NBv7n3FBw268v/PeOo9+alPGYh5yXTLvJc4+Pz4w7xuBX+ijXwqQMWKPGMBn
ntKKIVPNadlNG5oxqVHP9Kt083VUiEo+Ckeo6vx8TI+Ryd/o0/AEAlAeuTa3D7Wi
seZhURBdkPzrS6MtqHSnJo9b79kqlB0BWt9Gtz13ZyLi3YqqhUsCsDpUwMdSO7SJ
MjOdZRzvgiDiszs2X7bTYqzlspZl6/WHv31lLW8flKyq1YeZRWm04eVVYSGMMiIS
GdPo3nkUTu+eZgfWTHzEl7df017HnQ==
=7vJI
-----END PGP SIGNATURE-----

--lnle4boaomlspvdf--
