Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62C381E8C;
	Sun, 18 Oct 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350461; cv=none; b=Yd3f5aYk+dd7upXh+/FVBZ/sF7cL+sJdB/+QPn90eWylwsXu0qYiykHWn7tPtdS6p/y7cx3dIhkUOuaF4n/QkeIg8yVaCe7Dx/46vutTnKVJ2iqSjC545JP7ocVOQCcQJIwSrLYpvp7LruwCgcPsbMHRsW0H1PLZUg6NEoFryVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350461; c=relaxed/simple;
	bh=e+c+Qr6wRgnB+pbZI6vB3M8zw7iAvlqaVvfwzJMV1PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4zaYu4CDveiT9VTdGJVpWfZxDoNlWKGWhR/mHY8L/xU3qnb9PS6ydKomJUDqcKwyNIHWvgtzFfuQdYKp7duVWNVF6i1cBRl29tM0rLoPZNiGVaM0dk3xzuaCie+bHMSb/IaCRE3MregrCkT7DyEB8w41hb4JFZWJ/ZlGqhXqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjoM/Km4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjoM/Km4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB9F1F000C4;
	Sun, 18 Oct 2026 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792350459;
	bh=e+c+Qr6wRgnB+pbZI6vB3M8zw7iAvlqaVvfwzJMV1PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IjoM/Km4qurTHg6X3VUKkq0sVqcVlDd/aAkXlKRvsUdQSxo07GDTE/jL9XtQ+5Vid
	 HfdF3qSUWejo0STGYT3pHdq20iiPyTVB0L4Wg7F9EqgzbXbBIJgOaSfcUcZ9g/iOOc
	 ms72xOhnzqo0ci/6fD3/fqLImjzCurUSR1Xz7jh0uSITtC8S0md9N/WdcZ9Z/kpGoX
	 8oAKZp1KDUUCp//IwADPJ3RDmWv9PougqV6dzNWHf5jzfQtUBNR9erNgpVE+0m4IgO
	 550NJHRh4Q0cXQIShc82V+ehVMHwWH70Z7Wm2eAyI13peqm6X6VhaJnlFguRnv7G2O
	 +KdEBqNAEbDWA==
Date: Sun, 18 Oct 2026 20:07:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, manuel.lauss@gmail.com
Subject: Re: [PATCH 2/5] dt-bindings: watchdog: gpio: Describe minimum
 heartbeat intervals
Message-ID: <20261018-series-matron-f2991ecea141@spud>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <20261016221617.2223004-3-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g0N2ukCb0WMIz+mv"
Content-Disposition: inline
In-Reply-To: <20261016221617.2223004-3-f.fainelli@gmail.com>

--g0N2ukCb0WMIz+mv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--g0N2ukCb0WMIz+mv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatUY9QAKCRB4tDGHoIJi
0n24AP0VU7I1LO8QuVr77O0ieUH0HAgJ6vxjIha615mrn+PwbwEAzFTyZ76tRxvA
o4A1XfUZSzmtB+jF5vyliDCiDUfFXAw=
=o4BX
-----END PGP SIGNATURE-----

--g0N2ukCb0WMIz+mv--
