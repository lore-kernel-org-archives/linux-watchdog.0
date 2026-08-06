Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40D3BC680
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996916; cv=none; b=BNvRUkh95j4ZoluiS/Su62bogODTgxebc9yTPG2netWP7oz6ARsgXGKwjjWK6qkEUp9NSz9rXbX7XxzE3kx6M5U0x90hxteovXa4X49xLKuXDSL5tD0W9F7xSYNie0gU3DtwSJ7Otew1kjsItKBr6Yr9wMUvJvCHHo6ITOsufkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996916; c=relaxed/simple;
	bh=LlxJZYYDJ80s5JvfJZ5AfP8rWApszcO+cTRySzWsEP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G8TqBn9KYucAfYyFyktuB6e8Yp+xq7/OZtBxq7bJqmoZU3CnIIHSqpb6leuPJePvnb7prky1gSySLBG6du3yUb5rpB/PNwNXesWkZtNkaUyA8yrIQT9eChZz3nUdy96/EHdMtbxNg+bOHnYpqX4DtkujwmvR5g75JKLBJvLDkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0avdCPh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0avdCPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639FB1F000E9;
	Thu,  6 Aug 2026 06:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785996913;
	bh=scRAGvMOImmNNmJcoEEgN1DfcP8UIwGPcLwpmzNE3g4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0avdCPhNM+jZ13r2I5x/dnoF0n7Bk1NG7pqY5hroqs84yTubxuQz/lvgb7QfPy41
	 Ix7VfgvJ/yj3ceRqT4il9ABiJRajixFvyyycv+fFMXuvcoRgpr0/FNAXSJVgd00QdO
	 MrqxPM3rYIyH2hEh8jwArxTzNivZOg9+ko55XAjSWlXvcxlpBdKjzrHaJ0scVjBKhQ
	 fsK7rUoLBfSi+2/K5dxoLfvldlFpaNq+yyZB/iXf0OgDW9bUWuF3IOeoyiff87Kxfg
	 ry4j3yQSIDezRKDPjuZ5fadpVDBgGkFLgSn1bksbVUNcf0Yyu4wWVRcoTPNhtat8qI
	 WVxyTyqKIGmxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: at91sam9_wdt: prevent timer rearm during
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongyan Xu" <getshell@seu.edu.cn>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260806060613.1830-1-getshell@seu.edu.cn>
References: <20260806060613.1830-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 06:15:12 +0000
Message-Id: <20260806061513.639FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the watchdog int=
errupt handler unconditionally returns IRQ_HANDLED, breaking spurious inter=
rupt detection for shared IRQ lines.
--

--- Patch [1]: [PATCH] watchdog: at91sam9_wdt: prevent timer rearm during t=
eardown ---
commit ed1f4752c24ee2e6219380915010fe895108b4d9
Author: Hongyan Xu <getshell@seu.edu.cn>
Subject: watchdog: at91sam9_wdt: prevent timer rearm during teardown

This commit replaces timer_delete() with timer_shutdown_sync() on the=20
teardown paths. This ensures the timer callback cannot rearm the timer=20
after driver removal or probe failure, avoiding a potential use-after-free=
=20
on devm-allocated memory.

> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_=
wdt.c
> index aba66b8e9d033..80ba04df54adf 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -242,7 +242,7 @@ static int at91_wdt_init(struct platform_device *pdev=
, struct at91wdt *wdt)
>  	return 0;
> =20
>  out_stop_timer:
> -	timer_delete(&wdt->timer);
> +	timer_shutdown_sync(&wdt->timer);
>  	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the driver
initialization, I noticed a potential issue with how the shared interrupt is
handled.

Since at91_wdt_init() registers the interrupt with IRQF_SHARED, could
wdt_interrupt() cause problems by unconditionally returning IRQ_HANDLED?

drivers/watchdog/at91sam9_wdt.c:wdt_interrupt() {
    ...
    if (wdt_read(wdt, AT91_WDT_SR)) {
        pr_crit("at91sam9 WDT software reset\n");
        emergency_restart();
        pr_crit("Reboot didn't ?????\n");
    }

    return IRQ_HANDLED;
}

If another device sharing this IRQ line triggers an interrupt and fails
to clear it, this handler will still return IRQ_HANDLED even when
AT91_WDT_SR is zero.=20

Will this prevent the core kernel's spurious IRQ detector from disabling
the broken interrupt line, potentially leading to an interrupt storm and
system lockup?=20

Should this return IRQ_NONE when the watchdog did not generate the
interrupt?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806060613.1830=
-1-getshell@seu.edu.cn?part=3D1
