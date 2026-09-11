Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9453BB680
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128536; cv=pass; b=LiVXXEJ17roD2WgTHLpsxvaTJ6cgzWpU932amFMMZ/ABwQ5PlYEAZK/In8geZAfQDLIu89ZsC636xOaibv8aBa5IldGgzORbKUD8UIW0w7cmNABhD+LYPHdVO7J6oEv6NYHBfipt5CXpxfqBPBPWKTPtS+U/PNJ0tzIlga7M2b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128536; c=relaxed/simple;
	bh=Wmo70Z4UFocZYeFKwLQnXi18nLpqHlJJiS4uZANg4Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+Uz37iruSuIILgK8UM34lXz1/tW0wP/mOt7FCIKyoRF3bKJX1dyqup7PujPyLF52c8Q3w59aCy+ZNLZ6QAF+KiM8PS1MazE8ljbQ9FTDI9JowEaQnonddwXqlUpTKyD7mNJhZp8qBpRpTahjj56+hyRuFuaOHx4WRDUBYVnng8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nib5DIgK; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nib5DIgK"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso484528f8f.1
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 05:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789128532; cv=none;
        d=google.com; s=arc-20260327;
        b=c+V/okdnSb5TGSZQuGeCAYyUK9TkicJnqaMZEcSZxjqk/jdsmVqWxmwmp4Sso3bXHl
         8BG36JWWKsV+IlZSnHP2jXCy+ulm20W1IqkRWQ4TZuig5jaKAZ97AbECFQT5NvDue9bh
         8wWbJV3L1aPey32E4rp4TQCFKTBPS5CgwXlc/IOlQiVmpUJ2qLAFadAftbgLhL+yOzMp
         wRMsZwvEx/I3axN2EP9iLq0XO+mC0iGh+OG8cRtxAAuqrT7c7uFbT3u8PIdBlFwaX0hK
         mMVzW+ZrqDzEBCRvbakuqaXabzR1WZei6+2IH5mbuYuWlzdpT7j2vGZs/m4EoZ1i7GTZ
         paJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BPsynQVkg6+ImOI5Ts+zsO7EhceaQ1Rk9XjAnwab6s0=;
        fh=MEz31uze381REuNMS6q2UVxkiPcbsdTMJxIorZ5SI4Q=;
        b=IPXsEIs0iZq9PMW1ye1yB4yxLvXwZDDQPHnZ++Aq+g67K4tQKoRcAnJTD3ZmzBDoEx
         pFqE1iJTm+a2BCYfqU7umsfbBIF01L8lf7hLwVgTd5qolNT2mjxqkVOxLR//6DcNxAyR
         wLmGRRcWAZNnCHfStY5iRgrz33MTYx3PzUO/InwSklA0VVUtpLYmmAZqpoZYWUOgJDhJ
         raqQW7ME0Fy3DKLOL8xBhKapfw69MHJ7KOCfc4VPE8ncvpTaMSLBJlM6F9WyCxBVmxLW
         U2WnOvXBRkkdEsm5u3QFlT1EuBuGRmOD13nAVJuWSfdHNfj6sB3BxiaBAqm7Fp8pjh5p
         Kqvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789128532; x=1789733332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BPsynQVkg6+ImOI5Ts+zsO7EhceaQ1Rk9XjAnwab6s0=;
        b=nib5DIgK/xinL14VkYrNajaEI/6NEt5Tj1uIsC22pegDGMGsbxNy5chXjsVaxwTbRr
         xqG05yY0OD77sY0Hvv4DfMVkYYoJ9M/pwYQq9AaeporqY/FHTXvBDQUUui5LYxWCfFNR
         AYNCFlUP5Nkq2bQ+UD7RQOg73YTyaGndFiWTiRj1FUzOFYqKiyJWW4V78NvfqK4kOQ7c
         O09C0R8kp79ZvipCujz4FE4CnF/g0xYF5cxgOryDR5nzKRB6Jw90I2PSvMTYai2L7KEp
         41jroZu8PDo246om+zZBaRT6Vi1LK543iQpYWXzVsmu787d/PbTQP9EyANN/Yw98QS6P
         6hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789128532; x=1789733332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPsynQVkg6+ImOI5Ts+zsO7EhceaQ1Rk9XjAnwab6s0=;
        b=PUSgiLEEEFK1GhTPjCZ0imOjNKyzmohL8WVv4MHrdISlUd56mVBA+rrNnTqBHpPfSp
         C9GBaU4rostp2xQ6xouaLndLghmsU9jIXQ19mIxowy6j01QAFQxCvbVRg8HyCsSUqdBm
         mOXNLY9lo6OqqOmYihXZqyrmmyjC0xqRPxa2uoa44O0y/LGP3ItvORvbds1gV8q+gAA+
         1HwHGhpBzVzTc+M/Wz3xCvYB7kgSjSsxHGYzKti8vsIz4TY7ldj/SBdmYpRN1wU+Q+Nh
         Zl+Rz4FKjC/ghpEqwtt9t3mQJjFxzaeZLschvMhSotFTf7eQ0exdX1sygNtnbJMSl/80
         3q8g==
