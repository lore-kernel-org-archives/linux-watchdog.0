Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AF3E3C69
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966322; cv=none; b=prV2Dh6kqzo/GGig46iuTSpTg947j7PmW05v0JrtH+pmUArv+NUymLRBKiwdtGe6F/23rGTa9HQyH54S5Xh7ZDaYb6CWwNgJISFANqylg6YXush2IVQ0oe0GNLli/11CaPNO9SXjWORgr1ZgM26pRz4g9jJk6AuoDVpUEUunjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966322; c=relaxed/simple;
	bh=ukZ9FK4VGWfiaXO2VPuEc3ogAHyIjVxYKoMVyr+5s8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI41vBt3iXhHabuXGOY1sRjVvicI14GflguKKHEPArKd4ppt1ThkpWEMwmbKXi2o6MSjPexlmK45t7O86u4m7moRzxWrovP0ZNcPGc0AtFM/GSsFjy5mT1q99l4+7GzyZo1oAMNjFCzeObnqjRJacoU8e9askgZekWdJonFELhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-57512a429d1so1773437e0c.3
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 00:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777966320; x=1778571120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0fZD/PSymOwfq/roAe5oPCoIu7rlEolsxxYooXw1Fcs=;
        b=JwpsDPjwx94ixChIibO02W9lYz7TK+DRnrdLxIEPINGM2A6C/yA5K7l/4Rd4zmtiKb
         5ND7s6/xd1j8E1NMe8zHQNbUUmAae2rkFdAdGwEJbUJiglVzjHnuM+KE9rK4onobN8bB
         wJY2OFlYnxqAS7SukH4Y1omdc5RH5BovTd8dCV1ovCMfQR30uR7F02rDCMzuTUMRv8CH
         yac6lqPkzs7LV8hIHz6dPyW+alt9do+0PCVcfHRMAl2Mh9J0td2/MMUrquYz8g3oqF84
         wRXC0NOeC46otZMLoWxba+jOCL9DEr6mIhS2iiMCsghXheJ0Dk7Jhp8f5dZqsZW0axvA
         xRKg==
X-Forwarded-Encrypted: i=1; AFNElJ9pqbGkA3/xCGO/0J8cCw2JZpUqt4FM6aQk8xlIbYYP6SHXCsCeKGe9wDSzUcjV3GMhITU519v1F1TqW2NA3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFR3AT5r3cLHj/PJzKcaZNS222B9EQKRhDyutIfOzAmoPKdWoE
	aNMmgrgXovXC5b+5Mag0Cr5eYD7Tkpc6UNsNVNNvpKWwB56ja6/PsHiUlUoLA31F
X-Gm-Gg: AeBDieuPee5sR4FDcH5oQuyp6z34ozTu8fl+6fWrzFBC7pWSeGNP7AC0hp3zU3lnqNH
	qtZTEVSXXUqftJiMAS5xfogWrGxawn4l41GP7p/s/ys0TGHGN8GT/9CwqTfhhxV53Yq4HfXq0vm
	Rp2CLoVt4EXU6AN7LoIZGqSjvP1xDoqtezn7g7pi4/bzBMQcBgzOnhE3b5QplgZuK8nY7u4K1Y8
	y9Cy6077IknRZM2/br58QqRgGe8X5Kqw8g9ugsgNuNzBg0VNc7HANbHmzyU6g3KkMwSiQmNtsS9
	MxvLXzgw/01Bp+6xd2+nX+LLU+jFXErxwkoDf+qNvEUUhOK8pwn6kfF94O0q8HzEdtBvJoXSrt6
	FF+d3maZMGKIc+xSYnVz7Kewi1YhYOla97Kpxtg4E64OfgcyAkZOudP0zIzs4JBg2Blp6ub9kqB
	wB7Td99L8zSLYkdpzuE33rsnPN0dhPFWWzeVnZZueyrkrN9Q2iG5HFFHwQ6B3/pA+2/gMdMMtal
	Ic=
X-Received: by 2002:a05:6122:f0b:b0:56f:317a:65d9 with SMTP id 71dfb90a1353d-5750c4e73c5mr7273583e0c.1.1777966319673;
        Tue, 05 May 2026 00:31:59 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6ef15e0sm7542988e0c.17.2026.05.05.00.31.58
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:31:58 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56f70865797so2709436e0c.1
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 00:31:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+kue02V4r1wno+LhJc7DH8AcJGROsdatAtg1mCV+MVEC0f2/PSLHAqcXjx8CeceuudbyQW33DMTj6untOm5Q==@vger.kernel.org
X-Received: by 2002:a05:6102:809e:b0:605:6089:674a with SMTP id
 ada2fe7eead31-62d8754d144mr5578911137.23.1777966318428; Tue, 05 May 2026
 00:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206112227.233229-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260206112227.233229-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 May 2026 09:31:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVfGA6yie7FJ1p5Vo8pzYfT7JaapVKKs89zDajyjoYdyw@mail.gmail.com>
X-Gm-Features: AVHnY4KGVyBJgcrD6fwdul7hiswvhvhZiaYkMacUewIFbE46z83RiXF3MOHRmi0
Message-ID: <CAMuHMdVfGA6yie7FJ1p5Vo8pzYfT7JaapVKKs89zDajyjoYdyw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/G3L support
To: Biju <biju.das.au@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Fri, 6 Feb 2026 at 12:22, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Document the support for the watchdog IP available on RZ/G3L SoC. The
> watchdog IP available on RZ/G3L SoC is identical to the one found on
> RZ/G2L SoC.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml
> @@ -18,6 +18,7 @@ properties:
>                - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
>                - renesas,r9a07g054-wdt    # RZ/V2L
>                - renesas,r9a08g045-wdt    # RZ/G3S
> +              - renesas,r9a08g046-wdt    # RZ/G3L
>            - const: renesas,rzg2l-wdt
>
>        - items:

However, there seems to be a small difference in the formulas for the
timeout register value on the various SoCs:

RZ/G2L, RZ/G2UL, and RZ/V2L:

    WDTTIME setting value =3D \frac{WDT cycle}{(WDTn_CLK (n =3D 0,1,2)
cycle =C3=97 1024 =C3=97 1024) =E2=88=92 1}

RZ/G3S and RZ/G3E:

    WDTTIME setting value =3D \frac{WDT cycle}{(WDTn_CLK (n =3D 0,1,2)
cycle =C3=97 1024 =C3=97 1024} =E2=88=92 1

I.e. on the former, the "- 1" offset is inside the denominator, while
on the former, it is outside the fraction.  I assume this is just a typo
in the documentation, and both formulas are supposed to be identical, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
