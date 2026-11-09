Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794227252;
	b=U46FoCQlI19C9DBqbSNbYYilYF6+MhOF4/rRWPLpthUcZD/98uuVKGCviUAh02M/MLmT
	 WMKdHamBfSU4MdH9902IJfjzSzFs/M5sCEhVb9WF3AlPnXr8nNirF+lQEYmdJvHXs7ZbV
	 phnNUOZnJMKBiSZYer3gXygAj6R4HNh8FnqULjKQLSKoQ4vCkDVK5XChOktboy3zSxQ1h
	 j+Wv3tU1K4zBkSpYxIC1Scthhy/4Dd20IrvBbJR5AvsWLp48WCrZufoVQQV2t6UgWbDfI
	 BigvDQq6JVUCNbHaNDtQl8acU95Rj/YjBX9knP2dMrypGuhy30CRk4Zwxq9aga1xUUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KRuHgKKM/Ft7bPONO48ud8NMa7YtAiG1oSVTdvzPD0g=;
	b=u3jZQ6h2RwwxDuT0oRcT1yiCguALr4pu7GkPFVevk9aPB23kIGWAmH25Mbolud5tMTVb
	 MKJbZxAIlvEgUKnXSclBvxCEpnDLw8rdNhHuiwLBCV2+DnaFPPDWOLugtwq1QycQ4fAQ1
	 e9gdWmJoVSFUaQ1UhjLH7gMaZxkPows3SkevhB2Bkk1YNTYlz6q1BkdYOfeoMUCAML2ux
	 q9tdWxxner1FGKlVQ19V1+90BuNk3+LhLBZKDKfzkgBnXKMyWPs+Sj+Iy4iaZrfPyJuBI
	 YiftQ4Mnz4NWNbBsnzT9Myr/mlNrNUQ3CN7X0SQ87ZqN3O/FAGaposwGJa0VvT4yfLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QOgyhbeq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB3606A338
	for <linux-watchdog@vger.kernel.org>; Mon,  9 Nov 2026 12:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CFB3606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QOgyhbeq
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so1152694a12.1
        for <linux-watchdog@vger.kernel.org>; Mon, 09 Nov 2026 04:27:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794227250; cv=none;
        d=google.com; s=arc-20260327;
        b=aeca7bxgW3fA4w3c0MBeVNhSS7ycMIfdy5IebJPV2HE8U2NlTCzwjVgsGAbLvqA4Dq
         CRn0RSMTzekou4QzKW8I+dXPV4YIYZtb4Pzr4sFr+l7knI5bjy4xZ3EzFf/jZlEngdyl
         RRckVrxyQFwX9tQthOcLt1tjmd8lNedOzPVg6PvJEWSzVd9jObP0peNUQ9ML/lselFBD
         /AAVwIQjaaCSc8BPjGnpAexOqNiz6OMM0m//Kc3bx7jE1rD1c2IMbkebm3Xez0Q9J7tj
         RBA4xGt5nORRWI/E8egsdtKmMzwbXBdZIiX2aQ4UbCQ82pjSD5vtbeHVevM0AybfwPNQ
         7iXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KRuHgKKM/Ft7bPONO48ud8NMa7YtAiG1oSVTdvzPD0g=;
        fh=mn8JyUwy8B/1cl0YabDMRgtKtURg4mj60MgrlLGi+ZI=;
        b=K357ZME0tin3Kzl1Y/eCoRs+TgNj4mX7Dyr0WZYimGO3eivCr7EUivnr+1Sh3W7+98
         8UAvV5dLT+5D2kVLXU2MqS3mC1qN2IqtHVQ61de+XLcZF0TEs0VKQ/aYzAEMQkR0vXtl
         8QxT0uqh9THklrBPGWeNLYmf+6qhHq17GOr0kUbt5pT0f4dwKrgYUtshHqpN7iMgqK5G
         77UGFnWI/VJV0IEyPXgeDop6ShCrbCVPinyj0UM3pOoF8vYtZwdqfjYqzt8jggoYv0U0
         8pubssApRssLwkaiF959qomVZW00IpoyS4I3+bLuxOcVZjV4UTsUXZBj8UeXXDs93VlK
         mmHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794227250; x=1794832050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KRuHgKKM/Ft7bPONO48ud8NMa7YtAiG1oSVTdvzPD0g=;
        b=QOgyhbeqOwd2Z8XLJx9wuh00POYRhyJMgoyTP2JMbJJZZwVnt12qxlUpcwNXgfG+pp
         JaMwEbHHzfXgzSVYNUUjUGAHM4w5gIiWjKVMo79/N4Kp7/QNLp74fZlfCscaySJbfldb
         xQdArFs3VDfGTOs1UtGkxdrVHUOFJ8um8haAtZ9RIzulS0FS+QUM0zZPsQpT63l+ktjO
         SVICn62kPn36QNCk9ALNSp6FdvD79vNG4ObZxi9TgEboX/0B+2bu/ByYWc9nxsh+fkt6
         CmD2fpaF5ijY1Cz96O8VMTE4HMTAPlOe0mt1ogz/3/yMi9wqTDx+W9cVvmqfelt/BCIs
         /rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227250; x=1794832050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KRuHgKKM/Ft7bPONO48ud8NMa7YtAiG1oSVTdvzPD0g=;
        b=YXBPsUZJmGgWVqGJ62m6FBr12fUC3pzxyaC3iypFAS5XDWmPdLYVAus0+kGAD/rAC7
         g4EN0usfbjoQCAy9/OHPZ5ghhlCVxrJVsOYaGbwTbD+RJ/XguHAx5ScSosfI05lT4eH1
         FUbxzF16c523Dn5jijTnprZun1dvUDdI1ON91Sq/ISGjfTj5kWb+eVDF2jUh7SCfyRFy
         WeadWgUY3BfzGv0WiS+MoLtfenKphCwHbCxq/B76RYgP/1TiV1cGXJNxVwTj8eOk3Cnh
         xd+Om0/+T1sxJli3dgakCx/cmjl6lC9wzMgaBmbWMTVCt8ar9aCuW741P2aWNxXi8oVB
         lU8w==
