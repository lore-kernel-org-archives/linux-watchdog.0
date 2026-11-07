Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039503;
	b=m8NeBxNEdnGUjMLlqtiQb5/yPItvnEyJdPmfS1ksCXqtHS2E6jShqGWan9am8jKxLs7n
	 OFrmwEw1siB6n6Ulr/udcPEQgnog05fAS6F7pzL4DRnKWi/JlIXNypZrmJQXfLOaIWz7b
	 YDHT6Se+lapc2y/839bxML1Q/BgWarBCqTLP3MLvIzgJtJ5ej7nxKi+JTO+eIrH+O4McS
	 JumhK9mA0lQG74I0sd0McjK2K95qkg1jv2X8iUoJfP3w3CF3m7wmRLiwoQ0czNj/XvfPV
	 +aCKjdbfhS40dh4o+Li/Q9KnS/lQ6iOmoeQrtpEKcZQI7zyw34bknTTXhS3M55mR5Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=An1bRoE/6CxmwaSRosrMArcH/TfHD3aBe6vo4ktdg0I=;
	b=VB3D9MCoibxR1Qm7xsQQp2ieq3XfoXCOP0ltJixQkeA1heKAKoRAdzYmmLBqMQdeypRU
	 cCSxrRtCev1YnwX0h+AygNyDbp6TowgkvWyZUSrp/qdXm9QiVJNZ60/6hr/IjRKq4kE0l
	 LRfqfUROPFCQI7VsTRkB6C8CRiApMVIv7Dv7DKpeJP9SdyCm3LzgVm+WqQKJOvp58UtwC
	 x6BmHFkU3DTKe+ldyXq6tLcqE5Nq88mG6Ka2oofuGIY+OWFlzqOBGsnbsVw5sdjJbjwqd
	 U9jEKkTGTlSr8XXE93eLjEm4OMYXeyO1I8qrDCIIlDjhTAX6lJipcn0sKQafJJE3jkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uUdLLuxy;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7F606A326
	for <linux-watchdog@vger.kernel.org>; Sat,  7 Nov 2026 08:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B7F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uUdLLuxy
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e940d5d2beso4771815ad.0
        for <linux-watchdog@vger.kernel.org>; Sat, 07 Nov 2026 00:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794039502; x=1794644302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=An1bRoE/6CxmwaSRosrMArcH/TfHD3aBe6vo4ktdg0I=;
        b=uUdLLuxyl3UJP4spFk3NxgQpmrV3TmK9yeFUh1vl5evvBlg6C5YftzRlsdtpVUqUAL
         VPwKMdFyu4VK1c5tKq8BWJQ/IrK34OvioJHOCG0eqvMUASiYSn985yNhimije8kbYFC1
         3ATGnIJnKzT/V0igv4JRmNc3IjiAOUyD64Q2ruQVvdcyYFLRgNIl3o+soZ9NhK7zf0tg
         NQ67e3pwL4aZszws6XccLeLQAyYDC9EdfD2oxlJ7uZRR13Vd3SipU6b6R9En4o+yQwrG
         78Z3yJtteRvnYajuzqPZnJFQdEEjaqRfEZ5WAdcYmDpNkukpza7aul36o6VZBbUDh2Sz
         Sv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794039502; x=1794644302;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=An1bRoE/6CxmwaSRosrMArcH/TfHD3aBe6vo4ktdg0I=;
        b=rkIzw7wR61mniQvpBNY0FTw7NXYrG04oO3ZvEFdK5YumBcK9mYsgbjBAg7k3wj61Vy
         Tvi0sxSfQpRmjkBJb2pwOJ4pUTmDN6dJ7d7cOvIfC21jjMacAFYhe9dKUohgHRlHtBoq
         A11bG7pHtFYbbwFq4wFiLEWDsu1bz/FCPBTezmPiiydrU8CKc8JL/kSAuoW8K2u/Qccx
         yaR62APntMONVUrDkvlCmRsKiFgIuKstqtpHcg3ipE1CQCIs6YmqEuECRChFO8DE2eTW
         bIcVw2f0lknGC2op8Sh0vPR/DrKZ9NJt5TOgtYmKnSlQnbL6vy8jyHyqb99EMDZmuL3D
         zA7g==
X-Forwarded-Encrypted: i=1; AL+hErEYpS2ayjrX0JpsT5pqSPIpVZDdOcEflhUksEGQLcGOe9jeqKf0FqCLvM8mZ0l9BlNM26vdfZAvnhBDI56GIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+lAYWUzAyN5Kb3Di39lAkcqfoO03HIk+3CGKWLbh9B6zL+uE/E
	0v8PUELp3lJXz986wlv8Mb8K2KVDSOEu7ESEwAFkG+LwVnM1FAjL0A6w
