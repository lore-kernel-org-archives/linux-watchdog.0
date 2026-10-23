Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724755;
	b=Xoo187xeYRXr8uDNX1/w4lSU4AG8TUB9oClJINfjBhsZ2CFLNkNSoHwMWma03vP0sztT
	 J6oXFt0/89hUmWLRDIJ4CXXNuWQ8l5ZtYs5WlvWlW9CMNvyU3rL+Fb1bavPHSuNuXenfT
	 AMpA9csNetb5AFeVuFtTzt8/RPODnkiyaBiGhwaT4oE92q6cFozqU4DU6cIih1ZLK+LI5
	 7ZeyP5vhXXG0G/ELYiDiUGl2RooaDzkpZzHrLuv9nLSw6NuBEGPORS6WRE3DH/CzhIfxK
	 jU4y0m7BdblXjLmATiGvoEPHpCHx8kEnLjyVv+iJmvUQaO0caMP8Ur5o2zA6RxJEaUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724755;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZDt42fOmBzaw9BOmfiuldB3LQK2fIbNMiANSIszn4Uc=;
	b=Cc/XzWTDiVddcRZkksLGZn2fCCKK0VpRVisdQoH0hBAVCHg916A3okxk0lED333V4eA9
	 kKvGHRUE4mfgI8psX/rFNenb5ROZBoFZKsAKuqKOqVFdfZ5/NAdPqftxT4lYunN3vRRWs
	 O8tWXlSdb8v0cDXadO8TGoS0exY477VrFCgeairaInpuXHnyIm5eHvdPiNm0Me7w5xgNd
	 /ROxcGSkIBrL76Hvgn+PYciigJ66VTznL1CtX9Tk3kxbU4LB5YZ0B10TSlILTYSf2Dgta
	 Co0b1q6kapn3cTqkCkgIT0HO5NTBjGKIVLH1I6l1ym8V82X1WYSYvgfRxxZnJF0wsWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK49Fibt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B90606A31A;
	Fri, 23 Oct 2026 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK49Fibt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCDE1F01828;
	Fri, 23 Oct 2026 03:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792724754;
	bh=ZDt42fOmBzaw9BOmfiuldB3LQK2fIbNMiANSIszn4Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oK49FibtSUHDW39Acn/cPucwmQE1gs5BqLf/XrGWh73yFD5OWclOR0dIF4K0qpmM4
	 gyB+metm/WKCG1sm0A/PXEQj2oiV97s9Xt4pbQrqEMh2t1WmenZj6io7Dj75tJ0mVp
	 60B2fdNXJ1SpEoXqarmbXiUXjOSK4caZuPtWityzZQkt/bHbPoUSWkVCtxOuSEktKx
	 O+ttexyAJeT9t6fPRIs3umspsSozf/2tI2iuQikoZtFIDa5ao/gjKri3JjkCnuebPs
	 3hXAFUWmj279fwoy55WQdBkYQcqX1nE7AeXAsZVuMRgp/ZX95dfAwW73SLk/4cxS9b
	 APwhSDp44YB0g==
Date: Fri, 23 Oct 2026 03:05:50 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org, iav@iav.lv, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog: dw_wdt: manage reset line during system
 suspend/resume
Message-ID: <atrPDqHCt5Y3OE8u@google.com>
References: <y>
 <20261022134354.534642-1-a.shimko.dev@gmail.com>
 <20261022134354.534642-3-a.shimko.dev@gmail.com>
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
In-Reply-To: <20261022134354.534642-3-a.shimko.dev@gmail.com>

On Thu, Oct 22, 2026 at 04:43:50PM +0300, Artem Shimko wrote:
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 2cffe337b4ea..ec6a09673da4 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -382,6 +382,8 @@ static int dw_wdt_suspend(struct device *dev)
>  	dw_wdt->control = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
>  	dw_wdt->timeout = readl(dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
>  
> +	reset_control_assert(dw_wdt->rst);
> +

Doesn't it need to check the return value and propagate the error just
like what dw_wdt_resume() does in the patch?

> @@ -402,12 +404,22 @@ static int dw_wdt_resume(struct device *dev)
>  		return err;
>  	}
>  
> +	err = reset_control_deassert(dw_wdt->rst);
> +	if (err)
> +		goto unprepare_pclk;
> +
>  	writel(dw_wdt->timeout, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
>  	writel(dw_wdt->control, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
>  
>  	dw_wdt_ping(&dw_wdt->wdd);
>  
>  	return 0;
> +
> +unprepare_pclk:
> +	clk_disable_unprepare(dw_wdt->pclk);
> +	clk_disable_unprepare(dw_wdt->clk);
> +
> +	return err;

There is only one user of `unprepare_pclk`.  Two options:
A) Drop the goto label and inline the cleanup within `if (err) ...`.
B) Refactor error handling for clk_prepare_enable() to use stacked goto
   labels.

I just realized [PATCH v2 3/3] actually does option B.  Please consider
squashing patch 3/3 into this patch.
