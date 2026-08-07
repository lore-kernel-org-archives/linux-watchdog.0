Received: from mail-qv2-f1.google.com (mail-qv2-f1.google.com [74.125.230.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471264772A4
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109431; cv=none; b=UUzqiRhB3cAR06hs5VwrAQI+hUgBFhVm1f68KQ0DlffeCshAlGJHogwOszYIK9UteNCWfYKupat4xzeEXv5g38diCDAJpqbOKcsATwvWndTihw6FJSzvMvsjcjhsKkDWroN+b8wr/ajhcT9k+ATYXifuCmR+rwax3nS0qLgOHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109431; c=relaxed/simple;
	bh=lNRMCMZWJrIGh1fhRbztqbQIc9J7TxN7ZrtNGrtgNXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPrZMB8/43BVypc1PpkxsTcIk1vGIvhSeHuDoHlyjqEg/Scm00b33jdY+SKYSi6huMzNgt3odqi2GZXzcFnVAoeYmhNyUqXAS6PBW/zgOcGDuqcHCOgCKDp01/hTb/8UBnruY0aPBinwBekM1GLDlNM8sAqbnuuKMXCZyUSXG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.230.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv2-f1.google.com with SMTP id 6a1803df08f44-9075195d3e7so3475436d6.1
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Aug 2026 06:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786109424; x=1786714224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/AAuSUTI9BlhHsMbAPbLkKHE3Mv88lOoxgJOEPTw6U=;
        b=m8RCUTDV6Z78z3PwOljww7R7kIOI8PvkLSuGcnpo2neMOwV6VvAuBvECL5PlVtW5Fs
         lWleLhdet/vvN3Cm0oD7pDlcKkSPgDfuKf1AUigUcuHELQohpYMwjI9moA5hmacrAx0E
         61f0F6WGxrPAw353XcoHvq8TXJj2KeZrgb6GvwEMc0rbXq/aVVYHLkCdO8adV7SYeCGm
         oUylU6VFTIkboF5RIkAdrw5DuGc7llqfIFp1zkYYtM/ETfKO+sBDjuUZx8O/aCwXgULN
         6C4XRkFcsN6iPmMyGLoIpNwIR5xPmOPF8Ez2kamHC815n8c7pwN5vjRtNPlIuMDuVgGd
         6j8w==
X-Forwarded-Encrypted: i=1; AHgh+Rq4V7otQ1hoANu0Z9W8zjMia5rHCywx9MLor/wW9noHRgppfML6IThvnDRuu+CW4uES/T/qjpD/EpeScsV/cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBRU2QuZWZCY5qbVsTH1/doDqSDCPKVEZXmihQPj2ESegVu5L
	zWd4UCfmhz/K97imGgP4qs7tIxoYmwheP8vg8YZRmQUJUcndaA00LgQp717Cap5j+LA=
X-Gm-Gg: AR+sD12gXjYAJBmvDZKllgL94W/ujzta0WkQJg0VAIXJO2VLxsI8WsVCUu9tpwTr5T0
	yOY5M4fyjbvxlnI67Djqp8XKGXZu/cgsc4PMiW+zELSevWU/8kXj55MCpumUGRORkaMB2QskNQI
	Hu3LvRx73lTBn9Bh5z3bykDgotMu/SW4iw0/j1ydsZfT6WQ23Wu4OOue4kOcyS4xBfbh8OHiVCX
	qgSE4WkGmGH3/Fv0hUC9DH1F1bZ6zlbrWm2LKa20fM1GvlQfwgdonKJkSavAMS3q/iQwHTA7wd5
	vwGb6zOGFdSrwxwD6wjTdRZPjgE/Ff8HKY57c24jZbfcLyGjAL+8BHJQ6KNYz/53mzauJUe+rfH
	34lN/l35XIYhRTy9c0bRqtpjjtQyIcKjuDj2RmucDGMYts1NM0AKGcDDZ3lGetvw7/JGiMSZkdF
	4KAx1P1YSed96Xq/Jdkqa4WoDRQNb5Ak4UONOnRV0j/tPvchWagYVHrj3HD5mrI8BzwUGCOEh3N
	vLrYvC6uBJbkFr/rYuKwnXyLQ==
X-Received: by 2002:ad4:5c43:0:b0:8f0:9d9c:52c2 with SMTP id 6a1803df08f44-9088108de78mr270002356d6.5.1786109423350;
        Fri, 07 Aug 2026 06:30:23 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a9348e70sm8695966d6.43.2026.08.07.06.30.22
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 06:30:22 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-97622cc1f40so2026427241.3
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Aug 2026 06:30:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr24H6irI1F3zTPYTXSwx9KdKYUYrRPUeeFgs7I4XHl9Pl0XGa1b5fEMlBQ05t+g44AV/+i0EPeSoj6lPFpzw==@vger.kernel.org
X-Received: by 2002:a05:6102:1491:b0:740:2d40:a234 with SMTP id
 ada2fe7eead31-760e934083fmr7749766137.9.1786109422395; Fri, 07 Aug 2026
 06:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260716123434.2576253-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260720-fractal-prodigious-spoonbill-86f534@quoll> <CA+V-a8tfCL58j2TvoO1VhhDAZf=8LB89R4O0SycLghYGf7Rr4w@mail.gmail.com>
 <2323f9bd-0b1e-41be-8c8d-6906b66b625f@kernel.org> <CA+V-a8sHbc9WSqmzrONjWbLY1+SSEhK3kGOjL9zmVmhSttD31g@mail.gmail.com>
In-Reply-To: <CA+V-a8sHbc9WSqmzrONjWbLY1+SSEhK3kGOjL9zmVmhSttD31g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Aug 2026 15:30:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwPdPwKV++3GBvm_yEY0pqvT-KxBr==g8LQFRvZkBnjw@mail.gmail.com>
X-Gm-Features: AUfX_mxDi0guSe9Khaez7xiSfow3Ijch9zm2XE5dr_dyKyhIvomQpIBNYO4wzk8
Message-ID: <CAMuHMdUwPdPwKV++3GBvm_yEY0pqvT-KxBr==g8LQFRvZkBnjw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: renesas: Split out RZ/T2H CPG binding
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, 20 Jul 2026 at 13:14, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Mon, Jul 20, 2026 at 11:53=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> > On 20/07/2026 12:50, Lad, Prabhakar wrote:
> > > On Mon, Jul 20, 2026 at 6:55=E2=80=AFAM Krzysztof Kozlowski <krzk@ker=
nel.org> wrote:
> > >> On Thu, Jul 16, 2026 at 01:34:27PM +0100, Prabhakar wrote:
> > >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >>>
> > >>> Move the RZ/T2H and RZ/N2H clock controller bindings from the gener=
ic
> > >>> renesas,cpg-mssr.yaml schema into a dedicated binding.
> > >>>
> > >>> Unlike the traditional Renesas CPG/MSSR block, the RZ/T2H and RZ/N2=
H
> > >>> system controller integrates additional functionality beyond clock =
and
> > >>> module-stop control, including reset control, clock monitor support=
,
> > >>> write-protection registers and other system management features.
> > >>
> > >> Nothing of above differences got reflected in the code, so I do not
> > >> understand this reasoning. Binding is exactly the same as the old on=
e.
> > >>
> > > A syscon regmap is implemented [0] as part of the RZ/T2H CPG driver.
> > > Since the RZ/T2H clock driver uses this syscon wrapper, a function
> > > pointer is implemented to handle the RZ/T2H-specific configuration.
> > >
> > > Also, as the initial implementation used separate device tree nodes,
> > > Geert suggested splitting this binding schema off into a dedicated
> > > file [1].
> > >
> >
> > I still miss the difference. Can you point me (can be short diff) to
> > actual difference in this binding?
> >
> Fair enough! You're right that the schema text itself doesn't differ.
> I'll drop this patch in v4 and leave the bindings in
> renesas,cpg-mssr.yaml (unless Geert has a different opinion).

Given you no longer add a bunch of RZ/T2H-specific properties
and subnodes, I no longer see a reason for the split.

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
