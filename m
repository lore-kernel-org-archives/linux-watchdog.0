Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327696;
	b=ZY+tRGqphY5uyRO6CrKB73FydMvYYIbIDgioudeP44WTmhWvBaKW4cVYbk3SDhgYC1tQ
	 zESmHkdq3jmRgUJGj268KDb4LvR/pSRAGWyOav7LGiSe+YrwB7pn84MB0i2C18RFelBCM
	 FfNcOgVUm8ed8Pki7D+4JVjH1KSMEQGqwIqACoUpVc5RY9dY7iJjTlgaQGucf1K+Hn1mc
	 12d28Nw1Yr0avtut4Ik9RNBXPAaVe2Z4rKLa8/ICF6twJFkJfLTFZeR9kSMuS1vtbSpd1
	 MBTsaHvlA0sdtNuvK1d4ho2EDV0Lqgt4NsLGKf1zw85HwayI3mOrP4QGH5vCkue4tpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327696;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bP5wdLNpyiJ9+ruTpF6sR5/wEnB1y9H630XlBE2DLdQ=;
	b=F7VKwlzn36Mbc6JTKu0pYTJm7gBHN2mO1N0qJeOz40fy5WeA/IN9+afg1TbU5oS5d6h5
	 ARSO+aPXIV7AGvKjaFVmaOheSg0+EeLG9BqMLJf5UJH9I8EpqTtHF0QphoOGwmUFiqAvE
	 czX3Gq3D6xiBAEY6nmMDOc+YLpzlQcSUNFiUBw4n+Jo+ngOt06Vih8zVv/9a3qiFfT6IQ
	 SVte1E7bDNbDkca3LESicO32ec9lYPx+/WMmYcrloqQGnUToUCWzicYAtzccihjnYmaZq
	 qJseg/mmZ5LNLqOHHcUZ2J8K63vKEBbqw4nAOBbGfqTGvpmHiKXEVxd7biIlBvux2WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTGfbKd2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A73606A320;
	Tue, 10 Nov 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTGfbKd2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45351F0089F;
	Tue, 10 Nov 2026 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327695;
	bh=bP5wdLNpyiJ9+ruTpF6sR5/wEnB1y9H630XlBE2DLdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JTGfbKd2jUS4VPVhdDdly/iy8wv65CnMHH+paZDTMqxrPURLhYqh8+dlyT/KoAc8y
	 KFHIePGE/iaUd2Bp4HDpKPw+QT/oIjrpRkf44ON2CuFDW7ZTjlIF5SL2X5AHk6m6eP
	 6Eby4xYgGaEay2rXmCfdQi3oIjCbBenzGIQsbQFXJ9VA109Xo6Kv/GX19HjXNP52qb
	 tpwLWp4ocPqZbJcu0lTXwD9/3ZSLs689Ffhz9ED5AXWRVNT9ptrcEkwxQnac671Jx3
	 q/WMEHxrdrl4NlVyPxeVMU9//QT+82C2U2tLXqDqykMv8p7NQ9oqZsB+sbtRDczRd6
	 E6o5a0YVNbIxg==
Message-ID: <eb9fdef7-2cef-425b-a62e-c28b7dbe1596@kernel.org>
Date: Tue, 10 Nov 2026 17:21:27 +0100
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
Subject: Re: [PATCH 3/6] watchdog: tegra_wdt: Support Tegra20
To: Artur Kowalski <arturkow2000@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, clamor95@gmail.com
References: <20261110-t20-for-upstream-v1-0-5923449951fe@gmail.com>
 <20261110-t20-for-upstream-v1-3-5923449951fe@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261110-t20-for-upstream-v1-3-5923449951fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2026 13:39, Artur Kowalski wrote:
> +static int tegra20_wdt_init(struct platform_device *pdev, struct tegra_wdt *wdt,
> +			    void __iomem *regs)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np;
> +	struct resource res;
> +	int ret;
> +
> +	/*
> +	 * RST_SOURCE belongs to the clock and reset controller, whose driver
> +	 * doesn't use it. Map only this register, without requesting it, as
> +	 * the region belongs to the clock and reset controller.
> +	 */
> +	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-car");
> +	if (!np)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "clock and reset controller not found\n");
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	of_node_put(np);
> +	if (ret)

Looks like doing syscon here. This in general is more fragile.

...

> +/*
> + * Tegra30 and later list "nvidia,tegra20-timer" as well, but match their more
> + * specific compatible string.
> + */
>  static const struct of_device_id tegra_wdt_of_match[] = {
>  	{ .compatible = "nvidia,tegra30-timer", .data = &tegra30_wdt_soc },
> +	{ .compatible = "nvidia,tegra20-timer", .data = &tegra20_wdt_soc },

Why in reversed order?

>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, tegra_wdt_of_match);
> 


Best regards,
Krzysztof
