Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853655;
	b=L4Pum+kYW49MrHJUydPVqlsw0HFiy0R8/hF4vJD8HAv1i7ezePvqa+7rhUhiruz1l+6x
	 L/m0INIbvjqrvHaPt/lKVQSpXqA994lxy4ced0+0ghrxFbmnd1VCHo6HUxjBnIec7Mws1
	 hBrfA9g53DWtJ0cfEmOhNIUWwHg9IlddnbwD/QiL0gUojcWQfcaBVL7OM8clWE8bT77FN
	 nAB137GZOOL7k51d9dy99tvhamBSAqg25vICRNon/m3WzeSyUWba5nflolIuknC7RaIKw
	 2qSjQXARWo2o94X2/jPrNdXHLckspiq/y4B33KgHMi4wnvgaK4mO7ejHlXFZO7maHsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853655;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=CBeoOPO8dQa32q5FSGLVAtCrcM+vnK3M9abEc4Baae0=;
	b=0QljsOdqTNDNm2PY0PLUx7jPJGoH+qkzlmcokE1TYkWKzN2GDVSHBe8H3+QBC2dwBx3K
	 X/ET1Dy55/b2tXh31FRj4dz89d2x3vjJGYIf9ViTEj35BmDG4uDGn0EZkKVNLSVPHMzL/
	 PGFQT6jvkrSZkGmQGCcHB9rNXPUnFOQLgaEsJsStKgmW3Wa3YoM2QNF3xgzm04VzdIIs9
	 CnkTyB5NoygWy4kJvHMe4e9uP3nxW4MaPC1eeq55122J6YzDS6r8coHgUrJntQmPcuKsh
	 sk8Ti6rc7YHBjUKFofHMOdm4PoJ5uyqaCg3sZV3Msx5fuDIadLO3eFomuZ4c6AoqIjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=A1fBFSva;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F92606A326;
	Thu,  5 Nov 2026 04:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49F92606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=A1fBFSva
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AD9C10CB4D;
	Thu, 05 Nov 2026 05:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793853644;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CBeoOPO8dQa32q5FSGLVAtCrcM+vnK3M9abEc4Baae0=;
	b=A1fBFSvaKLE0DyT+bxS1Ujpzu4d+5B4Pt4QckCyU1hiNxg0Jlp7tALCny2Hy9XMx1Atdr0
	AMZat10bqhdZlicSBgsTSXKcMGZTSVecu1xe7J2uPjIQ9oVFzuxPHJWRycEM7TyjHPJrhQ
	+Bsf2Xqv6bA5mEumyAriNrD6ptMOrg7DCpqY5nggDXyJH6lwZZHj8J0DlFHSctrhkhSgtR
	AKGznxomoYij6awZBUeXzl//bo/HJIYvZTtb6cTU0OmDJg1Alpv4h/h4r81DPCs+fzIZoh
	rhoVpOJxdYZ08MB3iGEI4Th/AplO0vttGwdTydwuS2Fg/1LOb/0UVLh8Oqlmcg==
Message-ID: <14f72896-3c52-45ad-9832-6f33cb4d8c00@nabladev.com>
Date: Wed, 4 Nov 2026 17:47:09 +0100
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] dt-bindings: watchdog: arm-smc-wdt: allow a list
 of SMC ids
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: Julius Werner <jwerner@chromium.org>, Evan Benn <evanbenn@chromium.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Antonio Borneo <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
 <20261104161553.30115-2-mateusz.nowicki@posteo.net>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261104161553.30115-2-mateusz.nowicki@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/4/26 5:16 PM, Mateusz Nowicki wrote:
> The SMC function id of the watchdog service is not discoverable and
> differs between firmware versions for the same SoC. Let arm,smc-id hold
> a list of ids that the driver tries in order, so a SoC dtsi can name
> every id used by firmware for that SoC. A single id stays valid.
> 
> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
> ---
>   .../devicetree/bindings/watchdog/arm-smc-wdt.yaml        | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> index 8e9d0b7e8244..9844b23ef51c 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> @@ -18,9 +18,14 @@ properties:
>         - arm,smc-wdt
>   
>     arm,smc-id:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
maxItems: 2 ?
