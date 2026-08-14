Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DE37EFE2
	for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735081; cv=pass; b=czWiazbXaBDmLX0LTyo7I+gxrXPeRRDjfarIl/l+ElptpobDKzO4ix3wfpO1bX8Jb2m/k/tuCAM6p+W8dOQgoycHapDKD/2bVQ2iJ8hvMj9nBL/UI/rs2c8ux9A2c3+vxGizDlmrcHv4jqzKo/8WZc5FCyinQ47uoGpFsGhu2vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735081; c=relaxed/simple;
	bh=gGGqgyM1WQNtb4vbREG86MXa9sEfI8krzxGiO31xHEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9HjbskMuCNvLXa6gwX07mjmbtkDp+c/Ag3D/aV37qfRWVmGcHOdp4hzCYRn+/cpmKrgyZvlQAHZ3J+AFFrKsqnQPmuc1iE1lvLYgiImE+O4YAJX0w4HeeR1wLzMmqmufzCnpOQlaInVEtb3j16UGgIKi41iqxNB9fP5qeL8Tpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+eWTaZF; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+eWTaZF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fe89fb333so810009f8f.3
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 12:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786735076; cv=none;
        d=google.com; s=arc-20260327;
        b=f6HtbQdJ7QPdzySzAHZj+k6TCCSQYf8B1Ygb4YHdRbQQEzNx/bE1lrdK/kIPwGgYyh
         edIRS8nSkdcj7sbsb9VA71F1/qWB5DB23ek5UbQTgaDDld9LiyAotimATBHlqoexJKMw
         PwZzvx6whueD2momLfYq+2CmaD3f61MtlihXsR42dsH9WQfc1+ZT/ym/fYBOkWeo6Dt1
         8vN4p1fvqSJVQ10ZZJk44VxdIXCOfifygkIlXuFTIF6hQsAkcPOkjUTKWa9fSw7IL1FP
         +kJN0+a95Hiqo/bOXKOaE4n/HW0qev0PpbipCTrI/RP6+jhxLhRQWxUQD7Cexogpxy2h
         UD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gGGqgyM1WQNtb4vbREG86MXa9sEfI8krzxGiO31xHEQ=;
        fh=PHb73sYNB8rVAd3E5ydtwrAqwtjctcsb3u0XPdvDX+8=;
        b=GCDExLm5lVTLPBPfndJhTd7uD2HlNg2D96s0oNMR5jxlftbQZeS+8bR6L+rTH51lk4
         3ssBYdk/x19s9hMXtpmUIGTEcn6meLuHj6CU2PYElma94ov9dqeqIWRFPA3x3Yszajz+
         B47UlsLyORUNHOj63QXQTBn3FwQLosHogHNG3jfZZrtFyneYHztuPaJjsEkj3XW5gJ+i
         uooC+oFOSpbBdyxoeHTGVjAG9mj6roPQRfWpaydI1D6lrehNeTVnlMteQymOdDx8SSl0
         8FmiUQHOAt1wNoTHHgq5Tq4v/C/TA5s7OFkFMkkc3XJrxFrmtUdZGYKJjfKts0tNahUQ
         XLCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786735076; x=1787339876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gGGqgyM1WQNtb4vbREG86MXa9sEfI8krzxGiO31xHEQ=;
        b=b+eWTaZFA7BFexx/TG/Aglvr2O0kTT+XkojjJFp0hnC3Na8a2kg2hcdRuI1hhAxG6f
         +Ydr9izSrds4TaJ1WLajVhkXBI/yD1sT5ay24GJZs1Z22w2f7cYWeeo8O01XUIhhX2cU
         rntyLj7w8ZMTm5JP/Bu4AM6+O/EuE6rA6lcJQjI8MLfxL+AR9L7oDq6Ktpmb6dCWeLNa
         SzUQC0fg8hUK4DjLHBbfEEUfrkuEjCfR53YxSo7NqnsQ/CBPmG9xjxoBk48tNQhJgw9w
         m003zFdmdrnxMkNnzTPO69+A4TfEBkYnknzcjsMXLTDZ5RjVvZTMJfS7c6djuTF/I2V1
         FJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735076; x=1787339876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGGqgyM1WQNtb4vbREG86MXa9sEfI8krzxGiO31xHEQ=;
        b=pL2d93ss/WXyreUvrKQNfudzSpEKnpjmoEqly/MHjNUTu+x+vvI3H1LLzRrKCZYh8M
         Ip0UlKEfHnS1E8GizNP5NCZX1cptTZc+zXurvmjCmlFwUFG2y/2zSq23TKSz8Lln++WD
         Mke8foeBjtm4wq7E38y4ei5mafMPby08NjccsAmsBYo6cHN38zvev+cJpYfYv9I79Ju8
         1wMDAxQoIfRSugUJp4KBwLBVUH51yiiEvyRq8IDZ8jEg5IP5dQFAwRiSYbWCXItI6+XX
         5tYM7MdWcuqmllx1DKbk0BLl+uMdLek3XDFVvFsZdxA7kZSkrPhCqxrM0PU97bkSzNCu
         7cSw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4jpGx9HaZwAGtmnZTjb3jDssC5l7SVxtBBwj7LxRyXdd4e+VGU3EgAxK8V66RR4Ciet3eCenyS7odNJ51Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjd74OVouxW8ZXy88q1dvnAUuaC942O6B1WQm+mNjA6tfnHquU
	xP4azmjVl5bs8GPCKBH842UsLKItDi8InYKl7HV7D1eML3jR3ILVYsOaNPu++nAAVXt8WCdH73N
	U+0omel8/nrzZhO+Kvn0iR7TpOUOfe2g=
