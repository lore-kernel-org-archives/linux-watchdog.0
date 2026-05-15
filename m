Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946453DF019
	for <linux-watchdog@vger.kernel.org>; Fri, 15 May 2026 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877757; cv=none; b=CZ2bGS3xxVXFVMSMAqbtNj424MgwByFleQAJ9FXok2KexppljrOiWWb2enfl5m+SuOzEJeja8k5/RukjuKatc9igRNxYDTr+fMSUpm2YOFSo6Rlsn0cP8I4gR82vCwyl4sxbCiupUxXMiw+ySGKpyyWTTaRpjaQkJLOuJwRdF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877757; c=relaxed/simple;
	bh=t0e2oz5XKBVDCNBbF6tuOEuISAOISJ0awDN5oiLl+V8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBBgurGtJHU9nLqIlIAy4GO12QCfBnN0Bfxh84eyvQCkjKzKW+mWoTm76CPaQFs1X2hfFhC0gTeVe97C/b7uaooHe6yK7IkLkOgZUfOJje05VQt4ha/YMsIhdSlSZyNV5az+g6c7RprpX+RA831Mm6whVuKtmKO5Ek71j+NhI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=izDSPEyi; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="izDSPEyi"
Received: from [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d] (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id B9993780757;
	Fri, 15 May 2026 22:42:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778877748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0e2oz5XKBVDCNBbF6tuOEuISAOISJ0awDN5oiLl+V8=;
	b=izDSPEyiqLU6dqS/KNNSMdoP9JhVXaJOCXJVf5ny4f7IqvUI1+unU8x9oB9EkxQJZSWqxQ
	KPfK8L86wLjFRcC8wjsDQCaWpBiesg9J43yu6etO20IBSt+w1Up/avXZ2d4MyeqAXWHRmY
	u+xVMxacBANzQ/vx/MLPCjlyCoNuWgulzrUErw4UqJIkDsTYxd45Mjj9PEjppL7yYb5kC+
	K3sDhfL1TTXXjo5hgPPo7p2Jy8U0BfuthDCy61PBUNuO28aLtlCKBP6Uu6pcTXXMhkufvH
	3RNpHV4/kuo8qKKWS5C+bjjvUAp+69EXr1kzQKl/KFqf95jPBy0jKUe1zaEyXQ==
Message-ID: <e73cb768716085a8bc461262ad8108e33ac97981.camel@svanheule.net>
Subject: Re: [PATCH v2 0/2] watchdog: realtek-otto: add fallback compatible
From: Sander Vanheule <sander@svanheule.net>
To: Rustam Adilov <adilov@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>,  Guenter Roeck <linux@roeck-us.net>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 15 May 2026 22:42:26 +0200
In-Reply-To: <d73e53888ab7d8541c5d84e733c04166@disroot.org>
References: <20260512204854.8931-1-sander@svanheule.net>
	 <20260514161008.GB841147-robh@kernel.org>
	 <9f81a947b65cafd44b293e05080b1fd2820cea06.camel@svanheule.net>
	 <CAL_JsqLM4JQmbYCEz3-vpS+qiz8nXSk758CP_nFwWR2ihG-AFw@mail.gmail.com>
	 <55abfd54cc6f01cee65d54ec74754549e30e4a94.camel@svanheule.net>
	 <d73e53888ab7d8541c5d84e733c04166@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-15 at 19:14 +0000, Rustam Adilov wrote:
> Hello Sander,
> On 2026-05-15 08:47, Sander Vanheule wrote:
> > Rustam, will you take it from here to add the two-part compatible for t=
he
> > RTL9706C? Since you won't need update the driver, I guess a single patc=
h
> > would
> > do.
>=20
> I can for sure, but would you mind clarifying what needs to be done?
> From my understanding two-part compatible for RTL9607C would look like
> compatible =3D "realtek,rtl9607-wdt", "realtek,rtl8380-wdt";

As I understand from the maintainers, this is indeed the desired approach.

> But it's only gonna be relevant to OpenWrt for now.
> Do i need to patch the realtek,otto-wdt.yaml file in the same way as
> your patch 1 here?

Yes, you'll need to make a distinction between the new two-part compatible,
while still allowing the old one-part compatible (which then should not be
deprecated). Another binding that implements this is fsl-imx7ulp-wdt.yaml, =
so
you can also use that style, if you prefer.

Best,
Sander
