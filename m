Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423401;
	b=2R6q0oGDau4nxct9Sqil0/k9gZqywhICRLrA6+QF4P0xeb6BouPBPviXqChBdlQuShDX
	 Z+JMIUUyI7UwayCJ1uIDHvKufgNbC1QwslIF3p8/4QNM2+ZAdL3VJRpzbjHJhGhdwIFBE
	 wsX65ypVEc4JHSYAUB1lHcroaYe3qIJW5lJtySCAEeHM+rPx7WufKNsXe15yjOuAxX4lV
	 YlNCdX8jPV/XEp6R4EO3kVQ9yWtyg2+ldwKmiPsOMW2YRM2/OGLjqgUzc5CLYmgl3FeGi
	 B9T8BqLyVTxgbq5NSkqd9gkm9duf+Hlx/k7z8rjZ1HTzGHya7V75zI53SmW4rEunHWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423401;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aXowl59O+VAncoX8AnNa8hNWQwdqQ1jRCUd09tutG2Q=;
	b=dxisxx+BJGjFwqk1gSG4jUAdPP0rznTgnfz2MyDpcDE5Orl8XdsGszJ3DzkNBLzQ7lOA
	 6PgfzjuUb1wHGMmgFa6Rlsmp+lcJFduHMYfhluvfcj+Yrtn8GhSxixfe74HhRGWs6+P0k
	 BefpeAiCKnogz1JJ+djaZ9yHKlrE9BVJ1sovuN7A7NAPYC/jehxxSLKOQ2ywvWrICtUyi
	 ks83BRx5N2ClCHIor3qIYxiI9xq3wZhz5ZudowBYmFWpA5Mn238YZ2rQxYpy6/Kpw01+I
	 zyjq/+/clRl/AtFoQsC6QD7hKG8dF4I+xQRZtlV/GWlkppZdB4gEuM4CJg+pCvePfWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7Mb+qU9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7360AB73C;
	Mon, 19 Oct 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7Mb+qU9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059751F000C4;
	Mon, 19 Oct 2026 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423401;
	bh=aXowl59O+VAncoX8AnNa8hNWQwdqQ1jRCUd09tutG2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d7Mb+qU9PMj5h96QHPz5S98hu+mmCsE/74JclLfPIsLhJEQLzM4RUoqXWVXjwU2YH
	 4/y4fBSX7VnEKjurkw50wMb3/3Qp4eVLDAmP+LLJH6UQl+PAZNsJ+jRzmvGsTqyvDU
	 8tZ54O1pR4tHBHuSYK6h/ZxEC5wje/ul9RFcTMcdc08bhHUbKP5vyn/0ygxQVx+Ht3
	 edxf9agSvsP2jkBc+sO7xZgyvziT8/Ew/ORTU7ZSW3qNkhBYIZ+1WEcnIg4XVqSWZ/
	 ABwmHCtkTnwfV9mfljg6Bdqifxj46xaHdi0uJvnY3NAtgQ9cuZFwO5O4LabEtXPx13
	 rIJbzDBEmJIMA==
Date: Mon, 19 Oct 2026 15:23:18 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 4/6] watchdog: w83627hf_wdt: Move register offsets
 into driver data
Message-ID: <atY15ssAjhTBz6kr@google.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
 <20261013-w83627hf_wdt-improvements-v4-4-b6f6b60a9566@bootlin.com>
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
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-4-b6f6b60a9566@bootlin.com>

On Tue, Oct 13, 2026 at 03:58:48PM +0200, Paul Louvel wrote:
> @@ -42,9 +42,6 @@
>  #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
>  
>  static int wdt_io;
> -static int cr_wdt_timeout;	/* WDT timeout register */
> -static int cr_wdt_control;	/* WDT control register */
> -static int cr_wdt_csr;		/* WDT control & status register */
...
> +struct w83627hf_reg {
> +	int control;
> +	int timeout;
> +	int csr;
> +};
> +
...
> +static const struct w83627hf_reg w83627hf_default_regs = {
> +	.control = W83627HF_WDT_CONTROL,
> +	.timeout = W83627HF_WDT_TIMEOUT,
> +	.csr = W836X7HF_WDT_CSR
> +};
> +
> +static const struct w83627hf_reg w83627hf_nct61xx_regs = {
> +	.timeout = NCT6102D_WDT_TIMEOUT,
> +	.control = NCT6102D_WDT_CONTROL,
> +	.csr = NCT6102D_WDT_CSR
> +};
> +
> +static const struct w83627hf_reg w83627hf_w83697xx_regs = {
> +	.timeout = W83697HF_WDT_TIMEOUT,
> +	.control = W83697HF_WDT_CONTROL,
> +	.csr = W836X7HF_WDT_CSR
> +};

Nit: the order is inconsistent.  It would be better to stick with
the order timeout -> control -> csr.

> @@ -489,6 +499,21 @@ static int wdt_probe(struct platform_device *pdev)
>  	wdd->min_timeout = 1;
>  	wdd->max_timeout = 255;
>  
> +	switch (chip) {
> +	case nct6102:
> +	case nct6116:
> +	case nct6126:
> +		data->reg = &w83627hf_nct61xx_regs;
> +		break;
> +	case w83697hf:
> +	case w83697ug:
> +		data->reg = &w83627hf_w83697xx_regs;
> +		break;
> +	default:
> +		data->reg = &w83627hf_default_regs;
> +		break;
> +	};
         ^
Please remove the extra ';'.
