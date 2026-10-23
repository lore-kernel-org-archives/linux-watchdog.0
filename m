Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724768;
	b=zn/zy1+6PtZDJQbSLnwVL96s1PVmWUIRcLkdsTP+8egy/GWYmY7D1T2+KYZ5slTGWLis
	 V41fKu/NYidKg9QtPAE7Y1Don62gVHiY/zrYsaXwIv00YnXKYq8gCTsktbQFmYSg6CS+F
	 zMUVVeYV1M+/6sQBY2e/9Ny5uV9vGWcIu+Qq9LOdTPuLnmjnu24mIYUJeaBhyGWfHui1b
	 aT23TKV2VJa/6vsNevmC61yruc1iltODjSiZoZxLLenEIuGEbr7pEpR/v5b9fJirf41wr
	 9YXBXR8iQ8jO+cvgt/w8peJ+3DA1JlvSlSLVEDdLOksihWruVlyJcFf+HhmsMzjEk6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724768;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=51oP+mZM8umDdi6cc4kmRQsPatMaLsIQB8+5kgte2SE=;
	b=1sj8nzKov1m2maqMndkXFthpGYblYjI128IZb3peEYfJJXwAiJZN08pDljhxCJAeG845
	 idicMds3NSf2/KL8s9brUITM90iuuvx24Kb6sHUsOiggjtSN7K+D6Ee3Kosm4YBlhVuaB
	 Xo1mjsmHFR8RvR1cBcvkaFObTPBbx+Bu1htvtehcDkyiDX1GbilzOTDxy5lp/ZQponi2u
	 qR29N88uVmJGi5uFan9BdxzZ79LhnOKJ9Qp9h2PMUwklSBgPy34lyDbUaaINvi+nj5/X8
	 JKgJUUXYVyBLZQ6+/eWsrYWmbt6ZwdPqWlIGw/rhJYktxNH5bW6B2hqszXVZ6t3D/dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDMw174H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB739606A319;
	Fri, 23 Oct 2026 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDMw174H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235391F01825;
	Fri, 23 Oct 2026 03:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792724767;
	bh=51oP+mZM8umDdi6cc4kmRQsPatMaLsIQB8+5kgte2SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KDMw174HRtXrjAtV/1TbtT5rJORWXRwCAEOBKj4s3xKnhrE+RqYWok+4Ijte8e2dv
	 MxP/KYYIuvzK3qskR7FQynk69T42rhOC3ivRwG7wwUfx4v8YcJDREfWxCg0FOcMe26
	 3rChY720hOmUZiRAvJT3x0cVAd6xmASI6ERZMf7QSUsgVWwxOR5aqi87/oaZfsdK6O
	 80rVBk1yuqtMypv8UBe6BWhZz5pailcrnudW4o4XLUd/o2JzFXQpP6+t+/dUqBeL3r
	 HUPVFMUhPpGODzoz8THCyixY2CLVSMet6nKVAG2t7+U83XS8mZR/GjCgckDYtgZoKN
	 wTmmRQyW9+bAg==
Date: Fri, 23 Oct 2026 03:06:04 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org, iav@iav.lv, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] watchdog: dw_wdt: clean up error paths in resume
 function
Message-ID: <atrPHJmmPBHuvbDx@google.com>
References: <y>
 <20261022134354.534642-1-a.shimko.dev@gmail.com>
 <20261022134354.534642-4-a.shimko.dev@gmail.com>
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
In-Reply-To: <20261022134354.534642-4-a.shimko.dev@gmail.com>

On Thu, Oct 22, 2026 at 04:43:51PM +0300, Artem Shimko wrote:
> Clean up of dw_wdt_resume() function.
> 
> Rework the error handling to use properly named labels that match the
> cleanup order. Use unprepare_clk for clock disable and unprepare_pclk
> for pclk disable path.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

See [PATCH v2 2/3].  I'd suggest squashing this patch into [v2 2/3].

> @@ -393,16 +393,15 @@ static int dw_wdt_suspend(struct device *dev)
>  static int dw_wdt_resume(struct device *dev)
>  {
>  	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
> -	int err = clk_prepare_enable(dw_wdt->clk);
> +	int err;
>  
> +	err = clk_prepare_enable(dw_wdt->clk);

This is an additional change, but I think it's fine to squash.
