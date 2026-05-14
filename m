Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B93CB2C7
	for <linux-watchdog@vger.kernel.org>; Thu, 14 May 2026 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792264; cv=none; b=qOp1adx6UxXgkSbsJQpyKjNwMJf5hW/1rqV9Y2p38KL6czXPD34KRI5LBn3AzYUESqhtwikPc6JMvDdHHUui4giOuXrVg+ZaFKTaJVGI9el1bxsuFO+dpYjlDsjx5sX56UrHs1KziGUECGhTQIgAQoeaFFhM2SxCRBv98THm/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792264; c=relaxed/simple;
	bh=gQIErgakaBWc4eVx+wtAABqZtOgiDpGIK+PeBBCMD7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEKg3RnRtoMYIdPdIGTlqSISjQPJ5rpxf29TNQNhFumdQ5k862giOahPA92kEyMDoLWzE0RjUxDz9j4A39qnh3F+CcQz/7r9MJOMPLiYT4q5Kmw52UUgHwPnimH1tB5JEoQYH7mGmkfR6yS6cNE+jDMh7+ovXKc1AbXtrCPb1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sceNOdkA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sceNOdkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E336DC4AF09
	for <linux-watchdog@vger.kernel.org>; Thu, 14 May 2026 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792263;
	bh=gQIErgakaBWc4eVx+wtAABqZtOgiDpGIK+PeBBCMD7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sceNOdkAhUcnAfYQdvShfH7vQIXJW0beVULzf20rk0QviYtjJNUNu7a7sHTDkYP+B
	 xpn03N7fLxTy9AzmC8ormHyGSMOMGOJ22hflhEvZ32MNH9ckG5a80mEMv1N2It/Mvc
	 E+Uf+657Jtx/XJYo1sMobeObDrPoxSu2gwCBMJ04YU+Pw1/77HJqiNGXQedfcEXP6G
	 z7F2rs1m0aIKiHwhdLTCxveJe0AYHjq39zN2Mmzs2OBJBGcRdFa9PaLs6Vl1MyBAkJ
	 lgaGKPnNTvjyiwg4RI5YhkRnLyU0aVRKaRyAdnruXYtDopmDmW5vTcnw8lVd6uylvP
	 Ssov4F4z/oJjQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd21ffaca79so44475366b.0
        for <linux-watchdog@vger.kernel.org>; Thu, 14 May 2026 13:57:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+qeUMEDKZAsLli0X3HCHZHd9gTNoJeTBHkM42sCg2SzqOP2DCI7XsZ9jvRHWGyqQg+sRDOqeGtXxDuZ7eQIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb30/64HoFuIW40lLG5YrQHVGu4KBvqLsTk+HZ1HozQgi+os5E
	ROH5J1wSYS6v7XegSAZzpdxCxm0H840hQlws1lV8qSjYV70CpSxJUbm5Rfo/tzW9whbbKBc2LH2
	YIRXoaIN/XN9x69g4ve/reM+6nnLNOQ==
X-Received: by 2002:a17:907:c708:b0:bd4:aafb:def8 with SMTP id
 a640c23a62f3a-bd51553a0c9mr62509566b.21.1778792262550; Thu, 14 May 2026
 13:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512204854.8931-1-sander@svanheule.net> <20260514161008.GB841147-robh@kernel.org>
 <9f81a947b65cafd44b293e05080b1fd2820cea06.camel@svanheule.net>
In-Reply-To: <9f81a947b65cafd44b293e05080b1fd2820cea06.camel@svanheule.net>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 May 2026 15:57:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLM4JQmbYCEz3-vpS+qiz8nXSk758CP_nFwWR2ihG-AFw@mail.gmail.com>
X-Gm-Features: AVHnY4IiJt6YbJsjlhqBI3XPpUZMihiqOxN7QxDpJD3UYTXwNIgbFa92uKr18_M
Message-ID: <CAL_JsqLM4JQmbYCEz3-vpS+qiz8nXSk758CP_nFwWR2ihG-AFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] watchdog: realtek-otto: add fallback compatible
To: Sander Vanheule <sander@svanheule.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rustam Adilov <adilov@disroot.org>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:25=E2=80=AFAM Sander Vanheule <sander@svanheule.=
net> wrote:
>
> On Thu, 2026-05-14 at 11:10 -0500, Rob Herring wrote:
> > On Tue, May 12, 2026 at 10:48:52PM +0200, Sander Vanheule wrote:
> > > Like for the GPIO hardware of the Realtek Otto platform, add a fallba=
ck
> > > compatible for the watchdog hardware.
> > >
> > > For backward compatibility, the binding will still allow current
> > > single-compatible devicetrees to work, but new devicetrees, including
> > > new compatibles, should use a two-component compatible.
> > >
> > > This series serves to address comments regarding the device compatibl=
es
> > > for the patches adding RTL9607C watchdog support [1].
> > >
> > > [1] https://lore.kernel.org/lkml/20260509163101.722793-1-adilov@disro=
ot.org/
> >
> > You misunderstood the discussion (though some came after this). The
> > fallback should be one of the existing compatibles (the oldest one), so
> > there are no driver changes needed for the OS. Creating a new fallback
> > completely misses that point.
>
> Using a SoC-specific compatible would mean we should go for something lik=
e:
>         compatible =3D "realtek,rtl9706c-wdt", "realtek,rtl8380-wdt";
>
> Then that means we can never change our interpretation of how the rtl8380
> behaves (we don't have datasheets), because it would also impact the beha=
vior of
> the rtl9706c.

No, at that point you would add the rtl9706c compatible to the driver
to distinguish.

You have the same constraint with your generic compatible.

> I also think "apple,wdt" is a bad example to compare with "realtek,otto-w=
dt".
> The former only specifies the vendor, while the latter refers to the line=
 of
> SoCs this IP block is used for. Although I see the docs also discourage f=
amily
> compatibles.

Is M1, M2, M3 not a family? Maybe A series is included too, but if
there's anyone that maintains some consistency across SoCs, it is
Apple.

The docs are based on experience and regret...

>
> If I may ask, what is the rationale for preferring the "older implementat=
ion"
> approach over a "family compatible" to match the common subset of support=
ed
> features?

If you create bindings as the SoCs are created, then you don't really
know what's in a family, only does it work with the existing driver .
You only know what's in a family after the fact. Things are never that
clean either.

I just picked the oldest as that's probably the most well known, least
likely to need some future change, and would have the oldest OS
version support.

Rob
