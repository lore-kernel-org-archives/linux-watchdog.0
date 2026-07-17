Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3E2F6591
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302740; cv=pass; b=KXQQqZkKTfrFseM8otl9kly8pyqubgRcDgep2ioClJnD1lvsVEdTFfuj4okyurUFyvmTma94a3fxthhwkwdxQnxNQzqEKICoaLqaxEHjyMaA6NeXrm0Ls/ZIAZgEjsx/3O/gmzA44vDhWRbfDFmje5OGll2hRV/8cGB4PczLwQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302740; c=relaxed/simple;
	bh=jhrpYmMFVx06rokjDPKklo1tN6B0jx/vPKzFLz4wuMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruFEfn/F4XYs5WdFeYLg2Jx9MF3Psy+SFyxr7PK9N5bUw+lqHhYV7pWx81DM085ysT1/c0CmuicRvqwcbViujajscI5oeqQ14p/RYE5L2i/I+e8w8xpLvgeFoNPTiVlqWNq9FV+q6vLC+As7TnzbobyQUjPKQwVWTDAjKty3MzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1npArxw; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1npArxw"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c167c58f2so61405401cf.0
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 08:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784302738; cv=none;
        d=google.com; s=arc-20260327;
        b=dLUTBuyc9fRu7noFOOsO2wwxvTwEhv3gJL+3+RrDAExnV4N1P2STLvtfNfg4pdaThn
         6P3aheBDW702RHynAurFR3nN33sw8lw9xzDXy9m8MAxpV4jHh8jmqrjrYr6l0x38C7+h
         6E0om8AiukcglOswZ6wxIYskmPn3O423KujEF5xzQL9O27NDmkxqmxoUm7FyaLMyGUJF
         JIl0WKcFpW0lPD34t580Q6td5HkFkpjzOQbdBzfyfiGdorzBMjajjoUA0kn3XC6QQ8Dd
         e5IT6gNf7gaAyMwA5wwVkfk4p43fgg27JZtoWR63SnwMSbiCTtIeQqkyoZC5kFec9Xz/
         pA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jhrpYmMFVx06rokjDPKklo1tN6B0jx/vPKzFLz4wuMQ=;
        fh=KStcq/BLMUNHsPQJdAok51lGDVgHi5djzN/H+8S2bPk=;
        b=fIJKc/54Husrxr14LYNoDtaSPUiZgoWNQBQzIGoTlQUKfAv8pJvpvy55/p4kvwoxl2
         9VKvAbaILQEQjqNx/A4ksFYtV5H8wcvT8blpj3XSuyBI1uHPCYnB/+1STvVEnqkI3FvZ
         1gzCEGVY5+bIZfo0CPftLf25GUjHpHlN6eL82p/uNvVK9xlKXAn47NWyyvfmQCeFb5vK
         atLJWLhTuI1hGLYGuPvfJgoG4UxcXX4F9a+TqC+HzYVnIxBFPa23eMg4w+/cOUyJqn4q
         kbpwDlLFQeEsqr+EV/7jA7nnv2SEcIZFGM9aqy5iBGEqajSp1Njmhny88iXWjbmIGWtJ
         BAbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784302738; x=1784907538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jhrpYmMFVx06rokjDPKklo1tN6B0jx/vPKzFLz4wuMQ=;
        b=h1npArxwpua28NF76JLqrTrVuJkPIosil3Wx6assNObWgbBuAD719GHm9wlhSFMK0A
         eRDK3mdQ7kzoOkdzsHgTrUX5I0FrOo2HjkUZyaAACWjIWNpDPXyNjMGysLuzyx5GA7Mb
         H5LmkpcAd+Phj0Kwy1lTlscMaR8nzuHW5gSdeIZ662VsryWt2fiO5ofsxmAPuhTP0w2u
         rFI+kbnM1d0CYblUQ5dY4yJbWyWMYO9xkeQGT/sSgUsUTVg63OTenZMs6VllsiW9CMXK
         2CcfrNkHCS6QnWyXvMRpf65l72YtYh6TCaikCqFhLrTLog/uSmk9Tfl9cMHzJNF03Hb5
         IQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784302738; x=1784907538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhrpYmMFVx06rokjDPKklo1tN6B0jx/vPKzFLz4wuMQ=;
        b=FWGBzvUPFH9ZNXYavQWSBU4JEOfeQfGdhkI31NdE/KmPORCWEjeg+j+TMHp78ALmUt
         jsMfPmiwxaElo57s/idg3Sw1DWi7u18fCryt+CTw95QgMnbpagIv7u1G3QwXjBDEHTOC
         CLRaP1VmcZMJMrIWKh0rJtuHTxkn8uAv+KMelGVtu0Hv0kJeZ10A5RhR97CksOblcxNu
         1PPIpL1dVRU+FmGdu2LZwKriNDt+0Br6fz0KWFfyDnYmCA4aMZeBVXXJmab8LBjm1oJU
         uo/4En2LwFyfVqPkqSv7P9fPmnLWNSX+N2c+8ML/MzSxIJwe5b2/i2U4DJDgcxXeMNiO
         QSUA==
