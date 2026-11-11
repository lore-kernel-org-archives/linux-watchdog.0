Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419137;
	b=B69iVs+j7Vd0V3NL4Ecq3S9aUOJvoxSAbFXctjAZkHACYlcP6AA3byoK2MgNSFVAnFTl
	 s8rUlY0VNuVXf+AWKkATQgcppPvIzVUN1zvnQYUkYJ0SwRZ9rCeheex14VayLu/eRoZyH
	 ZNoYrxuX/RukyWQbBc/cRseTsCMxGelDLejErH84uU+ZLJQHG4OV9ClWeIs3WmojDDlHl
	 V/cH/dJges5MVjNfu3Gd/vse0XlXa9yk99MWExn1Ect/JTjXNG6fK7hicaWtEbFaPFZjH
	 VH0V8h7vLVvonhzo3wep6hcgKhiYm20bGgeEirfsTnmqirZz8vpfSX1OIOUOCxHR3fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419137;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B/pScjgsKJH25yAC/CvKFpxEUGkMIIumEMV+hgDlvx0=;
	b=KQ4fDadtMcg1olBN6PiNFyaUrNLO91bgQ0QAi6yg6LeFcbwA9H3LJoS32FcE4yxM37iG
	 dpiKsDdfBSIVO9D5KX9JOthNwrVihYgswWpgdJ9PsDWTmvqkHf4q5Q1gJvuXHc6FtYJD5
	 mY4ngeJrm9OD4S5mfzkpsSiRa42D23XObBbK5HpTRiLKN8fyrML2wrOzYiBxMw+BZe8Oz
	 L7lqKzD5Z5NTfS7+YBNQRFy17EHBt2vxcNZvinUnI0UFkIMASU2ZsHxe3ycvaVRUgIpui
	 TzikE7ej/VJObBSLAAQYtDDCvNXZOYEaCUoQTMw7iwyxzdJiJPdnUsFKVb4BwhfCAIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3KGpoqD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB340606A324;
	Wed, 11 Nov 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3KGpoqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B9D1F00A05;
	Wed, 11 Nov 2026 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419137;
	bh=B/pScjgsKJH25yAC/CvKFpxEUGkMIIumEMV+hgDlvx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T3KGpoqDUAcCphCyqBJzfpsSOVC1fLDegrpubeZT3ttpmXyHAYxiKJfdmY1R7CH9F
	 ATUT3wOLDYtXb+Hsf6Hu27jdOcH2JQXL6dLarexnBIGWCr5W82nL9B7bBKUEAxc3l4
	 yATvIuKCTph2pgq/EM6YFPAbd7czik0VMRsiY6qL5A3m9fnVArjDqRitSy+Zvky0hN
	 hnOsU9zHg3Y8/60UHxahhWgMZlWPasct+WnvXrmw/Wbm4cw3MfCbe6IhHRzMLWbMWW
	 zoyMlv/c4Sc0+/NNTpWvVcalygSwsjP7I7gm6nH4IGGjG7B/GuscHAC5QFfwqRoOmV
	 M6P2y9BTRo8Hg==
Date: Wed, 11 Nov 2026 17:45:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Rong Zhang <rongrong@oss.cipunited.com>
Cc: Rong Zhang <i@rong.moe>, Keguang Zhang <keguang.zhang@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Yao Zi <me@ziyao.cc>, Icenowy Zheng <uwu@icenowy.me>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: watchdog: loongson,ls1x-wdt: Add
 ls7a-wdt compatible
Message-ID: <20261111-oboe-shack-11c3e3ce0830@spud>
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
 <20261110-mips-ls7a-wdt-v1-1-968bb85122e6@oss.cipunited.com>
 <20261110-barterer-pandemic-e4c658cac7c4@spud>
 <227eb9a3dd5c1cb1af4cfbf2c94f30db1755a5d6.camel@oss.cipunited.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Knz0koHo1ilGW2U0"
Content-Disposition: inline
In-Reply-To: <227eb9a3dd5c1cb1af4cfbf2c94f30db1755a5d6.camel@oss.cipunited.com>

--Knz0koHo1ilGW2U0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:17:48AM +0800, Rong Zhang wrote:
> Hi Conor,
>=20
> Thanks for the review.
>=20
> On Tue, 2026-11-10 at 18:58 +0000, Conor Dooley wrote:
> > On Tue, Nov 10, 2026 at 03:02:30PM +0800, Rong Zhang wrote:
> > > The Loongson-7A has a watchdog, which is similar to Loongson 2K0300,
> > > except that it has no clock controller.
> >=20
> > I find this hard to believe, the device seems to be getting a clock from
> > somewhere that the clock-frequency property is providing the rate of.
>=20
> I must be losing my mind when I wrote this. My thought was "software
> cannot control the clock" but my finger typed "no clock controller".

No worries, I lose my mind more often than I would like ;)

> > Why is that clock not represented in devicetree?
>=20
> I will add a fixed-clock node in v2.

It's probably worth taking a look at what other devices share that same
clock. Probably all of the uarts use this clock too, given the identical
clock-frequency, and could be updated (in a separate patch) to use it?

Cheers,
Conor.

pw-bot: changes-requested

--Knz0koHo1ilGW2U0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavSpvAAKCRB4tDGHoIJi
0tQoAQDd+MZcG6No1sPlbJho+Rpv3fD0g+w0g04FCuDobooJzgD/cp3QD3w7Hlq4
tH6lib9u+Y1wjmpkEW9EkMnn2PMXjQQ=
=juLn
-----END PGP SIGNATURE-----

--Knz0koHo1ilGW2U0--
