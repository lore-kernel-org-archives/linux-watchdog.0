Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473602E228D
	for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047872; cv=pass; b=SLK977+XR5p7SHQiRpj2j8D77H5N9pnsaak54FzYJ2JINNpmJKq9teDgVhBO6mH75AjUebVaNBJXxSe7VXb1d31H4jHL/gL22d9Kgj2myIUSg5RiWiWteM/TRprGSFFaI0eEo42AcUlF+omUoYLHVegRENhu9LJR6EtVmDiDPW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047872; c=relaxed/simple;
	bh=UKuXmnxAZy4X4Zfjms3mGb3B8NsNDeeH3MZJWfiGhEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XodvooVKeTyxHG/054xKPcsw4titgtVHBJg3Z9alnU1G8lWV/xr+JuDBDi/jly0h7lAzFnPCU469sG8Iiw/oLjjFHo0Zh2+w7I37E1ZTPQ4n8vOVDBdKkG0reCWDz+geBTfo+eo2MDvSh4KTCqmFh+u4EYZeaoJ30zo0TtXgfV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUB+07b9; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUB+07b9"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f365afc5aso1534042f8f.0
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 09:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784047869; cv=none;
        d=google.com; s=arc-20260327;
        b=siQNt5YTldojqrUUQv/aiFAFbZGw+BAtHRfl4fLXVGFx79HOOag/UdbGk47cgRgkJD
         wIkGtyIFRdptMfQKztDrEkCeG2F4dGH30l0+DWF2IOk8s88lmebmIjj4A0cqCPSHBfGV
         Fq1QGCyWR8r7hYZGunecjlMFjFNS8LPsAJpzhcwdPm1Y75PgaZluA4GOf6kni1BOB/3T
         VbO+e80yc+fNOFjX59UWl/Fh9S5gwfjIdPhd5AXnGWhpvQOTozxdvRKsFdKqMGoMKgBd
         Fp55naKlifKIUCZKfEuxXVomSGzUZwy+yuFCyr+5NZDyFr1kUVUehpv4P2xNGj6ODNTH
         eGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8BlgmiFQrHiuTd+MM0CeF9cu80lrra6/Pp38WzQSYbE=;
        fh=Yus6QALEJiGDYhogUrrKgLpM9sTnVIn2IUIEq0lfeYo=;
        b=Ou7VgXrT54IvzzE2xWGmn7BYCzS7b1HWUu30Vud/wdG06JI74HsouUyR6loPQ0yu7S
         aS5VL+IEIXJi8NuXg02dxvDjLdi+hBDSepAJ19fAy4fxyNr/Mzt2q4YpslIPj1llcHaA
         6mTIZJF0P7rAdjYJj5cwbHHUote+DSApBNPcVc8gYevVf5MZprxaUWvmmTTWML2jqiZT
         H12bU/zjwpyZ3UYqT9LvvTvLXOGtJ09G+H2Z9AYtqF7oWF95gSMxzdS+ecZbzCXWk83+
         0Z4B8EM0gr1kwJczv9/lcoBpJSkoHl6PCCC5E0o9tpcrGMS+Ty859TaV06f2qcYiOF+c
         Y25w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784047869; x=1784652669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8BlgmiFQrHiuTd+MM0CeF9cu80lrra6/Pp38WzQSYbE=;
        b=sUB+07b97KGV3ebDMkf0d3LU/JbugGI5wAiuag6v2+UK398tluefGUR03Qt2NGVOt3
         poU3WOZaYSn4pp7yER5a/Tzddw/uxLuMGI+r8BlwLUNOMQpmkEYJ5fOQNP7Rp0zMyeDI
         g4deAY34diw6dPfpcjDMqPsuLXhuI+1fX4H8oicc3qt5mN0Dw6/KHBTch5etD6Dr3LpF
         Vo2XBs61rXFmCWC82PizuiU7IC0sO4juLej9ZePmzKnC3CXA/egtX60IONCorzuqrqx9
         t+T+fSoyeH3ErkF+ezlR0c7Tqpx+FocK+eTnhmz0ZTOTUYKAOcZUUqLhbFWff6hiTyhq
         fFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047869; x=1784652669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BlgmiFQrHiuTd+MM0CeF9cu80lrra6/Pp38WzQSYbE=;
        b=R0KgVAIQk5+EbzgpUmgnk7u09xir95uhPvNXS2opHu2ghjDDjtqy0raiYSeA6fh3zi
         6Y+866Yh7Ob3rVFhWTH+o8ZwxZzoXQKCqqA+RVkFCxNd+UNaOT5wKdgGrRsPfN6z5Dlo
         cmlgnch3vvtsVaWp9OVBbGCni8QQqzw6kvaDPCGSXXNsPsAfEznlrMnXZ1vNYzLzTbmR
         XmMW53pmhIjnCT7rm+wXzfGT6awUjj0dAJRykRtB5Z1G9hDK6hABDhmXlfNSZEpqUpP8
         c+TAyYuJOySrB1PpBaRr5x1bLAsdmt6kppXlREbCcd/crAoL55LaB2yK7EMdsTAWRNkP
         j4xg==
