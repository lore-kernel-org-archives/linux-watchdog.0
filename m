Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E853EF66F
	for <linux-watchdog@vger.kernel.org>; Wed,  6 May 2026 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088653; cv=none; b=duWrNMkazB8XMo/HPOIxNXYfsjLA6EDejxrbSH0G0fScopO65NP59l3nxyclvlG/kLkjE3KeSCmKf2YOlIcqPL3hQJPhyS4MAwgjOOLV02c4g5FWK0ar14Ru4As7Gc6IaE6wvnRjS1ai3RJzUVgUOwLQL3/d/7yRqrUKCzujHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088653; c=relaxed/simple;
	bh=4Ykz0ExoUaMMR6EC+daSv9XmEUawcxqmyTTi/73hV1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxFHd1DXMTGPnHDGCdBbGzR0evHUGwb92v9deEB/HT8/GHuqMcPS02d9ojYh4X8bWB/9TfcqT4AHTkVwMR7cz45Cu9vsYIEwsg8TnuURcIHIrYAnHfN1EG2FPRvvurcUNYLqEpe9GcCJJ4rDjEb8XkPU0kNTB0IriUjkhbEJyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnbCDp+r; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnbCDp+r"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so5291352a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 06 May 2026 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778088651; x=1778693451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q92pYl98bSnKhgO0g+LA6h/wojvjo0EO8G9dXoXq+H4=;
        b=nnbCDp+rRp1fGxgTNajKMfzPf7OM8xFbx0n469NTPtMgvoUbed2DJ9nSNlsEwWf2RB
         OKf1r/oN7uvCSm9fnQ5QLH4x9sRo5DQhHjfiYw9ybguwL6xOFud2xEFlZxRHsA3JHHdb
         qK6yResf6vSXfGcJaxkI/tAtT9LRkgLy0g6e7c8RBtVtg2cCQkYNddJzqcW1QsxQpOya
         UAAkBMOaOpfwk5BL2F7zrNyIbrFgav2qt3O7ze0wOMv/c8t14i8T7FX3u7R3BQBe8PyI
         7i/PsS1lbTwMUh7aPs/PJuaErORTJUpI/ht2v01goWC47wUU44KFxKbAhKCiss12hr2O
         f7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088651; x=1778693451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q92pYl98bSnKhgO0g+LA6h/wojvjo0EO8G9dXoXq+H4=;
        b=JMKUaPrgQ2nVGag+VubUx5Ar6l1lUJUjXGbWIIloojNWV5v4RTzco9hW2ssgcpqC1l
         cW7Iuc45Ot7Bum3Z0yUYtBk62l9ORyJxbfkqrelPKqdQw0nftOUj+/nUClXBoYyx1XLA
         A2+u+vzwsYNnkqUTCBrQzMUq9E+R1zgo5k1/xBQFPGFmFYrSkIoigqU+4BX6Jp+RKq6O
         7uwk0akrpPijjkOfMKouQS41FGMMUSWjBcE6GqU2epREGWdHFBznjXk6U42q02jFoTrL
         PDeqvpNB7D2uh6csZB15qaY6oEOl19BmtoadeYkrGau8aHDKqTUrDaXRpChKG4ZBIeIE
         Zj5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/klwjSSTLNffSOhqCYukoWbBj3HCxjrD9+JH8CZa4xKUYm5Pt/XEJzSohIW9pxo2mHvtd7Smc0+4LYv17fkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQOQ1hUKt9KxP3inpckwWZdhqfnGp7Td9TFE0ySKLLfC+4hx6
	5wRTX9TAgKAE5PYYNShkSzIAocu97g7hBDWq9fuZJ9z3f9hN7fPgIhSg
X-Gm-Gg: AeBDieuzDcqoTMbRWfi/O17Q/9HaGBK4Kw24SeJHA/oNw/ZLTiSNpXLR6egpCf7QPZQ
	LBHeJzzGEzCQZzr+L2kxzH9Aag08e795fAnjoagooLOJWXexv40T0FzDIMTrABPSDvd9o0T/veV
	9qonM8soRb5Hs5HmTxLPWR3YcG0yHcDW5CJ+H2EZgCCsrkOhdrlhpmI10SklFz5YpO2wtuOQ27i
	yjrtJ84ts+bLCatIjS82aegk0xRJhyk24A+y/IM1PRWGre1PYYxrNsBGJaRznK4PQNCq1TmZkm+
	gxhajhpJNPoXeeGRZW8g6Lr7ND3xt9mS/ed7BEbEvIdwU8rpdv5CC23yyyNy5lz1TJP37JwAaR/
	yQfuGL3VK2iWNGdEkxteUJmYBoi9mXOrGx9PjJSoZ2HrNtb2Z7CrMc8leWKEmMLPMZi0v2Gn5OI
	QwSNbm4UqzRQlNtSPfI7MxLv5FdUMO0CLYOqX10FPor69k24ytOEZ4t3abdQ==
X-Received: by 2002:a17:90b:264e:b0:35b:e553:9cc2 with SMTP id 98e67ed59e1d1-365ac89cf2cmr4261014a91.26.1778088651264;
        Wed, 06 May 2026 10:30:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365cad597c3sm1338302a91.4.2026.05.06.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:30:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 6 May 2026 10:30:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Heiko Stuebner <heiko@sntech.de>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] dt-bindings: watchdog: Add watchdog compatible for RK3528
Message-ID: <2ee02f9b-56cf-4dbe-9312-e2ba85d44de1@roeck-us.net>
References: <20260506092420.3320031-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506092420.3320031-1-heiko@sntech.de>

On Wed, May 06, 2026 at 11:24:20AM +0200, Heiko Stuebner wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> The RK3528 uses the same watchdog block as all previous Rockchip SoCs.
> So add a compatible for it to the soc-list.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to my watchdog-next branch.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> index 609e98cdaaff..731794dccd4a 100644
> --- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> @@ -29,6 +29,7 @@ properties:
>                - rockchip,rk3368-wdt
>                - rockchip,rk3399-wdt
>                - rockchip,rk3506-wdt
> +              - rockchip,rk3528-wdt
>                - rockchip,rk3562-wdt
>                - rockchip,rk3568-wdt
>                - rockchip,rk3576-wdt
