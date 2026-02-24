Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAEB640;
	Tue, 24 Feb 2026 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900329; cv=none; b=bc6PgVmSdlSuHp6SEa34nP9y+fmro792TtjADBC+fxYA4Rm/VA2AfbCGaAlf8JuGtW9kvCIgsmqEWxUIfR9iBo1WgDGHlGcsYxiWu5Q7BUQt9wRZAw3yU5NqXrparBaf5VazSa56vWckKkbQQk0XvMUvMzqMRUjTTj9uRSi81To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900329; c=relaxed/simple;
	bh=1LzhitC1w/0xH0zBaZ+YkGLQzP+IExO/+Ro4EGuaO3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD4ksHC3Z+wdjjw/uUeOy6JI0gqCbrb9vMBG7tkno8QuvaC5a2i3bMKwm+6py+fGNZUPWO3sGOxKdOOwXL1OXhQZbbrKspH/l5wp3/eJ6B77AI2mzkEL3Qjxg/uNnZi343yyOk0ZSbgf1+2GcjGM/CjB9Jg8hQAoxHF7gzAC1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IPs3ABNo; arc=none smtp.client-ip=47.90.199.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IPs3ABNo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771900314; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=36AXy7Q/UgsZa0h1DoN/jPBwkeT/dUhwv1HVTQ5GxEo=;
	b=IPs3ABNo+QWODShGjAKtUnxCo+KAKE85e4IVTPEUlBb/IDkeZ6bCKjwMDGz6DSEoRjNfrSrdkHpHhOPO0mNkBww4QhuMdjNsg727yak4T9yVan5jk/4idMRNOALSLbEv8jLfw4xKJ9B20YZl9EeQL08NhCjREpLMjAQ8PiZKXsE=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WzhpIc9_1771896637 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 09:30:37 +0800
Message-ID: <5ec9bd47-4c58-485a-bc20-1a74cbdef40b@linux.alibaba.com>
Date: Tue, 24 Feb 2026 09:30:36 +0800
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: sprd_wdt: Remove redundant sprd_wdt_disable()
 on register failure
To: Felix Gu <ustc.gu@gmail.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260223-sprd_wdt-v1-1-2e71f9a76ecb@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260223-sprd_wdt-v1-1-2e71f9a76ecb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/26 7:59 PM, Felix Gu wrote:
> The driver uses devm_add_action_or_reset() to register sprd_wdt_disable()
> as a managed cleanup action.
> 
> When devm_watchdog_register_device() fails, the devm core will invoke
> the cleanup action automatically.
> 
> The explicit sprd_wdt_disable() call in the error path is therefore
> redundant and results in adouble cleanup.
> 
> Fixes: 78d9bfad2e89 ("watchdog: sprd_wdt: Convert to use device managed functions and other improvements")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Good catch. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/watchdog/sprd_wdt.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
> index 4e689b6ff141..aacf04616fef 100644
> --- a/drivers/watchdog/sprd_wdt.c
> +++ b/drivers/watchdog/sprd_wdt.c
> @@ -320,10 +320,9 @@ static int sprd_wdt_probe(struct platform_device *pdev)
>   	watchdog_init_timeout(&wdt->wdd, 0, dev);
>   
>   	ret = devm_watchdog_register_device(dev, &wdt->wdd);
> -	if (ret) {
> -		sprd_wdt_disable(wdt);
> +	if (ret)
>   		return ret;
> -	}
> +
>   	platform_set_drvdata(pdev, wdt);
>   
>   	return 0;
> 
> ---
> base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
> change-id: 20260223-sprd_wdt-3e7ec7187f30
> 
> Best regards,

