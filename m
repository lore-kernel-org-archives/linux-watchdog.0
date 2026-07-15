Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B43D9536
	for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105800; cv=none; b=YjcBGJX9j0smYwSUrMZep6iHS9gg45yxTqJEgG808iGBZqbXFc26JT4NTm3Cg2kM5nopN+yj+5wa7FIQs7YLdaqt0NZw3g/vrSjfhutj03CyZdJRGOXgQWWqWJFhhmRMpk+Q+L6ZhHdWfLUY52HlADlqkjWcb7hDOOxdvkvp054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105800; c=relaxed/simple;
	bh=UpStxGVYslbxooun+2Y901dqVJN3H5rYG1yY1FSZ/gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPylnfsD0PAssKpVB07QIZ42RBEBwsBRP27oaXlqLsTnlXyLG/FArg1/mEX50Qc7SELgmsZ5BOM0VJEf8/7P2JA+RQJALolY/ca3U49UB7pnElS6umCHgASHEvXxYSav5Ibg9PYNPYZW6MzS3j7h4ZaIIu0lIaQ7X0ue1lIVY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bfd1df4835so2061466e0c.2
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 01:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105798; x=1784710598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIyweZY2e0/6Tej8S0XE9Agd9YDC5DXPE+LxKJOtIuM=;
        b=DNGIuA8PrLoIgtWu5/EaXNdeUiViuuWzGxE09nVMDqEIrrG9/pwlfXPwR+CK+SjRZ4
         H1rL3tk8ZQ8fXiRinL3MgYMitIn6BipadrUjTiGmzI5Bo/fhYPKgxhM3AhZlQMGiIqlB
         2kgsvYui45YWuQM/bH9Z1AWSgUKrlhaQ4BUPg0AjWA3ESOI/QmKWQ3ompPuNXsSkgKBl
         nu5kgpMfrdNRl0afLbXkXdffjJtf86yXK99LEqUk61dL1ypYmgfv/95agELP96DQ+Emp
         3epg6SZYfL2G1UpWlBYnqE6+jP9wj11LKhsrMbFZxpj4hSYNcCwoJtpm94QhgfrZ1JxH
         i8/g==
X-Forwarded-Encrypted: i=1; AHgh+RqoiiwYDQPXOiEyCarRKyBKfTMVJ/TTs+g52T9F78pyQHX7HNHH1FOkSRXLYI4fyFj2tYFg0k/blHL2aTh8Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiQPwc/oHMY3QsdYJ5MeUE6DEMheCKM6TLYgvv7j59i3EWdMl
	k414IIl9AImutqNODNA5EN8xYh69jlPAdcH8ciA5nXx+3mXlt/xOcjG5s+DvJ/vsyiA=
X-Gm-Gg: AfdE7clNovFUHUSPMwG20H61qucfGL5pI7BGRsP3/xzwgihmDc1Fsp1DIj6UxDc5k7O
	oC4bpJ5YSnLsRdcDv0gSRsUjZBL9ABRHPeycCdaHZNjYDltiI2JMs62Lz5qjP9JHt+ArAsDZ2Y6
	IEyJRNc4CFf+zqQOv2pBw0u3nbvJXNkgXAydEX2C3itL9HbVVxe2zBlKg8CCdDhbisdOiJcCao6
	4TCGlgz1yFAuFYYVhItvIVN9NzvTfO+COMoi8NhjgRSdt/FWeGIxGLPkdCwkHIul8fie/QS/KkM
	lkQjUsCcwd8S4FiNe6ROFra7IwEDfxG4Gh5o29enjaX7RTD4sG5E3ux7CuLy5bnUpyePMoFPCEz
	eg9Y4GO21S21ZaF/0aBFmy1TPOWXEkWNKqVpTO05ODVhK3IIvi1/amMav2mKXZ/C62ELpJNCa+p
	G7hbTNyR+UjZdE7Zo3YZWHV/juyvSevL0qHBcgNLIJgayVl1lkyQ==
