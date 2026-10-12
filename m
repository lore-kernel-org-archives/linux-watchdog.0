Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6349BD79;
	Mon, 12 Oct 2026 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827277; cv=none; b=Kljzr4kiU6wD+u5C+HMbkKP/2X0HBAEOlQoIZ6HhVFkz6iZd5OPdjzv5vSYYykq51S3pv/h93uT2DB5p6/5oZ2dnsUhL+y8wm4772BtQbFWWvU6RvtBHZ6NUJ8niOwSLyHRyKX53R2G+emb/SWm75nXj1Z6BG23zKDuS2EzdMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827277; c=relaxed/simple;
	bh=hsAHBf/Vpi9DYa0ZY4VU0nsYganpQ4VaYfxfLGcTnX8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K/ebQSKRDPpSJ6JvPC7Szw98rsYvfa5/OOlC+LD0YoksVhQW45TyJy3FBqmJuFtFY16ZjgVvOzbqJ/7NUG6YHrl3JbZFS/ArLy7keTtyrNJJZtqporynt2vGPdxxS14gz6ZoOTHT7FjSN5UMQng4dhGi+eH/2AK2butRfDPLUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxIxjiG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxIxjiG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A681F0089B;
	Mon, 12 Oct 2026 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791827275;
	bh=zx37xY9a3s7gkdjaZax4L2+grUfTWDFzsWjgkpb5dmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LxIxjiG5U/WeuOkt9MDmVo0wRxs7f/rBsugwbommMnHXpds3IRCcL7FAGES8+K3eK
	 B6MWJHtPgWRccjhoxps4hYtfVQaWRpnggYolmzsnSGCWK6eXLOOONjKgbc6YvKRscC
	 uewJ1BZ27UGA0Wa69cadPGOlKsD82tNbf4m6Jjicstu0AXHQwdSbiLNW9hEBF0GMUj
	 fHZF/LQLU1XCLOyOQ8ECmWg1XosY8vUKVrzxc/g76zfDG7XooQEFjhdI7nFaKYl74P
	 u6lG+Oy8810cYHMgNNJ1aV1ue24nrdl7fYEKLO27IeJtJOu62ZoI4bfErRnr+bzxkW
	 53gkUQ+e/ymKg==
Message-ID: <sashiko-outbox-168493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] watchdog: Add ARM TWD (MPCore private) watchdog
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-s2-v1-7-8a7641b7b79c@gmail.com>
References: <20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com>
 <20261012-b4-cs75xx-s2-v1-7-8a7641b7b79c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:47:54 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: arm_twd_wdt: premature reset due to ignored prescaler up=
date
--

commit f10545beccf6bb20bb2cd3eed188125eef8d1afc
Author: Fil Dunsky <filipp.dunsky@gmail.com>

watchdog: Add ARM TWD (MPCore private) watchdog driver

This commit introduces a watchdog driver for ARM Cortex-A5/A9 and ARM11 MPC=
ore
systems. It programs, pings, and stops the watchdogs of all online CPUs, and
takes over the hardware if it is found already running from the bootloader.

> diff --git a/drivers/watchdog/arm_twd_wdt.c b/drivers/watchdog/arm_twd_wd=
t.c
> new file mode 100644
> index 0000000000000..1931e9a39655c
> --- /dev/null
> +++ b/drivers/watchdog/arm_twd_wdt.c

[ ... ]

> +static u32 twd_wdt_ticks(struct twd_wdt *wdt, unsigned int secs)
> +{
> +	u64 ticks =3D div_u64((u64)wdt->rate * secs, TWD_WDT_PRESCALE + 1);

[Severity: High]
Does this calculation always match the actual hardware prescaler?

The timeout calculation strictly assumes the prescaler was successfully
updated to TWD_WDT_PRESCALE. If the prescaler update fails, this causes
a huge mismatch in the expected timeout.

> +
> +	return min_t(u64, ticks, U32_MAX);
> +}

[ ... ]

> +/* The following run on the CPU whose watchdog they access */
> +static void twd_wdt_cpu_start(void *data)
> +{
> +	struct twd_wdt *wdt =3D data;
> +
> +	/*
> +	 * Load the counter before enabling, it may still be zero. A watchdog
> +	 * that is already running is reloaded and keeps running, the mode bit
> +	 * cannot be cleared by writing the control register.
> +	 */
> +	writel(twd_wdt_ticks(wdt, wdt->wdd.timeout), wdt->base + TWD_WDT_LOAD);
> +	writel(FIELD_PREP(TWD_WDT_CTRL_PRESCALER, TWD_WDT_PRESCALE) |
> +	       TWD_WDT_CTRL_WD_MODE | TWD_WDT_CTRL_ENABLE,
> +	       wdt->base + TWD_WDT_CONTROL);

[Severity: High]
Can this write fail to update the prescaler if the watchdog is already
running?

According to the ARM Cortex-A9 MPCore TRM, writes to the prescaler field in
the Control Register are ignored if the timer is already in watchdog mode.
Since the driver takes over a running watchdog without stopping it first via
the disable keys, the hardware retains the bootloader's prescaler.

If the bootloader set a smaller prescaler (e.g., 0), the timer counts down
much faster than calculated above, leading to a premature system reset
shortly after the driver probes.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
s2-v1-0-8a7641b7b79c@gmail.com?part=3D7