X-Forwarded-Encrypted: i=1; AHgh+RppKFgCOaxNqxr7/nZy57Ot1M6HJrEmX+HmlsZltQd7yo+yPKJCUWEMaGuyn8HOGDTwbRZchpohCfv/71zomg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdtgqdG2I9wLaK/0CBjyDYlh74bIll7/b0WcBoETLimeonIZOt
	CjJMw4yx8AUbKh65FYCdBTbXEpBbiDSj/jszaORySFP95C/sQZ9P1pUOWyDX03IVRX88Gh/lY5a
	+yDP79wfZQh/QGMF/AZNd2hSV7otXn58=
X-Gm-Gg: AfdE7clMW1GPwd803lAlQi5BJRR80exFXl/i9XbZuRZ3/K5+N+TQOI+xSyXED3LBxBV
	AN5z72ynbSZ44gjCMqLy555711QifQSWyQaEkqOp2QErYQyOj9zMSABxL5mqEG7ygRkg2iVkkeJ
	t9U2ySz4h2LsdDWE+tCyV4d7iBLymYvjkaTqx/YezhzAPKr4y0ykDbIvKU5AVbqFehnvpKQ9wkv
	Ym4iD9tRf1z2AGHVf1hx73CzdOOazSDmTgRS3bGebv2XsT0t3VlNbbL8ypUM2YQ/mARuNnNeARQ
	aR15MeJC9hOmniO3i4OR5JVoKJeFwJyyTylaJrgPStgsd2ZKfvG7KP+YpDd9CbB9Nb0qKg==
X-Received: by 2002:a05:6000:46c2:b0:47f:4c49:4318 with SMTP id
 ffacd0b85a97d-47f4c4944a5mr1473055f8f.49.1784047869366; Tue, 14 Jul 2026
 09:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUhiBAcJ6P7j0ZxL+0AbVqz88PMo7YX9UiYOK8jM61D1Q@mail.gmail.com> <CA+V-a8uUxfDx2Xnb3uFg2=R+eYnzVmAv4PoEYeXGwAbANxG5Bg@mail.gmail.com>
In-Reply-To: <CA+V-a8uUxfDx2Xnb3uFg2=R+eYnzVmAv4PoEYeXGwAbANxG5Bg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 14 Jul 2026 17:50:42 +0100
X-Gm-Features: AUfX_mwxd6v5gFWCuMlhAPL7PON29wGJJEnO7K61SQDYcZ5CBYFFPz5abzgomRI
Message-ID: <CA+V-a8utJuuwVNy8o2zM5jHf9qXx36S79uKGtYr5O=sASh_wpg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/9] Add System Controller support for RZ/T2H and
 RZ/N2H SoCs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Jul 14, 2026 at 2:27=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Geert,
>
> Thank you for the review.
>
> On Mon, Jul 13, 2026 at 5:00=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> >
> > Hi Prabhakar,
> >
> > On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> wro=
te:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > This series adds support for the System Controller (SYSC) blocks foun=
d on
> > > the Renesas RZ/T2H and RZ/N2H SoCs. These blocks handle critical low-=
power
> > > management and access control functions.
> > >
> > > Hardware Architecture & Dependency Challenges:
> > > ----------------------------------------------
> > > The SYSC in these SoCs is a multi-functional block responsible for:
> > >     - Clock & Reset Control
> > >     - Low Power Management
> > >     - Clock Monitor (CLMA)
> > >     - Access Control
> > >
> > > A key architectural detail is that these SYSC blocks are physically l=
ocated
> > > within the CPG/MSSR (Clock Pulse Generator / Module Standby Software =
Reset)
> > > address space. While the CPG/MSSR driver is already implemented and
> > > functional for these SoCs, the integration of SYSC adds a layer of
> > > complexity due to a cyclic dependency:
> > >     - SYSC requires CPG: The system controller needs a clock to opera=
te.
> > >     - CPG requires SYSC: Access control registers within the SYSC con=
tain
> > >       bits necessary to control the PLLs managed by the CPG.
> > >
> > > If implemented as a completely separate top-level system controller n=
ode, we
> > > would face a cyclic dependency between the CPG and SYSC drivers durin=
g the
> > > boot process.
> > >
> > > Proposed Implementation
> > > ----------------------------
> > > To resolve this, the SYSC blocks are represented as child nodes of th=
e
> > > CPG/MSSR controller in the device tree. The SYSC regmap is registered
> > > directly against the CPG device node. This hierarchy correctly models=
 the
> > > hardware address space while allowing the drivers to share resources
> > > without deadlock.
> > >
> > > I am sending this as an RFC specifically to get feedback on the
> > > implementation of the SYSC as child nodes of the CPG to resolve the
> > > dependency cycle.
> >
> > Personally, I am not a big fan of subnodes.  I assume you are using
> > subnodes because you can register only a single regmap per syscon node?
> Yes so that the consumers don't have to specify it by indexing.
>
> > Would it be possible to just extend the existing clock-controller
> > node with two more reg entries, and expose them through a single
> > combined regmap?
> >
> That should be possible. Or would you prefer just to extend the sizes
> and create a single regmap for it?
>
>                cpg: clock-controller@80280000 {
I wonder wether we rename this to `sysc: system-controller` but the
compatiable string has "*cpg-mssr" postfix.

Cheers,
Prabhakar