X-Received: by 2002:a05:6123:91:b0:5bf:8109:dc81 with SMTP id 71dfb90a1353d-5c1163d46f6mr3305675e0c.14.1784105798156;
        Wed, 15 Jul 2026 01:56:38 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c0d2879f13sm4968689e0c.0.2026.07.15.01.56.37
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 01:56:37 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9691bfc9f81so2950341241.0
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 01:56:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoFgCuTmHLEy42uCtbQKVh8Jndd+Vx+KkJRRZtII/ouGKRmZDDpyEUhHnBbs1ur62moIQFDmcSiDZXQy8RpEA==@vger.kernel.org
X-Received: by 2002:a05:6102:1499:b0:737:ba2e:8a26 with SMTP id
 ada2fe7eead31-745875931d5mr3323342137.27.1784105797210; Wed, 15 Jul 2026
 01:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUhiBAcJ6P7j0ZxL+0AbVqz88PMo7YX9UiYOK8jM61D1Q@mail.gmail.com>
 <CA+V-a8uUxfDx2Xnb3uFg2=R+eYnzVmAv4PoEYeXGwAbANxG5Bg@mail.gmail.com> <CA+V-a8utJuuwVNy8o2zM5jHf9qXx36S79uKGtYr5O=sASh_wpg@mail.gmail.com>
In-Reply-To: <CA+V-a8utJuuwVNy8o2zM5jHf9qXx36S79uKGtYr5O=sASh_wpg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2026 10:56:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVT-wWtJaB1bHR3CjfjEGhVfWWKrs6YyZbahOTFSFK4Kw@mail.gmail.com>
X-Gm-Features: AUfX_mwT5leJvJcjodDPFjgFmedyheuuombdI-qCHkgNmnfgE8I_sxJbNtJF5DY
Message-ID: <CAMuHMdVT-wWtJaB1bHR3CjfjEGhVfWWKrs6YyZbahOTFSFK4Kw@mail.gmail.com>
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

On Tue, 14 Jul 2026 at 18:51, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Tue, Jul 14, 2026 at 2:27=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Mon, Jul 13, 2026 at 5:00=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > This series adds support for the System Controller (SYSC) blocks fo=
und on
> > > > the Renesas RZ/T2H and RZ/N2H SoCs. These blocks handle critical lo=
w-power
> > > > management and access control functions.
> > > >
> > > > Hardware Architecture & Dependency Challenges:
> > > > ----------------------------------------------
> > > > The SYSC in these SoCs is a multi-functional block responsible for:
> > > >     - Clock & Reset Control
> > > >     - Low Power Management
> > > >     - Clock Monitor (CLMA)
> > > >     - Access Control
> > > >
> > > > A key architectural detail is that these SYSC blocks are physically=
 located
> > > > within the CPG/MSSR (Clock Pulse Generator / Module Standby Softwar=
e Reset)
> > > > address space. While the CPG/MSSR driver is already implemented and
> > > > functional for these SoCs, the integration of SYSC adds a layer of
> > > > complexity due to a cyclic dependency:
> > > >     - SYSC requires CPG: The system controller needs a clock to ope=
rate.
> > > >     - CPG requires SYSC: Access control registers within the SYSC c=
ontain
> > > >       bits necessary to control the PLLs managed by the CPG.
> > > >
> > > > If implemented as a completely separate top-level system controller=
 node, we
> > > > would face a cyclic dependency between the CPG and SYSC drivers dur=
ing the
> > > > boot process.
> > > >
> > > > Proposed Implementation
> > > > ----------------------------
> > > > To resolve this, the SYSC blocks are represented as child nodes of =
the
> > > > CPG/MSSR controller in the device tree. The SYSC regmap is register=
ed
> > > > directly against the CPG device node. This hierarchy correctly mode=
ls the
> > > > hardware address space while allowing the drivers to share resource=
s
> > > > without deadlock.
> > > >
> > > > I am sending this as an RFC specifically to get feedback on the
> > > > implementation of the SYSC as child nodes of the CPG to resolve the
> > > > dependency cycle.
> > >
> > > Personally, I am not a big fan of subnodes.  I assume you are using
> > > subnodes because you can register only a single regmap per syscon nod=
e?
> > Yes so that the consumers don't have to specify it by indexing.
> >
> > > Would it be possible to just extend the existing clock-controller
> > > node with two more reg entries, and expose them through a single
> > > combined regmap?
> > >
> > That should be possible. Or would you prefer just to extend the sizes
> > and create a single regmap for it?
> >
> >                cpg: clock-controller@80280000 {
> I wonder wether we rename this to `sysc: system-controller` but the
> compatiable string has "*cpg-mssr" postfix.

I think the current name is fine, as clock control is the main function.

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
