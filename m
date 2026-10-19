Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423376;
	b=TBMb8lZrhGl8IMZk2QFwt/ULnebFS9GUoV+JQXL43RME30Sqf7fDr+7doN/nLMItc98m
	 WWnulLlP/SHqIoXJSznhexGQjpUvZXY1mlDgi2eX53fZsf2mVEAk2r9iaeSNn/8dcBRf2
	 cJ+uHn5PDULknG1/QBzAmVj0Z7LaYXoHsOQhOV8LI42TaG3m/nlt6DjpNeaCscq1iKs0e
	 +UtYI/oayROssTnkDpRwVW21gNdCTNn/yTnf2+h29FpN5nRfhVah39cc/mloqK/Sttz+q
	 0S6FBrVbvWJCXTCZROJIcbaoidiIGGqE2rFbL7wLclBWeMHI/iu1CovJ5T1JmVFMqaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423376;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uxRefdjC1faigZCaIh564uvlWoAmDrfhs0/GDX8ugQU=;
	b=q7wG+bYUMDetTbSvPteqtB928cdf65iqD4Rw1J4N6TbrXJSTAnMRB2B2cAl1K1E8e49M
	 8Gr5OOm73xxnjlhcv6YQSB+HpoD9UQP6+eUGDwHEWfic9k9DBJFDyL18Op0F4AdFkCnsI
	 fvAWmzwrPk/JbxGfuCH3tnA9GrKTxbSaJ2XJLO5WwxSOIVYmFsvUQuhNAa2/G4Mlbdc7/
	 UnFK/ovC82khqHFQrGc1vLOpx0Z85OOJyQMufQ/skvTnS7bVBkdUmuIdzt3+OBC0GxQnW
	 bzKenTQ8i1OnzGjVlmf4J4e5y2kW1GJD4uh0ncYmWqKgdGsvQywYiHGyUHKscWpmYew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cq0aRrSR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2B60AB716;
	Mon, 19 Oct 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cq0aRrSR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3551F000C4;
	Mon, 19 Oct 2026 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423375;
	bh=uxRefdjC1faigZCaIh564uvlWoAmDrfhs0/GDX8ugQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cq0aRrSRpfPM5TAQt1gVN+YP0fbg03Bf7RDBH/rXvJzbhjERKN8uYWwmxVLaM4jJV
	 hSSlDV9KH5YCZflnN9H5K8MnuJIcToLzl8JV8PVqOIT009D5t+Rg5X6RmU3v+nwy38
	 aQN9Vw6sjxv+zUJIQ+F5gTDkCjmlRmI6hEummff9BodnYlrTB2GSDEIGZLvgO7Miuk
	 K27Yq8LcFkKd7QNK1AdaI8dBCm9Vo9BHBtOq5PYTvgUArjheYUvS6uCorYLj6FSSwe
	 JTyHyVJUOVxmq7f9omLaaPgBdNvJYa4EppQAU92MIUmoLu9F0E/pH4PQAqhYc4f4qD
	 IGyvRQBRlPQwQ==
Date: Mon, 19 Oct 2026 15:22:52 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 3/6] watchdog: w83627hf_wdt: Convert to platform
 driver model
Message-ID: <atY1zCt9YWcaxeAo@google.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
 <20261013-w83627hf_wdt-improvements-v4-3-b6f6b60a9566@bootlin.com>
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
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-3-b6f6b60a9566@bootlin.com>

On Tue, Oct 13, 2026 at 03:58:47PM +0200, Paul Louvel wrote:
> +static int wdt_probe(struct platform_device *pdev)
> +{
...
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return dev_err_probe(dev, -ENOMEM, "failed to allocate memory\n");

dev_err_probe() doesn't print anything on -ENOMEM [1].

[1] https://elixir.bootlin.com/linux/v7.2/source/drivers/base/core.c#L5097
