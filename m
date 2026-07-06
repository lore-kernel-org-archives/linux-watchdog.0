Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BE435A9B;
	Mon,  6 Jul 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357038; cv=none; b=kgV0jM8GLz31JnKuRSFHY7jjLK3hHTcKOoX39trY5XgJEOHYZv99jxLNarsjz/NS+4/GvPGOoQuO3DdnjaLhxsXigQ74IFcLwpu91EBJT/BeFdBWq9HQV1t5VSfjB1T+7nAQt1rL4OAXv401I8VEzJyEJ4N90tGFP5apdDoPRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357038; c=relaxed/simple;
	bh=CV9D6fJM5vfq9UhvyjVV+ncTZTIz/gR5q15lfevzvkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ptp0x/XhJ+DivKBO8AAuBKelgxp0d+SJqw6wO1vK7sNl7nILIi8HHNBlwh/bpWNAz3fXDyrYz1fKF95WbnVXHFzY2Tz1S+qSLWRRrzlF391fo+SXbhrTOAJOy82MFCPftL0/wDQFsqb47SNIktWKfF7I09dH9rCz36ZD5LTxmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtQ6dmxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtQ6dmxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3AE1F00AC4;
	Mon,  6 Jul 2026 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357032;
	bh=CV9D6fJM5vfq9UhvyjVV+ncTZTIz/gR5q15lfevzvkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NtQ6dmxq8WhA0sy36y+sGDdk9I9AEeOuqedIPC/gWAu0i9lNTY46g5VDDP7gQpw1e
	 FmLSJSJcoYCWd/Fy0Lu3RAM5Rvw5Mfl7urBdBIzwgEP5rflOkIA8l1TMbGmuXYCM6i
	 ux8LZ5vQ0Itf2dT3kaS8726/BYkDd11DUEp7nEEDleZC3arz+hZtuVlaKLKKW1vvIx
	 +geNUP3mW6Mb8nBlx4ffSOsGftSphyj5WPO1OiQ3Ksa7w5RO63ft7tU6hC/0d4nbdL
	 miPrwYTp+d+ytcdo/+2YzXCMNcgIqj0ZzaK4Ah6mpfF+EBcPII2pcFH92xa/o9BAYL
	 X+Hq3h7R6+bAQ==
Date: Mon, 6 Jul 2026 17:57:06 +0100
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
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: npcm: add GCR syscon
 property
Message-ID: <20260706-conjure-reptilian-616a34467c90@spud>
References: <20260706144828.3517631-1-tmaimon77@gmail.com>
 <20260706144828.3517631-2-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6LAigrkJlf45dSi"
Content-Disposition: inline
In-Reply-To: <20260706144828.3517631-2-tmaimon77@gmail.com>

--m6LAigrkJlf45dSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--m6LAigrkJlf45dSi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakveYgAKCRB4tDGHoIJi
0nw2AQCCSIgI/DvjYrlSHivtEkbwp491JIgduD4sSQx+rkYfJAEA0JOpdp1n27CZ
DSb+D92qQ0NSkgIqyW8oQcGHySK4yQY=
=bWTG
-----END PGP SIGNATURE-----

--m6LAigrkJlf45dSi--
