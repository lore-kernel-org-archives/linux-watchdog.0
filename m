Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8812475D0
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 02:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784774131; cv=none; b=lop0r9acgBy6/nQG8q4nKOLL6OSPbAD/6poyBLcOoSxwjP++ayfZKkZhHy/W99WQn1Mh/kLAuvioSmJ/WJCu6xNlDEeODqs7CsLtUDUKYJrEQdsn0aD89oX/AnSNCprB+kUU9Zmyx45LYGvj7ScaqQC6jQN6+Nej+Vqb8StW6UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784774131; c=relaxed/simple;
	bh=/ASv/eG0X5DwAEsb5dUViEaxr4I5J/ietRNsuvSzdAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FEEafnzbNmsfhEaWR6JNAJlFlDp7zkGiFN3/xlmBLTybcE4oBdmgv4AZrvSzjMYRvZCS0ejP7qid8PYWmNGtU3isajaRixkBqNNNIwzYJFq5ZQ7ttlTqMESrxUtEXOt3r2c2jLYWQJnG/Zqvsn4vL93pKOzUolxe/g/fLeT5jCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDtcIob2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDtcIob2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582E31F000E9;
	Thu, 23 Jul 2026 02:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784774129;
	bh=ixOg7PPUEy/XvpJ75HZNJYVfPB5pZdPsVkl3Hh6CC+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kDtcIob2fs+h07toZVnXtJ8pX8K4eJUoSWrKvb7Qb5oJiK5oCjopJlog+GZtfQjMy
	 Fm0rze+sPEzwBRgZqku5r1P+uT3DnZGOwsn83IQt4N8+SBRi3JKxuRlQ1RwhVnLFUR
	 Z19OYkKtEIGaNjfNxa++DYuCF3aHW3UUy/g8Qa5ZqR/ZVode3Bo2Jsq7AHxIdZkJtp
	 hBjpzos4HgE5bcMg0v6zSnr99muO+KmHigSTRDfiPrivVCK4i4SkL8zpZ8QY52taVd
	 h1a6xL+BpXr1JkOThA6I5an4QM1BLIHAIkIV+09kSFuPCwmw5itiajx17NB3qqTW4O
	 RN96AiwAHJ+Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] watchdog: atcwdt200: fix return value when watchdog
 is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: kr494167@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260723022634.8642-1-kr494167@gmail.com>
References: <20260723022634.8642-1-kr494167@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 02:35:28 +0000
Message-Id: <20260723023529.582E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Watchdog driver refuses to bind if the hardware is already running=
, breaking watchdog handoff.
- [High] Deadlock risk during system restart due to unconditional spin_lock=
() in the restart handler.
- [Medium] Incorrect unit scaling in watchdog timeout parameter calculation=
 causes fallback precision loss.
--

--- Patch [1]: [PATCH v2] watchdog: atcwdt200: fix return value when watchd=
og is enabled ---
commit 0db51070773de34698520f8f6ccc03a9f5d37ab7
Author: Surendra Singh Chouhan <kr494167@gmail.com>

watchdog: atcwdt200: fix return value when watchdog is enabled

This commit updates atcwdt_get_int_timer_type() to return -EBUSY via
dev_err_probe() when the hardware watchdog is already enabled. It also
updates the associated kernel-doc comments to reflect the new return
value, preventing an invalid enum value from propagating on probe.

> diff --git a/drivers/watchdog/atcwdt200_wdt.c b/drivers/watchdog/atcwdt20=
0_wdt.c
> index 8e3b18aea368f..7e757c217b0b5 100644
> --- a/drivers/watchdog/atcwdt200_wdt.c
> +++ b/drivers/watchdog/atcwdt200_wdt.c
[ ... ]
> @@ -274,7 +274,8 @@ static int atcwdt_get_int_timer_type(struct atcwdt_dr=
v *drv_data)
>  	regmap_read(drv_data->regmap, REG_CTRL, &val);
>  	if (val & CTRL_WDT_EN) {
>  		spin_unlock(&drv_data->lock);
> -		return TMR_UNKNOWN;
> +		return dev_err_probe(dev, -EBUSY,
> +				     "Watchdog is enabled, cannot detect timer type\n");

[Severity: High]
This is a pre-existing issue, but does returning -EBUSY here break watchdog=
=20
handoff?

If the bootloader previously started the watchdog, this explicit failure in=
=20
atcwdt_get_int_timer_type() propagates up and aborts atcwdt_probe().=20

Should the driver instead adopt the running watchdog by setting=20
WDOG_HW_RUNNING and allowing the watchdog core to keep it pinged?

>  	}
> =20
>  	/*

I also noticed a few other pre-existing issues in this file:

drivers/watchdog/atcwdt200_wdt.c:atcwdt_get_timeout_params() {
...
	rest_time_ms =3D timeout * 1000LL
		       - div64_s64(1000LL << int_index, drv_data->clk_freq);

	result =3D atcwdt_get_clock_period(rest_time_ms * drv_data->clk_freq,
					 TMR_RST,
					 &rst_index);
...
}

[Severity: Medium]
This is a pre-existing issue, but is the rest time calculation missing a un=
it=20
conversion?

Since rest_time_ms is in milliseconds, multiplying it by drv_data->clk_freq=
=20
without dividing by 1000 produces a value 1000 times larger than the=20
required clock ticks.=20

Will this predictably force the fallback path where rst_timer_params is=20
clamped to 0?


drivers/watchdog/atcwdt200_wdt.c:atcwdt_restart() {
...
	atcwdt_set_timeout(wdt_dev, 0);

	spin_lock(&drv_data->lock);
...
}

[Severity: High]
This is a pre-existing issue, but can this unconditional spin_lock() cause =
a=20
system hang during panic or reboot?

When the system initiates a restart, atcwdt_restart() and its sub-function=
=20
atcwdt_set_timeout() unconditionally acquire drv_data->lock.=20

Since restart handlers run with interrupts disabled and after other CPUs ar=
e=20
halted via smp_send_stop(), will the restart handler spin infinitely if=20
another CPU was stopped while holding this lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723022634.8642=
-1-kr494167@gmail.com?part=3D1
