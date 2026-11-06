Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974940;
	b=GWhTkKyrm0Df/fjNZht6LusqR0mzcm3Ebx8PPQVQ3eqvfDWipM6vyhdsSP8IAD4ObCxT
	 kbNPKwRxbNRW6huGvOV6RJ98AyPVCO6zyzPfUsOocv+4cBvdsYRjXGLDm2B+vTLvf7j+G
	 aCewYxHH3dB1TuwTcmQ1nuQMzEmZZ4iYbKx8Qb0J9iHhaNiF/7BhRwtjkwzsPTej8pmUH
	 bIUQNBS2G4ZhCUl2aV0ogPamPH66aQiPvqnzqjvE90+p73Wf6jMzsBvwcwC4wYlQnJ6D6
	 vkRKPnuM/zdrf81T/j4tnPv+NV9T+mKn6YoQncl7Sm5Ds/t6E0cjEFrFCP0UnQfRkUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974940;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=toWXYhf0a8PsdKuqvpHB4V3sVsXuy0d0zU2rDN66MaE=;
	b=A/qhW/KfGFMdg0eq/QulRYSfg2TNDuS+dqir7P+VHRtaNyx3DXpIdZ784MBqWyYX+Pug
	 osBXA4SJQwNp8ztBYMASxAzvbVbZJkaGXwLhmr1ZXQmmoDyVmWIH9EoQLH2qlPcQ8bMqu
	 oSUAN9LpkWQL2rngHhaN5964uNCxVL1+KLS6fq1Rr4GxwOlxAQD/y2hrxDhYe3MDIRL7F
	 LhJpUMYwY8Fs7RAdbhu0z8LNFm1VoQUuSVWA94r9lAJ+FvpcZaUgIA4JDz9iKy/+Nh0VE
	 5yuhshOQiTcXOUvTUu+aPWiruKuPN7AphYU7vBrwFNc1J/B3dUBdb6eZ4YmgGBfyvFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hl4chcSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E4606A326
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hl4chcSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C171F0089F;
	Fri,  6 Nov 2026 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974940;
	bh=toWXYhf0a8PsdKuqvpHB4V3sVsXuy0d0zU2rDN66MaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hl4chcSSvrbuvnICtG9XZ5MeRhRLcCr6ogIj1Bu3kst+B2Q1hxHeuErV75wHjtPnT
	 pIVvwf4MwedlneJEt4PxPIObnmNx42P793EBLmZ12l58cmrKjJsw/AjkR6tOKRv6hF
	 j/maODoSuUM3tdu2QMSTBd/A4FuaRMwoa9aYBEfKzVC6IroGJqffWXGSkrqyFv4TA2
	 /qfpZeYN+ZiKYZgclbJWQ2S8sA295PhDQQfdfmDXs6JG61sqfG5WJD2bE6huIzuKaq
	 frHSrj8sP+2OZxfqnY6ZwMfko3IR3roabmwiI/hMRRDyJg+W3vXmcBaNyTY3oqFmvY
	 KdJNVTVQ+De5w==
Date: Fri, 6 Nov 2026 14:22:17 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v2 7/8] watchdog: starfive-wdt: Stop ping worker on
 system suspend
Message-ID: <au3imWJythmd8W9E@google.com>
References: <20261105190530.2371854-1-linux@roeck-us.net>
 <20261105190530.2371854-8-linux@roeck-us.net>
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
In-Reply-To: <20261105190530.2371854-8-linux@roeck-us.net>

On Thu, Nov 05, 2026 at 11:05:28AM -0800, Guenter Roeck wrote:
> When early_enable=1 is set and CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is
> enabled, watchdog_register_device() starts the watchdog core hrtimer so the
> non-freezable watchdogd kthread worker periodically pings the hardware
> before userspace opens /dev/watchdog.
> 
> Because starfive_wdt_probe() does not call watchdog_stop_ping_on_suspend(),
> WDOG_NO_PING_ON_SUSPEND is not set and the watchdog core does not cancel
> its hrtimer and ping work across system suspend. After
> starfive_wdt_suspend() stops the counter and calls
> pm_runtime_force_suspend() to gate core_clk and apb_clk, WDOG_HW_RUNNING
> remains set; if the timer fires before starfive_wdt_resume() re-enables
> the clocks, watchdog_ping_work() invokes starfive_wdt_keepalive() with
> gated clocks and causes an unclocked MMIO bus fault.
> 
> Call watchdog_stop_ping_on_suspend() in starfive_wdt_probe() so the
> watchdog core cancels its ping timer and work in PM_SUSPEND_PREPARE before
> clocks are gated and resumes pinging in PM_POST_SUSPEND after clocks are
> restored.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Cc: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
