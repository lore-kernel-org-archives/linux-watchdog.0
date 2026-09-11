Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF2381E97
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128618; cv=pass; b=sTEp3O7WwgMRBdIAkzZc4x3kVtEVD2HvMmZURQiEOvituP9XEjHFbuI2AZW/XLaBX9/XK54sgwHNU66zaRKm08ysBH4sJB5oE10VdqzsNM2qSqpwJ6ej06FukR8u/3IZfRPtI+hwEQCaqum8m8MIsW+6jqG2dWFk0sQC/Vp8zq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128618; c=relaxed/simple;
	bh=s2doigL40MavgJYYi+6feoNcgx2hlI7yC6v15ZMkMkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CluslAxh9AqjM4kVrtOj6TRm4POZ7MOPjK1ZWdUdHqJBzKQHw6uehwo7tMns8+qtv6dH22TguwWj451tRTNHrQUjE7J2IKhINlwetvVGzsHHqlGaPIxDFBYBxF698EDGcpp3PwS9uHYdzUH/H+oFIVWgfwvny5ZCyZsmOq0CjhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJnITs4I; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJnITs4I"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so12733575e9.3
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 05:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789128614; cv=none;
        d=google.com; s=arc-20260327;
        b=UJCCURRug5uhWa4Hrrk03rHSdLY9TrPyNfWnH3oQUjF4yxtzAyxx57klWzuz+K12p5
         yqfB41EuwPcrw1PzWF632LVRdUea5nasjWbTzN1ElPh/ePa4AIehLliLQm3XqFFdb9fP
         FzKOKCNSdJy7f3OqJ+T+zX9M0ZbmstnW44QqppvYeGHjEslI7NTpB3p2u80z/ku5BiYk
         wgjbgzXrb7j/aXoTqZPizbn4X7pc6I2LnlYmAejp+buSYYALk7q6bAaJBvPYZKltvi3Y
         hDog4QyjAwFIPlCOn48G3Q0jJ9gD8bunyr4Sac2UR9gMFCzTG3A5BR2dvHlbSTLrvyjC
         Mjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3J8UlCAdANDfuXwyK75WO7Z8Tmd6ahY31LeseAlh3w=;
        fh=A7JYtss2vot8vxLqXTJz84v16/p8oXfjDjLmRiFFW5U=;
        b=JWs8Ib6WjZP18Vp5k4AeGwyeRjq2DKNbg9g3f2trOzIFEujP7aGFwWSx9JtUflOxd6
         sx5s1joI8rdkntsz3wpcBnKovSL768Z0840QoSLctSX9vajZUE7I+Zm+9EeRgl2f1VX6
         pN1gxD+iM+23htpEoTsLt+MN1u3bK+umTFyk3BfybH3dBFp1KtsLqXXsP91IXvieqw4f
         rZZ9I7C8IMfcR6RRw7FEXCW/rwxYcd+Gx6lPnJEHheuRZWC/Q2as2xFAAacUJORecFhZ
         6UW7Ee0MsXPz1JB9sPFE7OJhIZ8JLN2W03l/ho/KNGuQxMTSkP75YZ3+0npEYOvO1a6C
         LU1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789128614; x=1789733414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s3J8UlCAdANDfuXwyK75WO7Z8Tmd6ahY31LeseAlh3w=;
        b=UJnITs4IWqEYDrj2zmCXCQ9ra2nHSN0SEipTyEWmaag3pjKibnEWj/gft1gkd0nF2Y
         qFOLDzFZ1SpnYGjxkHbWZO0Fvhh0k2/+TDGce9eiT/L7OkSFnXfoXPFCZFSz/mv2dm2h
         1caNsLn/NvCFT2Ue+lYIBGdC8b9vuhOWxXmXAQeYXjEdcRzUW7fA5FGJqQPXCDYppITy
         hPlJod6PbPG4DDizHOD6lit9aACK8bBfe8InWZu/D48PystHHco5vhUmRJdkdu2Q2I5R
         fk+ppuLwO4J3AbXFqb8WXmvCUwDDH0tlCeMzMg3SFt/vi5S5ZWSrSjd/26W0XPWHq7hO
         JMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789128614; x=1789733414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3J8UlCAdANDfuXwyK75WO7Z8Tmd6ahY31LeseAlh3w=;
        b=h7qqkBmSVVhE18Q7h/APv4n1aBQTZVCJ9MJSv6TAdQwQ4lKiC7Mr5BJvr+PGKN50QU
         Vjs1RxKz9qrTlXzHh7f3T6MotNlqAV3VnD4VDI4fGaFjKmFRj8neJf9iUJI9tpmxhTWE
         ziRZD5ygXhWnVExuI5erWl7U+hYzgdxxVK2vfu1XOF4kyAbDp+B8EU08JehNpFP4gmT3
         fZ1cCZFY+9dGBAUdSmIo4KaaRuTrnnmaxQX88p6D/SpvO0K9uCLg+4VjxRKXiQjBhh+3
         bb4WFuFXVCIWEDzO0kc4rv8ETBHmCsZFONd8pYNM8Fq+bww/t5QGwdGXYi+pd8dmtqJu
         iE4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxK3YajH2SE3JQNIO/FNlldX9Ph0m4Hao0CU2rAHeCMgTaQN3Yl4TipGZxARcgucmCiL6RNm4UOSwlqmOq31w==@vger.kernel.org
