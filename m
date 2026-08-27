Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0941D620;
	Thu, 27 Aug 2026 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832756; cv=none; b=nH6o7gLlLT+LaLwijUiqi6A3wEkygnpwFcB1FPAplMNSK7Q7vVmdkBqrh8N1TS4hSwQ0pMLVmwYR9kbkkWKqq9pp0M699C3cGp5d7aKtU3IgjhF0nTQnoAEzDLB/udORDE/2hMLpQ4e7AUv6Q92eX0kpnlIXd//MV4WkrkAmcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832756; c=relaxed/simple;
	bh=w0SQfwZUSuGH5Ew1gOFHwu/0bxEkKTLnRMcF5LLyfUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2YAeTisCn/mu+0UoSBYZyVRQVJqZpU6yHkgZRJ+MkmpSEUOrlwvB+MMOBXGwdD6BXb9NhRiGvRerSWkFU/ZKP/vsbP/BNvS1ixnKKalPKsEKoOM349Gw+mwsB7puC1t2unURQ6xJz4aeP9JfxNbFuHAf6H9P3QqRuie9u9MzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXcgLl0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXcgLl0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B391F000E9;
	Thu, 27 Aug 2026 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832754;
	bh=oN1uBNEZB9zCmyVRxDlBtR7tHE5jA4bpzOHI8/B57Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HXcgLl0PLqP5ixOEzoOZ638HhU1mGkyHmnZoq/qZDaBBA/zQGfmcV3r+3u7k4VoJF
	 7P+7c4BxJVN63wedE5ZHFzUNXjBASY2z8g2zYUjtxy+5isxC2mRIcIKreyWoh8Vls7
	 h9KJkhXWfCJUgXcXqd8YoHcizZzozp+dTvW/V224LV89OjEMwgL2Uz7xhvXKYEBc0i
	 0lFixYKHToNC6CC5rA5a4YZ6+AZaq3gxNXkpkNA7QPTI65kxx/B0/FHTkB/JavZvh/
	 UsJvHfQzToJqGKOcxDxOmSA1F04ie9+sHn83u5MR0nJrPVl8aMqi00cGT7DxjnGEZ1
	 V+cabfdJ3oH0Q==
Date: Thu, 27 Aug 2026 14:12:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aiden Isik <aidenisik@member.fsf.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt
 compatible data
Message-ID: <20260827-energetic-nifty-anaconda-6de11a@quoll>
References: <20260821-for-next-lucky7-watchdog-v4-0-d070cee5009f@member.fsf.org>
 <20260821-for-next-lucky7-watchdog-v4-2-d070cee5009f@member.fsf.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821-for-next-lucky7-watchdog-v4-2-d070cee5009f@member.fsf.org>

On Fri, Aug 21, 2026 at 04:14:50PM +0100, Aiden Isik wrote:
> Add driver data for the Exynos5515 SoC's watchdog timer.
> 
> Unlike similar SoCs such as GS101 or Exynos990, Exynos5515's PMU does
> not require explicit counter enablement for the watchdog to tick.
> 
> Signed-off-by: Aiden Isik <aidenisik@member.fsf.org>
> ---
>  drivers/watchdog/s3c2410_wdt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