X-Gm-Message-State: AOJu0YweHuVUuGUfZh23UREGim9G+qtRf38DF3750yZHKaJpFnnsTIPd
	rF662ms9WDeU40KJfA0T1Ji653LuktiHnfqOxOBadxss4yCZedjbMfN+bRP6vn6P4ibwT4vlDUB
	NAxFOpUKU72nrHypz0aLUL3ZmbZ0zxvY=
X-Gm-Gg: AfdE7cmB1z1iMnAJwpLUhBI9Zf6oZAplgL355tHrl2ZXyzh7R03v8TZ6AO6QKGhzNNZ
	RbJPeJC8TMkS+QPRhjGU59hUZp3sjdDwuUjRvQ8kZW2jrhPNimddXUPEPjJR223KLFoh6UGOpsE
	D3swaklJh6pKiRZoeFguqXmL4MC1pZTyHGQ8dLw9Fh701Txo429X1KpW5vTejRLaSySp/1Ph1lH
	Zmc5e+czuRiV6ZONK88VnGcFoNwe53qAW1MYA3vfth8RnlffbCflmHlQE6cPBwkAcslkTf8X73z
	MBu6
X-Received: by 2002:a05:622a:5d1:b0:51c:bfd:772b with SMTP id
 d75a77b69052e-5213ea80af2mr28037441cf.65.1784302737601; Fri, 17 Jul 2026
 08:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716161923.266315-1-akkun11.open@gmail.com>
In-Reply-To: <20260716161923.266315-1-akkun11.open@gmail.com>
From: Akari Tsuyukusa <akkun11.open@gmail.com>
Date: Sat, 18 Jul 2026 00:38:46 +0900
X-Gm-Features: AUfX_mwBl3dquzxsUOjYfNF9eon0dxcQ4kYle5GNTVWYorRVVQ4G71Eq6B_eMk4
Message-ID: <CAKr_iV76upuWauE-ad7ds5W+jA_aSCkCGsG4oKqC8KNQBG=JGg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add reset support to MT6589 wdt and remove fallback compatibles
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Roman Vivchar <rva333@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:19=E2=80=AFAM Akari Tsuyukusa <akkun11.open@gmail=
.com> wrote:
>
> This series adds TOPRGU reset controller support to the MT6589 watchdog
> and removes the use of "mediatek,mt6589-wdt" as the fallback compatible
> from many other MediaTek SoCs.
>
> Many SoCs have been using "mediatek,mt6589-wdt" as the fallback.
> However, they are not compatible with the MT6589's reset register.
>
> To add reset support to MT6589 wdt and resolve this problem safely,
> the series proceeds step by step:

Better patch series is available
Link: https://lore.kernel.org/linux-mediatek/20260717151134.678839-1-l.scor=
cia@gmail.com/T/#t

I'm withdrawing this series.

Best regards,
Akari