X-Forwarded-Encrypted: i=1; AL+hErElnV9RnaDtIFhFTUdx6rT6mInA13q0M19GawudE3HSt48uYTHrK8kEG56PLfVCztXpoXNiD9hqNlLnH8XmDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+hashkMUiw3Z39cvbHYuJ4JmqwBsH8FpdMW93j190zjEKjLQDs
	h/Not9QpZHPyENdauCUjoK1KOalsf44mVUBe7m4h5IQQRnyZHfzuAd3KuO5dw9UW568lHfAxob0
	0Sq5Phhecy0E6yu2UI+nBa6rtmj7A4+0=
X-Gm-Gg: AYBFou26lukNQcrscmWHFGkdKkZ02frJVbBpfVmj5O2I7zkM7AWhztn9NKpG0weJvu8
	hdYdUudU12IDY/buRQ9UWQVxQoJosLrTiNLtvotwWebs9l6aSJQsHp7vIC/Keka1+7rwHek0ZBO
	ntgf2+rZc7VgTx+ktEMwS3UtWZojIIyq8yGx2JzXjkRLXSe915gS3NiFbivWgNRKQtv3gGD/2ak
	8CUK9bBJnJXlrkWjybaFQCCEOg+c3f4avEk6kQzQGuubWRVDQp227UGNTnDKdaYU0Ednu/U37DU
	fQitWED3bHSHkl2l3eazL2iqAPlgEXZ9f4vHvkAKb0kefk3/lDWXx9v9napyfj0Z9Vv9vdsZr0c
	GNrcefgFHusWVidTBbpQ2JKzW3mnOMbd2lRCu6J99EetZAxua4g804uahTSBG3Fbj8HYbxoi/G+
	GPQa1/ojiavy4qq9JpeR3g8DBg0y1lWzowBcYiwfk7aUHwhLjQrSWN0UnNrlE=
