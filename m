Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CA327BEC
	for <linux-watchdog@vger.kernel.org>; Fri, 15 May 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834853; cv=none; b=pvuYZvnTSHweSrHMBrkWKWyoNkrWNdUSTgKA4ExDUFyJfBeoMVisQ4CYw9kFxTpj7j4aSc3r5eN5ioTDDfFbwrafDTrFNBdZS8M6PXs58ChG10tXDC8iWgS0/AHEIKbrBsDnN6hB6wLxu4xEhF3F/MHsKo8sdNkqS2iNQZ4v5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834853; c=relaxed/simple;
	bh=tcsWhvBYfHAaZ0xx4d95uTJpmff+GK5/N7wi/KGLKks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tv89q/olEN0yyp/S0CUIWyWsv/GpaHQ5yYzFAWAZ0krTa8nYsWsXzvKyLT8qGErBSZ/lnu86XMCNt7v2Y4qKpinutOYB1HBNc1TGnV4wndRfz/xMD4jV723do7m4Qj58PGh6M3Dd+HKNIIYJCRZ7llRJPxTk7gCvzxoemtPJGlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=veuSbATF; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="veuSbATF"
Received: from [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d] (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 3F1287802DC;
	Fri, 15 May 2026 10:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778834849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcsWhvBYfHAaZ0xx4d95uTJpmff+GK5/N7wi/KGLKks=;
	b=veuSbATFW3Pg3jWRq0VNZehZ+fz6FeS5mEEHJAMmQIYJBcQjQgpmC//1UPVccdmHEgIw/C
	HummouTQSc7yqbuMfPoIuhnpQRBYYDO5QZEYOkcEbsp29uo2LpXYyF5EwuQPEF5NEiAZfP
	D3dHahdgrK7lBPpt51lUxmOqMV1LEu0tOWa1Kfv4bLvyO6YLk1OoaO3ZbTcLRuA0xOxXVV
	BEUnqGjV3Lre/lq7V5wiQMB6xx/o4i62+h+37P7JiBi8RDxSs8yHGZwP33/9WQb1hvm1/e
	C7mCuUVcS3Qmqh9M4JHQTg4DbHPAVVGt8lqJTa5QcxNL/uKTNueDszbsUI9sMQ==
Message-ID: <55abfd54cc6f01cee65d54ec74754549e30e4a94.camel@svanheule.net>
Subject: Re: [PATCH v2 0/2] watchdog: realtek-otto: add fallback compatible
From: Sander Vanheule <sander@svanheule.net>
To: Rob Herring <robh@kernel.org>, Rustam Adilov <adilov@disroot.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck	
 <linux@roeck-us.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 15 May 2026 10:47:28 +0200
In-Reply-To: <CAL_JsqLM4JQmbYCEz3-vpS+qiz8nXSk758CP_nFwWR2ihG-AFw@mail.gmail.com>
References: <20260512204854.8931-1-sander@svanheule.net>
	 <20260514161008.GB841147-robh@kernel.org>
	 <9f81a947b65cafd44b293e05080b1fd2820cea06.camel@svanheule.net>
	 <CAL_JsqLM4JQmbYCEz3-vpS+qiz8nXSk758CP_nFwWR2ihG-AFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rob,

On Thu, 2026-05-14 at 15:57 -0500, Rob Herring wrote:
> On Thu, May 14, 2026 at 11:25=E2=80=AFAM Sander Vanheule <sander@svanheul=
e.net> wrote:
> >=20
> > On Thu, 2026-05-14 at 11:10 -0500, Rob Herring wrote:
> > > On Tue, May 12, 2026 at 10:48:52PM +0200, Sander Vanheule wrote:
> > > > Like for the GPIO hardware of the Realtek Otto platform, add a fall=
back
> > > > compatible for the watchdog hardware.
> > > >=20
> > > > For backward compatibility, the binding will still allow current
> > > > single-compatible devicetrees to work, but new devicetrees, includi=
ng
> > > > new compatibles, should use a two-component compatible.
> > > >=20
> > > > This series serves to address comments regarding the device compati=
bles
> > > > for the patches adding RTL9607C watchdog support [1].
> > > >=20
> > > > [1]
> > > > https://lore.kernel.org/lkml/20260509163101.722793-1-adilov@disroot=
.org/
> > >=20
> > > You misunderstood the discussion (though some came after this). The
> > > fallback should be one of the existing compatibles (the oldest one), =
so
> > > there are no driver changes needed for the OS. Creating a new fallbac=
k
> > > completely misses that point.
> >=20
> > Using a SoC-specific compatible would mean we should go for something l=
ike:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "realtek,rtl9=
706c-wdt", "realtek,rtl8380-wdt";
> >=20
> > Then that means we can never change our interpretation of how the rtl83=
80
> > behaves (we don't have datasheets), because it would also impact the
> > behavior of
> > the rtl9706c.
>=20
> No, at that point you would add the rtl9706c compatible to the driver
> to distinguish.
>=20
> You have the same constraint with your generic compatible.
>=20
> > I also think "apple,wdt" is a bad example to compare with "realtek,otto=
-
> > wdt".
> > The former only specifies the vendor, while the latter refers to the li=
ne of
> > SoCs this IP block is used for. Although I see the docs also discourage
> > family
> > compatibles.
>=20
> Is M1, M2, M3 not a family? Maybe A series is included too, but if
> there's anyone that maintains some consistency across SoCs, it is
> Apple.
>=20
> The docs are based on experience and regret...
>=20
> >=20
> > If I may ask, what is the rationale for preferring the "older
> > implementation"
> > approach over a "family compatible" to match the common subset of suppo=
rted
> > features?
>=20
> If you create bindings as the SoCs are created, then you don't really
> know what's in a family, only does it work with the existing driver .
> You only know what's in a family after the fact. Things are never that
> clean either.
>=20
> I just picked the oldest as that's probably the most well known, least
> likely to need some future change, and would have the oldest OS
> version support.

Thanks for the extra context.

Rustam, will you take it from here to add the two-part compatible for the
RTL9706C? Since you won't need update the driver, I guess a single patch wo=
uld
do.


Best,
Sander