X-Gm-Message-State: AFuF++n3jNZki2kYwirKGpgTARKj9eYAHrn2uo3sswwsaQttFpjbdT0d
	y42kVb6/Mv+vAYcWOv1A8Im5jBlxT8BlvfYXDo2EPvzBPVF0qAaewYWfyBQwdTzbVnL7Ah+HpIW
	NffH2NUMPSG/TglHSyzX3ElEfs9G8tss=
X-Gm-Gg: AYBFou2CNCroyZQFat8Cd3CAcKKWRK4ugjOTU2qjjnz4tN74EKoxIQjd7/t4JNMeM24
	sJ2/if0xYUFw5d9tE8K72AoygFoxWlwCfF4alIcnSH2eeMAnxwpMapp1fi4Uor6VHctZNxGT6l8
	8II3lfzC+EPY4Xc3nn+oF9OL/VPE/NP4EsoO+Lgc8/FAAyoStC9KuDpXHK3NXNs4PUjq483f9yU
	OB7an1CA4HZDGJT/EiKjMI7oC/3V3kWog7oyDG3MLmtYVJPjkqoEIWakQKepdAKyHPrMOjt1T9+
	jUOmwz85eab09declDvbt4z5P6eLUR8ZlJvYEA02JZqNL3YoiihRXwCN3J6+eHfOZYT08K9IOlU
	J8v3E8QhZTkrRtFmDSlg2pgFWeJjvRzXna7Vll+t2aZUG1N9n04Don3gaNLzyyAzqHe9+BSbTQA
	==
X-Received: by 2002:a05:600c:3ba2:b0:49d:99:1d98 with SMTP id
 5b1f17b1804b1-49e619881e3mr56892275e9.9.1789128614171; Fri, 11 Sep 2026
 05:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260911113322.F03531F000FF@smtp.kernel.org>
In-Reply-To: <20260911113322.F03531F000FF@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 11 Sep 2026 13:09:47 +0100
X-Gm-Features: AcwNN1X3EMrEnABSXEIebhNF9fcbF1O099DZU69vOon2jNzLHf0JqRb5x3-yA24
Message-ID: <CA+V-a8uJLn1N5+ThxH4c67gO76ksuJeMFroDf-WHM_4QLuqt-A@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] arm64: dts: renesas: r9a09g087: Use CPG/MSSR
 syscon for WDTDCR access
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, conor+dt@kernel.org, 
	wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sashiko,

On Fri, Sep 11, 2026 at 12:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Watchdog probe failure due to missing syscon compatible string i=
n CPG/MSSR node and invalid physical memory bounds for the disjoint second =
register region.
> --
>
> commit 026369134b14659a11e1791a537a1142aec5c877
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access
>
> This commit replaces the direct mapping of WDTDCR registers for watchdogs=
 with
> a renesas,sysc phandle to the CPG/MSSR node. It updates wdt0-wdt5 to remo=
ve
> the second register region and use the syscon interface instead.
>
> > diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/bo=
ot/dts/renesas/r9a09g087.dtsi
> > index e8d4f76949ccb..40ffe56a40353 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> > @@ -327,61 +327,61 @@ channel1 {
> >
> >               wdt0: watchdog@80082000 {
> >                       compatible =3D "renesas,r9a09g087-wdt", "renesas,=
r9a09g077-wdt";
> > -                     reg =3D <0 0x80082000 0 0x400>,
> > -                           <0 0x81295100 0 0x04>;
> > +                     reg =3D <0 0x80082000 0 0x400>;
>
> [Severity: High]
> Does this change cause a silent mismatch with the actual hardware topolog=
y?
>
> Generic syscons map only the first contiguous reg block. The driver compu=
tes
> the WDTDCR offset as 0x15100. Since the first CPG block mapped is typical=
ly
> 0x80280000 with size 0x10000, accessing 0x15100 either fails the regmap b=
ounds
> check or mistakenly accesses 0x80295100 instead of the previously configu=
red
> 0x81295100 located in the second CPG block.
>
The syscon is registered in the CPG driver and the reported issue is a
false positive.

> >                       clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
> >                       clock-names =3D "pclk";
> >                       power-domains =3D <&cpg>;
> > +                     renesas,sysc =3D <&cpg 0>;
>
> [Severity: High]
> Will the watchdog driver probe fail indefinitely here?
>
> When the rzv2h_wdt driver uses syscon_regmap_lookup_by_phandle_args() to =
parse
> this renesas,sysc phandle, it evaluates syscon_node_to_regmap() on the cp=
g
> node.
>
> Because the cpg node in r9a09g087.dtsi lacks the syscon compatible string=
,
> and the renesas-cpg-mssr driver doesn't register a custom regmap (e.g., v=
ia
> of_syscon_register_regmap()), the lookup fails and returns
> ERR_PTR(-EPROBE_DEFER). This prevents the watchdog hardware from function=
ing.
>
The syscon is registered in the CPG driver and the issue reported is a
false positive.

Cheers,
Prabhakar
