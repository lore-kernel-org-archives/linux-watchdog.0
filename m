Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009B31A07F
	for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958899; cv=none; b=lSNQSxNNa6+B2RugdjUvekH99+fvHWoatj8p/gzw1ExNQcIVR4yjygvDZHQsAl1gglAQ9aSr5WtlHKy8pjBLaU/Y/2T35ZcmQ0xElrUWq9eKtXvYOKzm4Lpd3FL6EVlJhj/2WslBVBK7WccjJrjvGCgRwBc+pUJeJUEYClIN6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958899; c=relaxed/simple;
	bh=SsOh1enJoELJHzfIclkKXerzvf46Ll/w8xxgwM0UOnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYKlYEZNIt7xCacPjpALinpUu2IpISH5m3Pz3vc1DZ3io2o3PbCvV3X2+NqMqTOZ1OBtjjv9WEd+icwFwZi3yWwgnFXv27hpVAH+ISx7iJnEslwWacUj8F88RMopY8P2lz/fupjDXtxONIB+sTrUgi3yKGx67G/44nbHC1seG/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a30bcadd95so29434eaf.1
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 09:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958896; x=1784563696;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=674QbDTihSeDJzkwbUpD4t11m/0pIrH8HDq4q33BUPk=;
        b=JFYYDgvTZd+0SRUqOsQhYJf4d5Wup3z7CacTNVgv6AoIKEHxiBI01qAyt5HqRQVWex
         Kttw9n6tPTL/tjx0ui5361nw5clVvC6yCbusQdzrbuXCko5q6WEEYTmzz/aqfxgyaoKM
         8gvh9w8q/IlyGEJVZCaP+uFVQ1epQ1txYwl1HHIvavby8E6PWRvUAowO5LydMvuJybz/
         7WvE5+dDlLD06cutZmznI0EMPfmh3ljxhi8+D5HkCiN1dz67LZHXaZFnaIsm/dX1UbH9
         gPJfMFyc0hgI/Q5y/1g/IEdTlJ3W0EgciZa006Qa1AydluTKYbfg4xHbVEOthO4oTxZE
         nCGg==
X-Forwarded-Encrypted: i=1; AFNElJ8u0queausa75LWeiWYg8WzG5VQ+h2/8wEJ/kXPx38aIbbgpkQQpq1jK6USCaELBDR3/mBihuC51JYdNWcA8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGXsy1J89KqFLIOosjGPJxaw4uMNzw5567jfbaz4+u4hXyzM0
	7ts8MGnGPWeTVuinB8UFu9AGet9bEEMhkdLYHQUvzK3cStPIdD1iQCu8q0A1FbNjio4=
X-Gm-Gg: AfdE7cnaLVKILtxZH/aLFu4IyhbZtmuV+hx4bbU0wshzJGdlRnqghUYhBu7BrpGaSRF
	BMo6Eq8OYFO+grrPXF2kXdaM4xfmfXYuNIRti3GFzBf6BlckGBMVqdc3z9erODTiyFrRoV2I5le
	pdDVXRZmXT0pFsNTE5qrSLpzJnrOqHT/AVfId47vc+AdJOrrmrGizafcMLbL4+DO4P0VXXS2CP2
	CxBC3vfBsjwTcijVgGzNNvBeWv/eY+TogDDYUPcnBGgmcElqq2OQKf7GtvgPgdLlAh059K6496i
	qC3//SxJweX5CsrcElTKNMhd7YgEJN22g4yHCLzktjJXLXrwbr0htyEI6L4kZDy9fhVQQcG33Zc
	one0eLm9TJUHuaJr+6aytgITpXIG8YZ8eL0qtopxxv4pJawXQwYqp/YEs/yBD4EuH9xGeUYjbMF
	0buQON57QOaPkEQ14nqkh7/sxkXcZzjBveia/dzNMyA5OSD2QczaT++aApqIzC
X-Received: by 2002:a05:6820:1387:b0:6a1:64df:7324 with SMTP id 006d021491bc7-6a39bbfd632mr4305539eaf.7.1783958896489;
        Mon, 13 Jul 2026 09:08:16 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f6826sm13314669a34.27.2026.07.13.09.08.15
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:08:16 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-44aeefa1c00so70411fac.0
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 09:08:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoLWBjBtJ71w99PJIgOQTulhntkclE/s5WDAyHP74xh0nQRBcxRE5qZ8FZHPNFp+oLtQc1HL5KDMQgjlz37Zw==@vger.kernel.org
X-Received: by 2002:a05:6122:6310:b0:5bd:a2dd:60ee with SMTP id
 71dfb90a1353d-5bfa470c003mr6470720e0c.3.1783958447155; Mon, 13 Jul 2026
 09:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 18:00:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUhiBAcJ6P7j0ZxL+0AbVqz88PMo7YX9UiYOK8jM61D1Q@mail.gmail.com>
X-Gm-Features: AUfX_myKEIDnT9gmvoSHxK3o8Be_bh5PlIka-qGq00orZWkHqkcXT9vOA0tXJpw
Message-ID: <CAMuHMdUhiBAcJ6P7j0ZxL+0AbVqz88PMo7YX9UiYOK8jM61D1Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/9] Add System Controller support for RZ/T2H and
 RZ/N2H SoCs
To: Prabhakar <prabhakar.csengg@gmail.com>
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

Hi Prabhakar,

On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> This series adds support for the System Controller (SYSC) blocks found on
> the Renesas RZ/T2H and RZ/N2H SoCs. These blocks handle critical low-power
> management and access control functions.
>
> Hardware Architecture & Dependency Challenges:
> ----------------------------------------------
> The SYSC in these SoCs is a multi-functional block responsible for:
>     - Clock & Reset Control
>     - Low Power Management
>     - Clock Monitor (CLMA)
>     - Access Control
>
> A key architectural detail is that these SYSC blocks are physically located
> within the CPG/MSSR (Clock Pulse Generator / Module Standby Software Reset)
> address space. While the CPG/MSSR driver is already implemented and
> functional for these SoCs, the integration of SYSC adds a layer of
> complexity due to a cyclic dependency:
>     - SYSC requires CPG: The system controller needs a clock to operate.
>     - CPG requires SYSC: Access control registers within the SYSC contain
>       bits necessary to control the PLLs managed by the CPG.
>
> If implemented as a completely separate top-level system controller node, we
> would face a cyclic dependency between the CPG and SYSC drivers during the
> boot process.
>
> Proposed Implementation
> ----------------------------
> To resolve this, the SYSC blocks are represented as child nodes of the
> CPG/MSSR controller in the device tree. The SYSC regmap is registered
> directly against the CPG device node. This hierarchy correctly models the
> hardware address space while allowing the drivers to share resources
> without deadlock.
>
> I am sending this as an RFC specifically to get feedback on the
> implementation of the SYSC as child nodes of the CPG to resolve the
> dependency cycle.

Personally, I am not a big fan of subnodes.  I assume you are using
subnodes because you can register only a single regmap per syscon node?
Would it be possible to just extend the existing clock-controller
node with two more reg entries, and expose them through a single
combined regmap?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
