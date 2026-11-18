Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995494;
	b=f/M5itHPdWwYcSBH7UPFr0fCUWk19evI8vYukuq6gbHO+VYB3zhdEeDrxhFy1Z6nYuSu
	 6+LEMsKicYb6Rqxu729e9E73wo4QS5y9huYFv1M5W8syMRhkAhhflzrotBdQ/y/iz7xAt
	 HMQfk+YPCDsFvfJR/WQUPYuyF3Kzo1nEsbhQBblYqdGaDH1SyNm29crxiiqJSn3pi8nre
	 oukVAUjvxapMH8M3N9fc9TB8hLtpGvtgRJgjN3IbeJKoq80Q0xViWDby4Qfkr//34H//K
	 2I4ATcbk3VyL1SOwl2t3mjfDKAiQjFv533INasA/580O3FgKQ/+UoDemCExaiyRtG+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995494;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GDfdir6UONo2CVtSyDy4rQpcTV65+JR3/nSErGcdyBg=;
	b=bSbfuevmPINGYlVATPxnf6bFsHPyoNEAAkwMcjKowmgudoLzZfcFak1OSEstEMr+eGh8
	 sFZSaC12IeE6G7xLVmlKkObiQMiuNkTqtf5qpz2XhmvmIW3LeTp+YvSYvjVbXfhi9O+DG
	 jdQWib4RDO6oIPe7Z1b1qPkugbsDq1rTjtDkDnwOE/ceQj/GEZ+YilND4tAuppFaWyXsZ
	 2NsaluM8mMqx7pdYbqWA7PX7HxQO4Yx1tNbVmx4u9dvdEwa8I01ADp3OHtVWea2irdZLR
	 btth+e217ERbPygSzP12i0O8lLP0hOZ4SMJZT1nGkJYpNz5vNDqJVLJeMj9KNwHHOOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6IHwinJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94D606A320
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6IHwinJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7A71F000C5;
	Wed, 18 Nov 2026 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995494;
	bh=GDfdir6UONo2CVtSyDy4rQpcTV65+JR3/nSErGcdyBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c6IHwinJoKNt1zfALjhgP76rDOEU25vn+SGkJdD8TrAzwvrjgBxD6w03NR569K/ie
	 f+cFhKf1OtSDfVZR0IyZqayYmRx8RCRpAELO+xpQc/IJlgg7yDjVWL+yZpvNVICjk7
	 LEnARaW9NF4IAH43SGtznaxoIOxMGST3Cawom6BI1x/zPABP8BNxJUSAGPf2ICOq3b
	 8/qozPkG9ehVFfX9yb8lPNw6FuadetPbU50kzZZxABHndfzQOH2fV2OkjrPecB8/Si
	 UGxOXN1YjGDjv5nYGTJyK29S02rV5tQbhewPtm7RG6hGs8+IdyGHVMS/LPY8gX5eqG
	 5x5B3OCajnCGA==
Message-ID: <sashiko-outbox-220630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/2] drivers/watchdog: Add RISC-V SBI watchdog
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prajwal N" <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261118092147.2017658-3-prajwal.n@oss.qualcomm.com>
References: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
 <20261118092147.2017658-3-prajwal.n@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:51:33 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] watchdog: riscv_sbi_wdt: stale firmware pretimeout in
  sbiwdt_init_attributes()
- [Medium] watchdog: riscv_sbi_wdt: unclamped default timeout in
  sbiwdt_init_attributes()
--

commit b565a37dea556ad8d64b1011abd4a164f5ec1f54
Author: Prajwal N <prajwal.n@oss.qualcomm.com>

drivers/watchdog: Add RISC-V SBI watchdog driver

This commit adds a watchdog driver for the RISC-V SBI watchdog extension
with support for MSI pretimeout notifications.

> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv_sb=
i_wdt.c
> new file mode 100644
> index 0000000000000..026579a3c5cfd
> --- /dev/null
> +++ b/drivers/watchdog/riscv_sbi_wdt.c
[ ... ]
> +/* Initialize the watchdog attributes */
> +static int sbiwdt_init_attributes(struct sbiwdt *wdt)
> +{
> +	int ret;
> +	u32 attr_val;
> +	u32 timeout_usec;
> +
> +	/* Read watchdog capability from firmware */
> +	ret =3D sbiwdt_read_attribute(SBI_WATCHDOG_CAPABILITY, &attr_val);
> +	if (ret)
> +		return ret;
> +
> +	wdt->attrs.wdt_capability =3D attr_val;
> +
> +	/* Read watchdog min period supported in firmware */
> +	ret =3D sbiwdt_read_attribute(SBI_WATCHDOG_MIN_PERIOD, &attr_val);
> +	if (ret)
> +		return ret;
> +
> +	if (!attr_val)
> +		attr_val =3D 1;
> +
> +	wdt->attrs.wdt_min_period =3D attr_val;
> +	wdt->wdd.min_timeout =3D usec_to_sec_ceil(wdt->attrs.wdt_min_period);
> +
> +	/* Initialize the watchdog timeout to default value */
> +	timeout_usec =3D sec_to_usec(SBI_WATCHDOG_DEFAULT_TIMEOUT);
> +	ret =3D sbiwdt_write_attribute(SBI_WATCHDOG_PERIOD, timeout_usec);
> +	if (ret)
> +		return ret;
> +
> +	wdt->attrs.wdt_period =3D timeout_usec;
> +	wdt->wdd.timeout =3D SBI_WATCHDOG_DEFAULT_TIMEOUT;
> +	wdt->wdd.max_timeout =3D U32_MAX / USEC_PER_SEC;

[Severity: Medium]
What happens if firmware reports SBI_WATCHDOG_MIN_PERIOD greater than
SBI_WATCHDOG_DEFAULT_TIMEOUT (60 seconds)?  Writing the unclamped 60-second
default to SBI_WATCHDOG_PERIOD will fail in firmware and abort probe, or
leave wdt->wdd.timeout smaller than wdt->wdd.min_timeout.

In addition, if wdt_min_period is in (4294000000, U32_MAX],
usec_to_sec_ceil() rounds wdt->wdd.min_timeout up to 4295 seconds while
wdt->wdd.max_timeout is 4294 seconds, which causes
watchdog_check_min_max_timeout() during watchdog_register_device() to reset
both min_timeout and max_timeout to 0 and allows sbiwdt_set_timeout() to
receive timeouts that overflow u32 in sec_to_usec().

> +
> +	/* Initialize the pretimeout to default value */
> +	wdt->attrs.wdt_notif_time =3D 0;
> +	wdt->wdd.pretimeout =3D 0;

[Severity: Medium]
Should sbiwdt_init_attributes() also write 0 to SBI_WATCHDOG_NOTIF_TIME in
firmware before setting SBI_WATCHDOG_PERIOD?

If a non-zero pretimeout was configured in firmware before a module reload,
driver rebind, or kexec, leaving SBI_WATCHDOG_NOTIF_TIME untouched in
firmware causes the 60-second SBI_WATCHDOG_PERIOD write above to fail with
-EINVAL when the prior pretimeout is >=3D 60 seconds.  When the prior
pretimeout is < 60 seconds, firmware keeps the stale pretimeout active while
wdt->wdd.pretimeout is reset to 0 in software, triggering unexpected
pretimeout interrupts and allowing sbiwdt_set_timeout() to pass timeouts at
or below the active firmware pretimeout that firmware then rejects.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118092147.2017=
658-1-prajwal.n@oss.qualcomm.com?part=3D2
