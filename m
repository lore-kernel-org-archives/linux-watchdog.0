Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B247CA79;
	Wed, 14 Oct 2026 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969136; cv=none; b=NqnDzxQ79mFq3tJL/7oPpBW8LFwTeHWFK5e4a2vPakqBCJJBIdA8Y/tEOuvCncEH+wqyTaIQfi4dob7EDC1LZnMpdv3+mVaDAGrK+P3X7ZXC99VqG6YrZ2xoxZpnONEO4DeMLBhvMjCJ8yc6H1b59fwajzbS3glaNBgm4Se2MtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969136; c=relaxed/simple;
	bh=Y99uqPqfDhQ120rnGroawz9lqy6eeL55mgnbGQJ5KsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn+xfNbdWgeXRg4Ctx0APgaK8sqXmvSI/P5G1W5Xon1LAVjM8BxfBtChjGygt9RJnrRterFd93Mk4mTSkarbZf3JAOoyxHyxsVMF0DSFAw5r3K/bInHzf6a6MUBFdbeE0hKDwqfAHeRrFIwUPJ7zkJ5rr1d+ZD+Rwwn3pFHHx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH6m4y/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH6m4y/Q"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 74ECE1F00893;
	Wed, 14 Oct 2026 09:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791969134;
	bh=Y99uqPqfDhQ120rnGroawz9lqy6eeL55mgnbGQJ5KsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SH6m4y/Q26xnIfaLbL0LKLJ9GsyrvgptTxf9IYL4V98FafFL5Ymzx0S7S132c/sGx
	 7F2o0leazSbBgVqjBhcrbQZbCUtsFLB4Xv/uMjRWfyOybBZ2V14NISOTBkt0W3Cq7k
	 MV2lb+hpFGtOoy6rDtkPRn949Gi3loTPKY+lb7NfWM+ir50TnzSpOrhKs4caHsuv4R
	 ftnPxr/tp4gpoS/YPRT8ACZ+EuvAnJe1uTKj+FNzHPB7ZNoKPsWf8vzCMLmkTCkP9T
	 Zk5SHP1fb2w8Y5iX2Z3y+8bk7GiEFRAKxcLjus49xueXsFKpGrnZVTtJi1fmhA7bOW
	 aMdKlk4lvCXHw==
Date: Wed, 14 Oct 2026 11:12:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Sasha Finkelstein <k@chaosmail.tech>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 06/10] dt-bindings: pwm: apple,s5l-fpwm: Add t6041
 compatible
Message-ID: <as9HQml198veWxDy@monoceros>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-6-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mzqqhllyskho77o3"
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-6-961edd8d661b@cyberchaos.dev>


--mzqqhllyskho77o3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 06/10] dt-bindings: pwm: apple,s5l-fpwm: Add t6041
 compatible
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 08:56:13AM +0200, Yureka Lilian wrote:
> The PWM controller on Apple Silicon M4 Pro/Max SoCs is compatible with
> the t8103 (M1) one. Add "apple,t6041-fpwm"as per-SoC compatibles for M4
> Pro/Max.
>=20
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
Fine for me to go in via apple-soc

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--mzqqhllyskho77o3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrPR2gACgkQj4D7WH0S
/k5U+wgApfuQUcC81+F0xRcpsmtZvSbz5AVEGouH3+XNu/8L1latDub6jMQMtvpf
5e17zrSmAvr24cslWxo3aSYXrCZ3kqrNyTq/53kwfaU6pCWFsjBf1O/34BERZlEU
5WlDJIN8cx2+unVaKOYjECKUcaPrGJJAe3Xy9tR2+iBmIOqpurdQeMb49PqCGwRh
dPvcAPWyNne3XIu++Gz2xXdzg2vx0jRAbo3aZIjtOKfbC76DHvJWHMPTUReikd8x
7lLFFuU8p01k32f+S24v9ivYJe6n4MaLTeD/N2IYaLLMtL5P4yOTKvD+SqQ43gBr
S9TQlFnLEXFvb4g4OCuixPOzrCde+A==
=V9CH
-----END PGP SIGNATURE-----

--mzqqhllyskho77o3--
