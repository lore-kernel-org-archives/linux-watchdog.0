Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974913;
	b=su7J8UOMlq0NDU/ooFfVOqp5u22jf3mVvDvk9Z9poJzZpxb9WBDrKSzW/7tfd6y+FI+2
	 2nog1LZRFR7dmiiO0fyxrpqVXbvcupRwadTnTMfj+I0YrO1nVtmAO27rQqIWlZYov1laz
	 0/+2Po//FTfFXsRyI1VQSV6x8MuOLbmDn5OKhpkGqrwcbT6/OdpZt8QsAcWm3stFns9rL
	 EcpeADyBaTUxJOA9VYPiWV44zLKyTov8yP1WEB/Omukbix0WmOwcEeC5jQY1YcapgPkpc
	 dZkhiowAQ4Uakfgq9wEm/dX+nyO5pHWUoCJNI0bcJE1ioh0QZvX9fHXZMiFKRtifp6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974913;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rm/GO9DHZecJrXWzZzowupfLl2OENtiYVHE7igNcbUU=;
	b=o10yoesSMbz4yEg4G0rsdd5FmwwdWNC5fr0YOOZfSubHd9OUxdZ522+JmOEAo+cjCMJb
	 9CjkJtKZ9qIHq1px7bizcsiy+MFY+DyGCjHf/X5aWVjtWgs8/tnlqhoXzFzANG4jcHczh
	 LG+hDY5tchsr+8/9aLfV4cTAdvfUdUZD4FGlZNBeMCjmPD4P/sY9My7cbgBW7m5latLZO
	 wPKuIZwG3ahY2GO6T0XNomkdA4A87ZLke7i5iq23i588HXYYKNB49Av+Tr5dx+5aM1oPt
	 sjSuqAhIi5NdPASfbN2ygVftFonZjswLfHPnor7iC3WMdH8SDTAMgNFDfo2ZxgsJO/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlHGrnbt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF3606A326
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlHGrnbt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C2C1F008A4;
	Fri,  6 Nov 2026 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974912;
	bh=rm/GO9DHZecJrXWzZzowupfLl2OENtiYVHE7igNcbUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GlHGrnbtUkJ1bfyQRiFTrKLl+mjgBuCnKuPNf+q2TRP8NZaAG1dw1yWaJSfWMD9WR
	 IM9mqKqcCpcxf3bxQyTlMWyXvKe0/T1dGgupoQzt/YIVH65BVxspc/+68gnGY22jr5
	 HhKsogn7Zp1MgqFC4BJW2pT5g/ClOp4V21SIpSNcPlVR9qSAHqdIIQ/gdJRhXw6QuK
	 xlt1NSOVDrNYl4PKSYoBxJqByKLvWCCOJMg2CpLmE2i9TxnRVO0fxH2X2i+ZpGS3rs
	 oR4ZlQztekIN4GQdM7O7U1HHD4ejWYEutE5/KFTEHBAZ6+aBQRfahTM+rTBIV1eR21
	 jHu5NLkPBITjw==
Date: Fri, 6 Nov 2026 14:21:50 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v2 3/8] watchdog: starfive-wdt: Avoid unclocked register
 access in remove and PM paths
Message-ID: <au3ifkTtWPvGevf8@google.com>
References: <20261105190530.2371854-1-linux@roeck-us.net>
 <20261105190530.2371854-4-linux@roeck-us.net>
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
In-Reply-To: <20261105190530.2371854-4-linux@roeck-us.net>

On Thu, Nov 05, 2026 at 11:05:24AM -0800, Guenter Roeck wrote:
> When runtime PM is enabled and the watchdog is inactive, the device enters
> runtime suspend and starfive_wdt_runtime_suspend() disables core_clk and
> apb_clk.
> 
> However, starfive_wdt_remove(), starfive_wdt_shutdown(),
> starfive_wdt_suspend(), and starfive_wdt_resume() unconditionally read and
> write watchdog MMIO registers without checking whether the watchdog is
> running or clocks are enabled, causing a bus fault when the device is
> runtime-suspended:
> 
> - In starfive_wdt_remove(), starfive_wdt_stop() is called before
>   watchdog_unregister_device() while clocks may be gated off. Unregister
>   the watchdog device first (which stops an active watchdog via
>   watchdog_stop_on_unregister while its runtime PM reference keeps clocks
>   enabled), and only call starfive_wdt_stop() if watchdog_hw_running() is
>   still set.
> - In starfive_wdt_pm_stop(), check pm_runtime_enabled() and ignore
>   non-zero idle return codes from pm_runtime_put_sync() so watchdog_stop()
>   does not falsely treat a stopped watchdog as still running.
> - Remove the redundant starfive_wdt_shutdown() callback. Because
>   starfive_wdt_probe() already sets watchdog_stop_on_reboot(),
>   watchdog_reboot_notifier() stops a running watchdog on reboot, halt, or
>   power-off (while respecting the watchdog.stop_on_reboot parameter)
>   before device_shutdown() runs; calling starfive_wdt_pm_stop() again in
>   .shutdown causes unclocked MMIO when suspended and an unbalanced
>   pm_runtime_put_sync() when inactive or already stopped.
> - In starfive_wdt_suspend() and starfive_wdt_resume(), only save/stop and
>   restore/restart the hardware watchdog when watchdog_hw_running() is set
>   (in which case an active runtime PM reference ensures clocks are enabled
>   before suspend and re-enabled by pm_runtime_force_resume()).
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Cc: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
