Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A43C0A15;
	Tue, 18 Aug 2026 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044916; cv=none; b=cHi6Uxjxgr/TI8cVZg55mfHpI4BtEX1ieS3D2j3RTr+JAVwLyqlNsyLxJHi4XocG5tIVY7ScBO1/95eJWmokZyFEi2tVEdnBY3BeIT6U9/CNtGJqQHlGw/RMxZXyS8JeFnXSVaSOaxIxSQQLnHwJcse0CEcC7dsGC0MCt2HBG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044916; c=relaxed/simple;
	bh=XooPsEvBf3zEKZPohOHHbOflIvlzm03/SjX8FUADtwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mepnSd1DKT76+z3ZmUNzcS/iz1+4updlVh0wYbrtZElGLYNxZQurXpJdftK9DBcuB6gPryeSDJJWWYyWnZkOLBDgBdLeNuJVWBQiHLDeXZF/etLmfMzvhSp4UPEjNgH4fvGnuX1/4DsyQs1m71v7p/GldY1z39RZ5+wzoaGlTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZEuNtcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZEuNtcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70641F000E9;
	Tue, 18 Aug 2026 09:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787044913;
	bh=zX75bM0J9UOPrq47VXmjRY7ygKLVT5gzh7SAp0gbzL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mZEuNtcFA1sjzr9fOtzpb+5FQQvuuzX1reyawRGssTYzik/eVYbEAx6TzLaR5pufR
	 0IH6yhe+cWUClwFCfw1McSPpPDsQf69Qc1hGNpDzD71q1oWFzgoSMVQEbUqR45/tDV
	 8daBwPF/FooRD/yaLWKKgMsTG4UwakOlHbNZ4N53K48GdTm6QlzibK7up3Gtbspzmf
	 vEFpo8pGZTpuaCCk1ns9uRpQ3zXqJdovibM/nPnsgqiOTszrv3PeO6SmeTBFAlNUxT
	 WdlHJ0tfSl4Z7hTOzspW65zILjgb9JG07ae3SW0gVBQG2NE33/sPweaayb4QNPOJB5
	 nQar7v4grThOw==
Date: Tue, 18 Aug 2026 11:21:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aiden Isik <aidenisik@member.fsf.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	Aiden Isik <aidenisik+git@member.fsf.org>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: samsung-wdt: Add
 exynos5515-wdt compatible
Message-ID: <20260818-singing-rhino-of-glamour-accb9e@quoll>
References: <20260817-for-next-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org>
 <20260817-for-next-lucky7-watchdog-v1-1-a14370e20b92@member.fsf.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817-for-next-lucky7-watchdog-v1-1-a14370e20b92@member.fsf.org>

On Mon, Aug 17, 2026 at 11:22:52AM +0100, Aiden Isik wrote:
> Add a dt-binding compatible for the Exynos5515 watchdog timer.
> 
> This watchdog requires a syscon phandle, and the cluster index should
> *not* be specified, as that does not make sense on the Exynos5515 SoC
> (due to it only having a single core cluster).
> 
> Signed-off-by: Aiden Isik <aidenisik+git@member.fsf.org>

DCO mismatch.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.yaml  | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> index 41aee1655b0c..9e754404848b 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> @@ -22,6 +22,7 @@ properties:
>            - samsung,s3c6410-wdt                   # for S3C6410, S5PV210 and Exynos4
>            - samsung,exynos5250-wdt                # for Exynos5250
>            - samsung,exynos5420-wdt                # for Exynos5420
> +          - samsung,exynos5515-wdt                # for Exynos5515

No need for the comment, old code is poor example here.


>            - samsung,exynos7-wdt                   # for Exynos7
>            - samsung,exynos850-wdt                 # for Exynos850
>            - samsung,exynos990-wdt                 # for Exynos990
> @@ -57,7 +58,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        Phandle to the PMU system controller node (in case of Exynos5250,
> -      Exynos5420, Exynos7, Exynos850, Exynos990 and gs101).
> +      Exynos5420, Exynos5515, Exynos7, Exynos850, Exynos990 and gs101).
>  
>  required:
>    - compatible
> @@ -93,6 +94,25 @@ allOf:
>          - samsung,cluster-index
>          - samsung,syscon-phandle
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos5515-wdt
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Bus clock, used for register interface
> +            - description: Source clock (driving watchdog counter)
> +        clock-names:
> +          items:
> +            - const: watchdog
> +            - const: watchdog_src

samsung,cluster-index: false

Just like other cases.

Best regards,
Krzysztof