X-Gm-Gg: AYBFou3uQPHNwyqjetuizvoYNeRY4gnh35jvhDuy5TuOBUlr+VVpU0JjuxHLoQmNnPU
	0dkp0T8gND+4AUqjlVFI1VMy89sLtoskpzMlMOao6CSbQjLB5fQulRA2jGRi0W7enseuQzBtRXP
	rNnHGzlzgROLi1S9fNm+i7vYtDo7Jor4mtyz/m/oXfW1rNeigtHU7U4D4EPAQs1tvotnusneHMR
	9QxJF42maHY+lW4rAy3ZGMNilnuSSgmKOObsK04DQ6t94jx9yxJCwJx/t9OQ/tH/GhF55U8Ut94
	GvPr8Iqolc6W0amecOIEx0xC1GldKNKtcHubezkMs/K00bcOVSueLrY8JPjQ8aedduYKovJY2hp
	FvIveBktSeazoRLwINtvn4WdcDmNXWupv8Iu6fQFx0EEXsOBtQFxSRbSeOu2Y/VeSunlRuElBU0
	4Fpy6NQreAMeY3AOOOstE8/aBqPQBDpv+AUubDNLF936ECeBEvGbea08+pXT0qS60ay0bgWsG9z
	Wo/K8B8IgCYSTLw/5B4f6mJH+dlTNEJRkq+eshjeUugbJIyMshumiTbYdL+pFUNThHObjRMt9VX
	/9vJ2tOPtJTegvST0w==
X-Received: by 2002:a17:902:d48d:b0:2e8:1c7b:3b6e with SMTP id d9443c01a7336-2ed40aca726mr55809015ad.26.1794039501791;
        Sat, 07 Nov 2026 00:18:21 -0800 (PST)
Received: from buffalo-ssd ([2a09:bac5:45bc:1e1e::300:1a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47528e5dsm11943395ad.4.2026.11.07.00.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:18:21 -0800 (PST)
Date: Sat, 7 Nov 2026 17:18:17 +0900
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Alexander Letuchiy <asalde.le1@gmail.com>
Cc: Roman Vivchar <rva333@protonmail.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6895
Message-ID: <au7UMdlP9O6oo41i@buffalo-ssd>
References: <xUMh3NwVp4cBhFsWWFE2Xng4h8YH95iJM37_I158WAyVmsRCPbirWT1iU8eMFeiSFw8xco0X45o-2NOeB6Jc4_nWAg25pFPgDMwK3mKzm34=@protonmail.com>
 <20261105222435.571449-1-asalde.le1@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105222435.571449-1-asalde.le1@gmail.com>

Hi Alexander,
(Resending with the Cc recipients I missed; sorry for the duplicate.)

On Fri, Nov 06, 2026 at 01:24:34AM +0300, Alexander Letuchiy wrote:
> On Thu, Nov 5, 2026 at 11:50 PM, Roman Vivchar wrote:
> > Does mt6895 actually share the same reset layout as mt6589? Given the
> > generation leap between these, the former is very unlikely to use
> > the same resets.
> 
> The vendor kernel for this SoC binds the watchdog with the same
> compatible list ("mediatek,mt6895-wdt", "mediatek,mt6589-wdt") at the
> same address, and its register definitions are identical to mtk_wdt.c.
> 
> The TOPRGU reset layout is the one thing I can't confirm, as I found no
> reset table for MT6895 there. This series does not use it: the DT has
> no #reset-cells and no consumers. If reset lines are needed later, I
> will add a dedicated mt6895_data to the driver.

The MT6589 wdt driver now also registers a TOPRGU reset controller:
f12d5facded7 ("watchdog: mediatek: Add wdt/toprgu resets for mt6589")

The driver now registers a reset controller with 12 reset lines
for the "mediatek,mt6589-wdt" compatible, regardless of whether the DT
specifies #reset-cells or has any reset consumers.
"mediatek,mt6589-wdt" used to be a watchdog-only fallback,
since it did not register a TOPRGU reset controller.
That is no longer true.

Since the MT6895 reset layout is unconfirmed, it must not claim
compatibility with the MT6589 TOPRGU reset controller by using
"mediatek,mt6589-wdt" as a fallback.
The compatible list is part of the Device Tree ABI and cannot be
changed later.

As I noted in [1], "mediatek,mt6589-wdt" is only a safe fallback where
the reset layout is known to match. Many SoCs do not share MT6589's
reset layout, and MT6895 gives no reason to be treated as an exception.
We should not add yet another MT6589 fallback whose reset layout is not
known to be correct.

Please give MT6895 its own "mediatek,mt6895-wdt" compatible without
"mediatek,mt6589-wdt" fallback. Its TOPRGU reset support can be added
once the actual reset layout has been confirmed.

[1] https://lore.kernel.org/linux-mediatek/xqnpukvhtezpqhwjnxbqeddiaqlro4m5yjukpplv5mjfxodlfp@ijaf2trst7p4/

Best regards,
Akari