X-Gm-Gg: AR+sD13dbbPKAxzUUMKAHUvSxzIWGr8llnv/muhQSwdeRPln5UyjZlxQHHptS1KT8ji
	m2m8ehReokJ+WxeR0tM4zKt/P9a+1cXmz4r3hzrJAdZborhufmfhB6fZKQyW8hC6A/DRCiB/Iem
	EOoyNlfr8bwyAt6gf0MhpWuNP7wxrOTSx1Ad7lFq33NCnjdmTNFF0+OJktfMyK0cxZ+KR05TKdU
	0lu8CxkG8Hihfn7Pof/DOP6jAScIJOEoIh1ZuTHhvujB2N4ewD4Gzd1kWQlIigQZmIx2TokiQa6
	nq4G8Q7dUSEORta9Yi4Ms5NdFJOX4BTdpIC8zAW16QQ4zqKuV6zkJjpNT7tZgXaHS0tHuY8ZbRS
	47oGU7l3vLZy8uSh1dgtmo20QQLuMPQWW7FeTeICXZTQ004gO2vg5nXAOKXstko3JkcCzyPwMjA
	==
X-Received: by 2002:adf:e38a:0:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-481607a6b59mr10253177f8f.8.1786735075598; Fri, 14 Aug 2026
 12:17:55 -0700 (PDT)
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
 <CAMuHMdUwPdPwKV++3GBvm_yEY0pqvT-KxBr==g8LQFRvZkBnjw@mail.gmail.com>
In-Reply-To: <CAMuHMdUwPdPwKV++3GBvm_yEY0pqvT-KxBr==g8LQFRvZkBnjw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 14 Aug 2026 20:17:28 +0100
X-Gm-Features: AcwNN1U9V05nG8F5x6qoNhExsv1FilBMcJ6qkSKN_Tj9If7A8je8R5Sw1SnfcC8
Message-ID: <CA+V-a8v=jH3vtUUR-c9AEUJU5+YJrO8H7xC_S9LA3EvHMBEyWA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: renesas: Split out RZ/T2H CPG binding
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geer,

On Fri, Aug 7, 2026 at 2:30=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, 20 Jul 2026 at 13:14, Lad, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > On Mon, Jul 20, 2026 at 11:53=E2=80=AFAM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> > > On 20/07/2026 12:50, Lad, Prabhakar wrote:
> > > > On Mon, Jul 20, 2026 at 6:55=E2=80=AFAM Krzysztof Kozlowski <krzk@k=
ernel.org> wrote:
> > > >> On Thu, Jul 16, 2026 at 01:34:27PM +0100, Prabhakar wrote:
> > > >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >>>
> > > >>> Move the RZ/T2H and RZ/N2H clock controller bindings from the gen=
eric
> > > >>> renesas,cpg-mssr.yaml schema into a dedicated binding.
> > > >>>
> > > >>> Unlike the traditional Renesas CPG/MSSR block, the RZ/T2H and RZ/=
N2H
> > > >>> system controller integrates additional functionality beyond cloc=
k and
> > > >>> module-stop control, including reset control, clock monitor suppo=
rt,
> > > >>> write-protection registers and other system management features.
> > > >>
> > > >> Nothing of above differences got reflected in the code, so I do no=
t
> > > >> understand this reasoning. Binding is exactly the same as the old =
one.
> > > >>
> > > > A syscon regmap is implemented [0] as part of the RZ/T2H CPG driver=
.
> > > > Since the RZ/T2H clock driver uses this syscon wrapper, a function
> > > > pointer is implemented to handle the RZ/T2H-specific configuration.
> > > >
> > > > Also, as the initial implementation used separate device tree nodes=
,
> > > > Geert suggested splitting this binding schema off into a dedicated
> > > > file [1].
> > > >
> > >
> > > I still miss the difference. Can you point me (can be short diff) to
> > > actual difference in this binding?
> > >
> > Fair enough! You're right that the schema text itself doesn't differ.
> > I'll drop this patch in v4 and leave the bindings in
> > renesas,cpg-mssr.yaml (unless Geert has a different opinion).
>
> Given you no longer add a bunch of RZ/T2H-specific properties
> and subnodes, I no longer see a reason for the split.
>
Ok, I will drop this change in the nxt version.

Cheers,
Prabhakar
