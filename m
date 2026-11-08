Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181246;
	b=3BkutwPiunxXoCoDp4FR+Pi4WeYrpU7Y2lMKoDJ49M6ypKCs9IzDNScnNvdS98yxfItp
	 t89Wt+dzgJj2aLb6VOjN6kIP6GIAUlgUeA2QSCQmp8Kpmfh5lpQGJjcFhVQQoQyi90+ru
	 opUknaIzc37FW/mOdj7d3Gin4Tpk3W5Ff6xHKlvsm3BNY6HzHIdBQW3hwYIWtxOUC1O4C
	 muyh0b8zd+2z7ZOQuTXltr/ShfRxvrL0JSs6ZQxHXAU+FEagsCPgw13j0bHCmh04829yZ
	 eWMrnJM91DCcUUmCG7Zmc3+9/WJGqi6m3Hr/hZFrkzFwhR4RKHRQQA7BepLCQHfOCeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5kj6jhrQ1XzNT4l0pw7NLshlWeayRq0AJzVuLE5W99E=;
	b=3irg9evnq0htLbSIakHQGeVj58aWwnv4V5eWKTonZix2YrSBS+ymMkVTYmJWa31cuvFQ
	 DkGhZmWeebArYWns/FfGOWYA1qvHGdN6gsHrmLyKN2imtnzlPGc4oAudoNcK9rld0F7lf
	 TMPE3I/w/KMRjVGfuCJdPeC88NiWhuLcvE1CVf4y0X+m6+a/TP+keI1tonUGjpiPdE4CI
	 fAFEVrofJVGwBiKZ5v8nT9wG9H6gTNYqzd+j9/+fka42umABsvZ38pLgxsUu06XosKc1b
	 jUNGE91xrFLwodTYzT8ZTMsvlDnY1j6EAOVj/U/aoCcsSgigA56kG8dtgaOl2/YmzzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyGWRjJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51576606A31C
	for <linux-watchdog@vger.kernel.org>; Sun,  8 Nov 2026 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyGWRjJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85071F0089F;
	Sun,  8 Nov 2026 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794181246;
	bh=5kj6jhrQ1XzNT4l0pw7NLshlWeayRq0AJzVuLE5W99E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lyGWRjJP5Xj7NITKLk9i9dYhBgJwXg9WZvDY7/bmr4LfEoSv2T+MEKUzGHeClK0j1
	 YitkYRfuQ9W5Zhk5JEf2SzrMZlilSiokXVrFkCPnn2hxPyNUtDPmabQtRpZ9skDhww
	 WHd8/vI1B0/nSXRk5OQIYFwdnkuGsxv4+uAYJboT1F20Ne660I/zJrpczEmBZxFf/Q
	 o34YJhsU7vh2VnmpnZuCRQs9oqCdimsWwI3n4fqNKzpYFhrbBT+TJnbyW3l7SwQ61S
	 sJDLcIKnykG7iPugf0+3HWQszxlbVQD/DF87Azflblir5/zID6Uj3hcveIFJAx62PK
	 6kex+mY7/0bJA==
Message-ID: <sashiko-outbox-204168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: dw_wdt: Stop ping worker on system suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guenter Roeck" <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
In-Reply-To: <20261108233329.1059273-1-linux@roeck-us.net>
References: <20261108233329.1059273-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:40:45 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] watchdog: dw_wdt: unresolvable SHA 0b0ff67cbc2aa in Fixes
  trailer
--

commit dfd3154d77d7cf35efcd8342d85817dd9459cc8c
Author: Guenter Roeck <linux@roeck-us.net>

> watchdog: dw_wdt: Stop ping worker on system suspend
>
> When the Synopsys DesignWare watchdog is active with the watchdog core
> heartbeat worker running (such as when WDOG_HW_RUNNING is set at boot,
> when the watchdog is left running after /dev/watchdog is closed, or when
> configured with a timeout exceeding wdd->max_hw_heartbeat_ms), the
> watchdog core arms its hrtimer so the non-freezable watchdogd kthread
> worker periodically pings the hardware.
>
> Because dw_wdt_drv_probe() does not call watchdog_stop_ping_on_suspend(),
> WDOG_NO_PING_ON_SUSPEND is not set and the watchdog core leaves its
> hrtimer and ping work active across system suspend. After
> dw_wdt_suspend() asserts dw_wdt->rst and disables dw_wdt->pclk and
> dw_wdt->clk, an expiring timer queues watchdog_ping_work(), invoking
> dw_wdt_ping() to write WDOG_COUNTER_RESTART_REG_OFFSET while the
> controller is unclocked and in reset. This may trigger a synchronous
> external abort, bus error, or system hang.
>
> This did not matter and actually worked as expected since the watchdog
> can not be stopped directly. However, commit 1bfe88893808 ("watchdog:
> dw_wdt: add stop watchdog operation") implemented stop functionality by
> resetting the watchdog core, and commit 0b0ff67cbc2aa ("watchdog: dw_wdt:
> manage reset line during system suspend/resume") puts the watchdog hardwa=
re
> into reset during suspend, causing the potential problem described above.
>
> Call watchdog_stop_ping_on_suspend() in dw_wdt_drv_probe() so the
> watchdog core cancels its ping timer and work in PM_SUSPEND_PREPARE
> before clocks are gated and resumes pinging in PM_POST_SUSPEND after
> clocks and reset are restored.
>
> Fixes: f29a72c24ad4 ("watchdog: dw_wdt: Convert to use watchdog infrastru=
cture")
> Fixes: 1bfe88893808 ("watchdog: dw_wdt: add stop watchdog operation")
> Fixes: 0b0ff67cbc2aa ("watchdog: dw_wdt: manage reset line during system =
suspend/resume")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/bug/linux-4cde70aa-2cd0-405d-a626-7b41bfe6bbb7
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

[Severity: Low]
The commit SHA 0b0ff67cbc2aa ("watchdog: dw_wdt: manage reset line during
system suspend/resume") cited in the commit description and third Fixes
trailer cannot be resolved in the repository. Should this reference
cbe95d1faf57 ("watchdog: dw_wdt: manage reset line during system
suspend/resume") instead:

  Fixes: cbe95d1faf57 ("watchdog: dw_wdt: manage reset line during system s=
uspend/resume")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108233329.1059=
273-1-linux@roeck-us.net?part=3D1
