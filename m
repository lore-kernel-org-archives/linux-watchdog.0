Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE756480DF1
	for <linux-watchdog@vger.kernel.org>; Mon, 21 Sep 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989862; cv=pass; b=tIkAmfXWrtRu3XjGRoUb6srCEaszr4akthJwx5SqvwNuhPt6f9zuqzZnLDiLwjvHlNQYV9a3Hlt8ygs4p4qWBC5OKBQDa0msDtacnr/S4rwkqA+kzVmTiJ+iXYK08GFlos1/ldDlFLls/QEMpZCgmClzWZbOTxEFl05z2o0bsRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989862; c=relaxed/simple;
	bh=y/eWHTyXoMpFdp4Bz0hrXhzEPnH88xFODm0JNc+iGDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHmVu23Sep+LICLXad2ucEBp9+ksSqBEXHrs6bXU5ByvlJi+v1EDEGqEn1KVYPRryxBHwI6GFdId1IggcMFjOmgMipJayghJfU5+4f/AzRcyvQULABmLBR3aJZ29DMHIcm1VwC8/rpOiLDR77pZUwgKhAF7y74YALZbBQNCe18s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThX742iP; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThX742iP"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso2241265f8f.0
        for <linux-watchdog@vger.kernel.org>; Mon, 21 Sep 2026 04:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789989856; cv=none;
        d=google.com; s=arc-20260327;
        b=G/SNLyP6QVCgjo9WetpQ/AIgkwit5ysBZTYEnxcu/p6LKGJiwa0jxpv4TYxO7rHu/A
         mcECnbzHTnBvlbTifqSSUah1HvRR/5KKfKEpPZJkMDpo5bT/3NyP/IOMrCT83GgQrULm
         xAice9hCFImldi0OkRmD7HMxHSeaOQ90udyRXVUClEfMDq2hvDbOoSN4o9IKPFhnyH7z
         Yl0sa2Lxk4myjf+wRtCtF8I4RX7YspI6PBbomEjDW/riarkkpfQs5RnkzWl3MHdD8rMt
         simJEiCvoABuVC2UWk/SprMzbmvFHL2ZkCJhrcUQVFz7wl9bHU/2OdCtPBWv2RqXmVUu
         B+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y/eWHTyXoMpFdp4Bz0hrXhzEPnH88xFODm0JNc+iGDo=;
        fh=1hfRmascbu2XSuATfA8pXUSkOaBg7bjeoijZGpqKn/E=;
        b=AQFtB3UP58UJlh8qND9zE+8HxZylGtEY39Iv09mC40owTxMf0HWtuYGCRrWPJmncHj
         G1QFkATyDJpJ3vZUljbyQJZLtVqHlkCa2KJ+bEh0cpKiWHSiV/ypwjvSRx6vZB3zdJT1
         UDQSlP+QW1/c1ICK2tNXD0fxQ5HJJBJ5+nE5NrjmCViZRItxvtZrDePfIFD48hEwHcfl
         DzkYdZ1c9TOt/M5ChjPyZi9i4Mg1qGXWh616445KKKKzVd40p8uLHAxemroyDHz92Sbc
         7upETucjtm+p1m2yIGWdAwcgvTQjP+DsnM72/QSOXRZrDs6M0nQO/W6jLmSLw7/Mni24
         w6Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789989856; x=1790594656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y/eWHTyXoMpFdp4Bz0hrXhzEPnH88xFODm0JNc+iGDo=;
        b=ThX742iPETQukFX3BBlsPPA+JqXvvRIUi3buvYb6DHUJ8uhywR7FkPybPC3WtdM2td
         cw+JZn2MXPLxNJkU1hv/HjhYQbCExqead52s5CZSES4onYM6ZeFng/l1dI4W2aCJ070z
         sGUIx8WWnCBUSgqZw2OQGQDhU4eYseFbxWM7XOZhjmsVd9hw+zaQJd17FyC+lmjZlng7
         YrB893St+30OJ3wABghrgJytAqkSKr044EIXFeyfBUmZZurPVJoA7+OODterBi/HYktB
         K+y+DZZjHv2NV80Cj+p5ANMayWnacg6V/RlXynE4nq+plf2w/FGel/B+E5JwiNU9VlO6
         LP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989856; x=1790594656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/eWHTyXoMpFdp4Bz0hrXhzEPnH88xFODm0JNc+iGDo=;
        b=KA0ZPk5RqXGVioXyNJC30KaLXcVmlRSNA1bkEJxcrBKc7+X9co2d+Fh4H0QvzIADpA
         KynVLRnCPc2+gqNkwPLGUCcgIKWlN5evYKfPbpG5D+sxuO/srl2yZel+wmkPD0MUvtNl
         cht3u2t2S+gDexn8+QQ216r0gevjeUcnBWoAa4N+kxvjVGoItMnFUW5uQcoB0UJsNrff
         T039qFLFFwK4wX7ipMHjPM0Bk1hAAJlTASbxWm/8upc8zyBYj8v6cD120fOAl5LqYPzZ
         vAjTKUlPmSmmi5cjjHMLvAeBMqx7owbkoQw0bJ9hO4/7NgMv/aF16niSinci87/5EMgQ
         0Yyw==
