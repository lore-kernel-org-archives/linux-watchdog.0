Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DD4195BB;
	Thu,  9 Jul 2026 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619380; cv=none; b=bE/BV43aNYXiw59twh30UTfnaAlfRjZvzLruNqmOSp2iVNLZKK/4rlJmP5brM5vXYtrr3hFF/xE+f4IGYkQr/TP0tODRTbFWOrnlbJ4AsucGo0AT3uNh7wFn5LUOlIN5enAdqDsN9eqPSGzkPrvDZ6Y7MwbHg3XiP9cJg7EJHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619380; c=relaxed/simple;
	bh=1SG94HhOt+5W3OfsJw7P4ktoxCg32fCEoowTbQTAaFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOLhCtmq7uNeq8+H7HsoYcDhDK05LrHkLPmZn698GI4f0k+yb69qjHpXhZcXm07Aj17DYyCKFP7e5lrBGgs2F54xtk+rwVTK9wXhWZxTVHOo9vwdELAyu5eGdhs8v/iEXpGPXZufVZ/GOOlXLDmeSBpXYR39C87tnI2oo0KyDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gsnej/es; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gsnej/es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2604F1F000E9;
	Thu,  9 Jul 2026 17:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619379;
	bh=1SG94HhOt+5W3OfsJw7P4ktoxCg32fCEoowTbQTAaFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gsnej/esWKXBhCklADIWGd/ro3xhJd8T/ytpzvimbeZ91iAxj4Co6Brmchb97qbtH
	 4l5eWPHYWQ0/c63OiQLiXmuiXiiBlX9a0pDxGzcYgO60Yl+d2KmwrXkJcCV0KTt4WN
	 zvGBv6VAUptmtepVltsOzbz99O/DzAa+3Iwac0pelGv5RNB+/SMveR0piIthD9DAUb
	 y8bcKsHomDI4QApGeiPbMBR8ibCaBVkaklDNzhDHLFAGDRvEWeCqTXRyUs+bAGYC/x
	 TBmxaQsDTOIipz4JdFHwl2NVMHfSud9iTXEUBY0BgYenjie46NRjeyuNywqxt/cUx+
	 iSHYLU7IYttRw==
Date: Thu, 9 Jul 2026 18:49:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: interrupt-controller: apple,aic2:
 Invert #interrupt-cells condition
Message-ID: <20260709-cork-pardon-83a2a1162ce0@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-2-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gvegRxeBV0F9Bdmx"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-2-55b305833123@jannau.net>

--gvegRxeBV0F9Bdmx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--gvegRxeBV0F9Bdmx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/fLQAKCRB4tDGHoIJi
0gwGAP9KpTcWT1GGf0kEJ7QAREbxKDU+G1C2xD9j0seF18pPQwEA+Y0o+hyF2XTN
VTxDdwXGMU1zXAn35aC3T59eUkFuqQE=
=iVsk
-----END PGP SIGNATURE-----

--gvegRxeBV0F9Bdmx--
