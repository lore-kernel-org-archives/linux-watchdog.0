Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518845C6EA;
	Tue,  6 Oct 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296713; cv=none; b=uUUv7GR8YwE4u6fbd5f2JfLoeyPTQHUST89l5yoxHS4U5y3d8GnSCiD8CjsX02Mkq/Oy9A/olhL7Ynh8NPxRCVcvXcaOP21URQDuxs7IrPSQBkgtpLKtW4BVW97sLzMHnhTxlCNhxMSg+5/O3wqU4tWK7OvilGpqje0TeQle61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296713; c=relaxed/simple;
	bh=DdeBveOkfljl1eN5P9scCNSwIXZpfCWR/TrQ7X+UXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaVfz2gmWrZ4GnfCV3jqIZaO/7QmsWzxOtlNGkpuoSIz0iTWVMU98W6oGYOpnSNQ+JWEXE5JjVux3iNVefqSdq8JNO76mwdCxbS7WkPOgXLCg4pSXGuBk51TFwW2BXNwRbo6nwR02vLwEq9AUv+LrxB5EVQ925byMnKvr5KFFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb4z7+tX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb4z7+tX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040231F000FF;
	Tue,  6 Oct 2026 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296712;
	bh=YVXxvSYYRdPQOI5MuSDtLUOeadd8RxT16SXW6T61ygg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lb4z7+tXNR8cADG+sBP1el4wSuf5+2wDjll3ObfiTQACOG7Hqu1j8B4B2+I47sl2x
	 pDEsQ80jRKsQ2n8U++RE+Z/+jynaNhoj1tDynah97N2SXpABh7K/aIfoGPxICzUKgc
	 u/EyhGj8I7yz9CPWnvyi/fYfWfCJGUJiXAwuLxbffrSeviPpQ9fbZ+V24w3Mk0bCzY
	 vZ15upG4wMzA3n/dWJZ24YFNTRbRd/e3JL0Cnnl6lpnwHDgKv8z7wCIauurFPGkdPg
	 MoCJsThMC7LblSmaS1x5M15+03nV6Fgpmyp87TaKd8MpvRaPFwJxdLA1EOukfsEvAF
	 3x8fIjj/OH0Dw==
Date: Tue, 6 Oct 2026 14:25:09 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/6] watchdog: w83627hf_wdt: Move register offsets
 into driver data
Message-ID: <asUExcRccUEkam6l@google.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
 <20261004-w83627hf_wdt-improvements-v3-3-8e27b518595e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-3-8e27b518595e@bootlin.com>

On Sun, Oct 04, 2026 at 02:12:51PM +0200, Paul Louvel wrote:
> @@ -491,6 +481,21 @@ static int wdt_probe(struct platform_device *pdev)
>  	wdd->min_timeout = 1;
>  	wdd->max_timeout = 255;
>  
> +	data->reg.timeout = W83627HF_WDT_TIMEOUT;
> +	data->reg.control = W83627HF_WDT_CONTROL;
> +	data->reg.csr = W836X7HF_WDT_CSR;
> +
> +	if (chip == nct6102 || chip == nct6116 || chip == nct6126) {
> +		data->reg.timeout = NCT6102D_WDT_TIMEOUT;
> +		data->reg.control = NCT6102D_WDT_CONTROL;
> +		data->reg.csr = NCT6102D_WDT_CSR;
> +	}
> +
> +	if (chip == w83697hf || chip == w83697ug) {
> +		data->reg.timeout = W83697HF_WDT_TIMEOUT;
> +		data->reg.control = W83697HF_WDT_CONTROL;
> +	}
> +

A switch statement would be cleaner here.

Also, there are only 3 distinct register configurations: default, nct61xx,
and w83697xx.  Rather than storing and copying mutable integer fields in
every driver data instance, consider defining static const register tables
and holding a pointer to them, e.g.:

    struct w83627hf_regs {
	u8 timeout;
	u8 control;
	u8 csr;
    };

    static const struct w83627hf_regs w83627hf_default_regs = {
	.timeout = W83627HF_WDT_TIMEOUT,
	.control = W83627HF_WDT_CONTROL,
	.csr = W836X7HF_WDT_CSR,
    };

    ...

    struct w83627hf_data {
	...
	const struct w83627hf_regs *regs;
    };
