Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371A3D9693
	for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105683; cv=none; b=NDHHjoU4r1n7u0GUjijwDQU8ikp57Yqf0W9KhssXrAYW1gikTLo5Qw4fr9Abs1wc3O7C9wKcao68yyCo+zxuTQo7c0jYDlvEITZgQ6jTKZ3lnXReZJriFfoYR74LvLhrWQJSpE1uiOTfFvhDqUJLxhNJBdOVV/1dzzVHKYLw44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105683; c=relaxed/simple;
	bh=4p7JA6EZMNI8+iBrijHrUHNSvFWoAG8Fnu6BsUPc+bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMLEj5WYtcXXoXJycuORJhur25sWmTVG4An/YpA5gM69I52r67WR1pAnzyeF/A/Z6IsMxvZo/JRULCbPSrc6GtABHu9+RgHzezN6NUt6KQ5NjtRVr+eSGRkxZ4QpROTR7owjnIc7rokE8L6+Nuj4vK2DPFRdmB38g7WJxptjcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-737de52625cso2436014137.3
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 01:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105679; x=1784710479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ByrjGjRxl6chD7mBfQkVFOKBnkOxHgRz/c3eqExfhhU=;
        b=MPIf++IA+rVVVjgmC7PauldTED7HEcc5UAtdT0GmqsMxIWGkNGI2vsY/+5RbvUwkc8
         HGekTMVzFdpj2yeUoMI5URpKyPosh9ZFdEIxrIA14WpVPM14WhoCEp4ycGIwFIAY3wag
         1QhxyqK4XtU+pfmta2EAxQOz0c2u3vOXmERejUy6/szZYITQ8d7sQnkj4Sd17JqjVdOu
         YzKTaeFY57s/YsRQz9qTebhwPbB9vMvyIzydGGSIrszaf0GQaOQ6blMPIk9Q2o8SHFhv
         p6pHQx/A+60ltD1zpd14jsgwccV3tfk3x/LReMU1dxxIVn2Mo//VCp6vsWzZdj9Uxw7q
         09RA==
X-Forwarded-Encrypted: i=1; AHgh+RrDOM1r3CRP8JN59l9BcVnmFqgaRxIeJZByvwbW8JrCxr4VUpXLYlC9x78rCp5E55qJgOcU0C7awB+osYiNJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4GG8Q5FSk1hX1fF7EO7+S83RZ5mE1T/PZFRam/XR/qdToGZx
	vo9IuEeTEVRgx9Ug4clppF1ihdIhWg95gp8ChJ1Ctygfg3zD4Ui0R54a88DmC1imKOc=
X-Gm-Gg: AfdE7cnGxr9m/W52ZKIsD6B09CwKCA0WDqYmmsx8rquvRo4nt3cRRlKakbhX34S/iF8
	N5EK6NvL2zF/Kn1s2W/CiXeF3y1ScrhtqH9cP9MzMJ4hhOTTGAmmXMQIGor0el5+qJ/RTAo42SW
	GrZAuznhZGyDm1A1Sw5MJXl0DZ/wIda7cXkMrl+0MXJhHGpV7VWXqpYQUAaiUmoTWf/gMl5dHMW
	gLryH4plugS/rZhmm9FFOSO/WJhjnlWk5lQO2DTna/a9Db3y7oRgDpONZ3lY+wW9PZRBZnzQWwz
	4GsZR90uTiFMRAOgmKurasiKi5nRocPa8Ojv6riljJz6TWonAUjil1aOgnlJSddNm8v/jO4ZIkA
	ekTO3wmok3Q39pRs0oNLPImRvZ3J+UVDxpDFZC5wsRKOZlAwFC3K/KexieaoVXmYqLA7p2E2xVG
	GfNQ7vd6YdUUWc0hvVsNMDPLW+hZMGmH8+EiLWB2B3IrBwsHVjug==
X-Received: by 2002:a05:6102:370c:b0:745:31e9:f3d2 with SMTP id ada2fe7eead31-74587394a0dmr3065389137.10.1784105679151;
        Wed, 15 Jul 2026 01:54:39 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed6737807sm9750939241.13.2026.07.15.01.54.37
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 01:54:37 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-97622cc1f40so1966876241.3
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 01:54:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr+KUmb+r6IURRBoGx+yy7FpHyXnv1MWBKWVz8ggOI51ZZfUoxiyVqEtdjXbkKIw2zc6F2ScwoEONbhoc1+kw==@vger.kernel.org
X-Received: by 2002:a05:6102:e0d:b0:738:fd01:5b60 with SMTP id
 ada2fe7eead31-74587311ce1mr3372984137.3.1784105677124; Wed, 15 Jul 2026
 01:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUhiBAcJ6P7j0ZxL+0AbVqz88PMo7YX9UiYOK8jM61D1Q@mail.gmail.com> <CA+V-a8uUxfDx2Xnb3uFg2=R+eYnzVmAv4PoEYeXGwAbANxG5Bg@mail.gmail.com>
In-Reply-To: <CA+V-a8uUxfDx2Xnb3uFg2=R+eYnzVmAv4PoEYeXGwAbANxG5Bg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2026 10:54:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQWnp3ipR8xLv3PBVax3sDrZeoH6uw6Cjygf7EZT8EgQ@mail.gmail.com>
X-Gm-Features: AUfX_mxDHx3n63ocxRYS-KeudKm3TNmAE-PyMFFvcB9KNeYvoVs9ROnUvj_T4n0
Message-ID: <CAMuHMdVQWnp3ipR8xLv3PBVax3sDrZeoH6uw6Cjygf7EZT8EgQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/9] Add System Controller support for RZ/T2H and
 RZ/N2H SoCs
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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

Hi Prabhakar,

On Tue, 14 Jul 2026 at 15:27, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Mon, Jul 13, 2026 at 5:00=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
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
>                         compatible =3D "renesas,r9a09g077-cpg-mssr";
> -                       reg =3D <0 0x80280000 0 0x10000>,
> -                             <0 0x81280000 0 0x10000>;
> +                       reg =3D <0 0x80280000 0 0x20000>,
> +                             <0 0x81280000 0 0x20000>;

Yes, as they are contiguous.
These registers are not accessed unless there's a user specified in
the DTB, right? So there is no issue when booting an old DTB that has
the short reg blocks.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