X-Forwarded-Encrypted: i=1; AKwUvBxR6YO9RDcFAfs+0z2hxT2NtgkVa5z1Gam6+YXgjynkPgDw6DH6bxFnmYWxzP2cB3zLOamJgr31QDucJ6o+kw==@vger.kernel.org
X-Gm-Message-State: AFuF++nXHJDvRs12xuiRJuHfDQJRh/NWXSO0tXc6PEjwo3URUEJGR1YN
	/RJHgtnokLGE0CfPsrymI/S5lBCCgpfUfkIQ/MnsQX8ceSKbACLFwNsIcZngV5K4wSfUzuxdf9T
	N9pm9qyUckf8p7W0ayPHIHItPP7FT3ak=
X-Gm-Gg: AYBFou2g69hjGHIxv9ohmQ+8N+BR0wmUBBjp+jJlJKWNeWeNi/mtadt/sVqZIhmO1qr
	AgBYT5K8gWy6rlCDEeRFcgQEhuUImOdEwuu3Mntop2PEL2vQJxTKfXn5qXRQBVJRq0UgwngTMBq
	9+174AMOLUXbENjy6KqzvK08ZChxOdBcfDjQaD0qP61HQRWmaB/HSlletCQwgqxbMycPjJIRjd6
	KE9RGC4jg709coSi73KLEQuT/RJGW40ncgOsfGV7R58QYFp9Amm2UwPP+idUUQ15eboctiemi71
	pmdxTJOclZzrZt4i8S7aExCVJj39DwFzwWhQwQoybzKrtg/g3/GErJu/k44TAAFwVZg/ON1t9K6
	DcFzYl4pxBu42B3032oNa9dg6pTEkCZc0ZJ2EOUw4ZhVwZcYszqBGGn5JfKT+nWnxVNjg0rZO
X-Received: by 2002:a5d:5d03:0:b0:487:8ef:5303 with SMTP id
 ffacd0b85a97d-4871e394d18mr16926933f8f.34.1789989855856; Mon, 21 Sep 2026
 04:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260817192540.423994-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87577cdb-7f1d-4a9f-8a61-ff1f272234d9@roeck-us.net> <CA+V-a8vVtjALarck6PE3it1si2hNbveZWoGjTaTUW68Q6yYjcQ@mail.gmail.com>
 <a73c5d5d-dd64-4061-83cd-0a1cdcc2db4d@roeck-us.net>
In-Reply-To: <a73c5d5d-dd64-4061-83cd-0a1cdcc2db4d@roeck-us.net>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 21 Sep 2026 12:23:49 +0100
X-Gm-Features: AcwNN1VFoJ0rwe68Hi1fMS8HP9OtdClqcRaDuoUukIno7KtW8dqa4XMt5T_ytyQ
Message-ID: <CA+V-a8tugekX_ykWWMzVkHbEo4huviGYdJuECEfuYVZo6dY5wQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] watchdog: rzv2h: Add syscon support for WDTDCR
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Fri, Sep 18, 2026 at 6:39=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi,
>
> On 9/18/26 08:18, Lad, Prabhakar wrote:
> > Hi Guenter,
> >
> > On Thu, Sep 17, 2026 at 2:12=E2=80=AFAM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> Hi,
> >>
> >> On Mon, Aug 17, 2026 at 08:25:38PM +0100, Prabhakar wrote:
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> On RZ/T2H and RZ/N2H SoCs, the WDTDCR (WDT Debug Control Register) re=
sides
> >>> in the second register region of the CPG/MSSR block. Since this
> >>> multi-function block is shared with other peripherals, it is exposed =
via a
> >>> syscon regmap interface.
> >>>
> >>> Look up the SYSC regmap using the optional "renesas,sysc" property an=
d
> >>> derive the WDTDCR offset from the watchdog instance index.
> >>>
> >>> Retain the existing MMIO-based access method when the "renesas,sysc"
> >>> property is absent to preserve compatibility with existing DT's.
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> Can I apply this patch without the other patches of the series ?
> >>
> > I posted the v5 series here addressing Sashiko's comments.
> >
>
> Sorry, I was getting confused. I somehow thought they are different serie=
s.
>
> Do you plan to send v6 to address the issues reported in v5 ?
>
Yes I do plan to post a v6.

> Note that Sashiko no longer reports pre-existing issues in public,
> so those will be out of scope.
>
Thanks for the note.

Cheers,
Prabhakar