X-Gm-Message-State: AFuF++nTOueXYo+1Su+5GEgcnihW5/mcWCevXhTxrGXf61SZOLH6qyrw
	2ifyLearXXaGcD2tKLy/2gtchkwsJM4UjdAAl2FuftYeYu4/HmzXf7WBtnTAxMdLRoqqb2oIAv3
	4CqF5ujO8Wnal7TpHgVQc/NP5NP5jR9M=
X-Gm-Gg: AYBFou3gMH3pzUF5MpIw3nzUC2EgV/JiZ36PYvWOmF9EWGtea4qOXtg3zrkrWdDQ3eL
	QlDly1CuF5EG3wOnOeddVswm7qQbmesijhrtrpRNp7FEn8HCobqlT8ZfjOJUKifggkAePsTUTCj
	fny34UG6VzwxxQZCcQ1/p4z2BOLXgvZ8sH6OMXnT8uFBKq+hF8GHzc4QezP/SSaEowH2m/sqkdd
	KH70fKYDhUQpjvUDqMVLM7ivG6XmeakZGtXoyRE4OYHjdLWEmJDCag0NYkiL9n7BU3Xj5YR1iR6
	ahPAa2Kctqv1P+a+Tc2JO40U/hSrNRpIT3GYCI6fqFpD3oz7+OLG9sg+CyIdwfHWZn78L4zEftY
	R72mb8ypYbybQR1UQiUNIVnWb0j5+eFbsAu73qaWKNQF0u+JapGFAnexjpXuqM79n5Fxm2GWqGQ
	==
X-Received: by 2002:a5d:64ea:0:b0:486:e91d:9f99 with SMTP id
 ffacd0b85a97d-486eb2e40c3mr8765403f8f.10.1789128532269; Fri, 11 Sep 2026
 05:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260911113216.3810F1F00893@smtp.kernel.org>
In-Reply-To: <20260911113216.3810F1F00893@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 11 Sep 2026 13:08:25 +0100
X-Gm-Features: AcwNN1WzhLhKvgeum0uiJ1v9nMlDLxD4oK7UJnbzkS0PJFF9qRryrARMqpujyiM
Message-ID: <CA+V-a8tHoShO+NXrsYaOvW3C68khLY=+S8xpyKRjOvo757LO2A@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] arm64: dts: renesas: r9a09g077: Use CPG/MSSR
 syscon for WDTDCR access
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sashiko,

On Fri, Sep 11, 2026 at 12:32=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The transition to using a syscon regmap for WDTDCR access is bro=
ken, preventing the watchdog from probing and containing an out-of-bounds r=
egmap access flaw.
> --
>
> commit 0e87a2089f722e3ac7bcab46cff76d445536d9fd
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR a=
ccess
>
> This patch replaces the direct mapping of individual WDTDCR registers for
> watchdogs wdt0-wdt5 with a new "renesas,sysc" phandle property pointing
> to the CPG/MSSR block. The watchdog driver is expected to use a unified
> syscon regmap interface for these accesses.
>
> > diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/bo=
ot/dts/renesas/r9a09g077.dtsi
> > index 40494159831d8..ad5189d55cef2 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> > @@ -327,61 +327,61 @@ channel1 {
> >
> >               wdt0: watchdog@80082000 {
> >                       compatible =3D "renesas,r9a09g077-wdt";
> > -                     reg =3D <0 0x80082000 0 0x400>,
> > -                           <0 0x81295100 0 0x04>;
> > +                     reg =3D <0 0x80082000 0 0x400>;
> >                       clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
> >                       clock-names =3D "pclk";
> >                       power-domains =3D <&cpg>;
> > +                     renesas,sysc =3D <&cpg 0>;
>
> [Severity: High]
> Does this node successfully acquire a syscon regmap from the cpg node?
>
> The cpg node lacks the "syscon" compatible string in its definition:
>
>                 cpg: clock-controller@80280000 {
>                         compatible =3D "renesas,r9a09g077-cpg-mssr";
>                         reg =3D <0 0x80280000 0 0x10000>,
>                               <0 0x81280000 0 0x10000>;
>                         ...
>                 };
>
> Without the "syscon" compatible string, syscon_node_to_regmap() will retu=
rn
> -EPROBE_DEFER indefinitely, preventing the watchdog driver from probing.
>
> Furthermore, will the generic syscon regmap allow access to the WDTDCR
> registers in the second memory region?
>
> The generic syscon framework only maps the first reg resource region, whi=
ch
> the cpg node defines as 0x10000 bytes. The watchdog driver calculates a
> WDTDCR offset of 0x15100 via:
>
> drivers/watchdog/rzv2h_wdt.c:RZT2H_SYS_BLOCK1()
> #define RZT2H_SYS_BLOCK1(n)     (BIT(16) | (0x5100 + (n) * 4))
>
> This offset exceeds the max_register limit (0xFFFC) of the generic syscon
> regmap. When rzt2h_wdt_wdtdcr_count_stop() passes this offset to
> regmap_set_bits(), the regmap core will reject the write with -EINVAL.
>
The syscon is registered in the CPG driver and the issue reported is a
false positive.

Cheers,
Prabhakar