X-Received: by 2002:a05:6402:3895:b0:6b7:8b1:aa79 with SMTP id
 4fb4d7f45d1cf-6b7223c1832mr2314095a12.5.1794227249763; Mon, 09 Nov 2026
 04:27:29 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 9 Nov 2026 12:27:03 +0000
X-Gm-Features: AclHuK_ZRUUlCMH4HvENtZrOvYlrEIYJCdD6Zdsj2qnZgU93aq494AwRB7CTooo
Message-ID: <CA+V-a8u-3NFryZA_8GN=fR09+fcyvNGLMV-09z-mPXTePxkgvg@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Add syscon support for Renesas WDT driver
To: Geert Uytterhoeven <geert+renesas@glider.be>, Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Brian Masney <bmasney+clk@redhat.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-renesas-soc@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, Oct 1, 2026 at 5:52=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.co=
m> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi all,
>
> This series adds syscon support for the Renesas RZ/T2H and RZ/N2H SoCs in
> the WDT driver. The WDTDCR register is part of the CPG/MSSR block for
> which the CPG driver registers SYSC regmap. WDT driver now uses this
> syscon to access the WDTDCR register.
>
> These patches were part of two seprate series [0] and [1], out of which
> certain patches have been queued separately, so I have included rest of
> the patches into this single series.
>
> Merge strategy, as the WDT driver now includes renesas.h header file,
> the driver patches can go via renesas-soc.
>
> Note, patches have been rebased on top of next-20260930.
>
> v7->v8:
> - Dropped patch "watchdog: rzv2h: Drop enabling clocks in the
>   restart handler" addressing Sashiko's comments
>
> v6->v7:
> - Added a new patch to introduce rzt2h_cpg_wdtdcr_count_start() function
> - Added new patch to drop pm_runtime_resume_and_get() &
>   pm_runtime_put_sync() calls while accessing the WDTDCR register.
> - Dropped propagating WDTDCR access errors.
> - Dropped converting WDTDCR handling to regmap as this would require
>   resource address comparison to get WDT index to call
>   rzt2h_cpg_wdtdcr_count_start().
> - Made use of rzt2h_cpg_wdtdcr_count_start() in restart handler
> - Added if regmap is available, use it for WDTDCR access
> - Updated commit message
>
> v5->v6:
> - Used pm_runtime_put_sync() in rzv2h_wdt_stop() function.
> - rebased on top of next-20260922
>
> v4->v5:
> - patch #1 is new addressing Sashiko's comments to avoid potential deadlo=
ck
> - patch #4 is new addressing Sashiko's comments
> - Dropped checking rzt2h_wdt_wdtdcr_count_start() return value in
>   restart path.
> - Handled the regmap locking in the driver and introduced nolock
>   version to be used in the restart path.
> - Added review-by tag.
>
> [0] https://lore.kernel.org/all/20260817192540.423994-1-prabhakar.mahadev=
-lad.rj@bp.renesas.com/
> [1] https://lore.kernel.org/all/20260814191415.2110732-1-prabhakar.mahade=
v-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (7):
>   clk: renesas: r9a09g077: Add helper to start WDTDCR counter
>   watchdog: rzv2h: Use pm_runtime_put_sync()
>   watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
>   watchdog: rzv2h: Drop runtime PM handling from WDTDCR init
>   watchdog: rzv2h_wdt: Add syscon based WDTDCR access
>   arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
>   arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access
>
Gentle ping.

Cheers,
Prabhakar

>  arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 24 +++---
>  arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 +++---
>  drivers/clk/renesas/r9a09g077-cpg.c        | 35 +++++++--
>  drivers/watchdog/rzv2h_wdt.c               | 85 ++++++++++++++++++----
>  include/linux/clk/renesas.h                |  6 ++
>  5 files changed, 129 insertions(+), 45 deletions(-)
>
> --
> 2.55.0
>
