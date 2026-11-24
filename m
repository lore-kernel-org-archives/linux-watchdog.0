Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527432;
	b=1vel+nHyN62N4Qb6orzeKdS/LLJL98wCcz3VYziEsPRu+MSaHzjw3pwaK4Sion1q69e8
	 eq6DBGWR3CUem+kVIG2Jtrayqzlr/5i9FKy9rqRqMe/ZLnsVeR9Rl9KrjYhRlSgQZxcsP
	 y5xVwbGE6lINu9WhXQqpEFxZ0B2YVtlsKddI3/QoF5OKdOxLOabEz47v9PwI3bRyApKIb
	 KuLq9AtEtUZXtivFkfi5zCLJzNB57zP/byHb+KguBqaeVSMjHvZaw1+KVqcKLH0tk8uQS
	 vmOu9yceWF3zchZO9TbLk94s3Xw6UyPdALLbYhyQJT3wjwCG4HkkozwsQhM4JSDdHnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527432;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oji5cmvbgflzhFHjSCMTUWtZwZgJealtItojcsW5v8E=;
	b=sP1SuS/l1cZVnkofjUPtzg2AiLThDbgMq4DNQura7D4fsLepepWCmUmGilEVOIfe+jsY
	 Jfrsmf+xvUdqUdgN53KM85pmN2cHxyftKfSFpmQTyb8R8tln2miNxm//LlnHLURShMKtl
	 fSq2aAsmTOHerNO9cvZa4dzD7SO7aWapAR6EjX9Yflxm5wMxgVntZ5UrkfW91eE4akmWs
	 5z2+cv9iHnISB+zoVAB+F6BUMHJU9h/2pIn2g4curWXYfq8eLeGZbzh6d2vyZdsilgHRN
	 yKggzS2f+KFqVbtIuagja78E0rwfIrpXT0LZE/2a18J77/j7ICC9colAxpQSWR78NCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZE6muCls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C8606A686
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZE6muCls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631C61F000E6;
	Tue, 24 Nov 2026 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527431;
	bh=oji5cmvbgflzhFHjSCMTUWtZwZgJealtItojcsW5v8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZE6muClsF/iqxq/9EtoA7XP6VHwCadYhufxybPDvR94BnkcXi+5NidoLM8ul+WkTK
	 3+1BxN3TFc/xa44Q80h4qn1zGciYdVudrG5SmFwFbaJiYkiXrco6jJUVRN1VZlM/4E
	 wL87ToDfjjdQnYmyab2N5V9gsd9/lBO+9Zmgfato4fNBEPtaaYr6LuRpxSQO4d+eib
	 tg8La00qhMcHokddWLlHwuAI05X+OSpspddy6qgjN2n6fjp+cA3jvhPtIdpR1nGH4X
	 w0sD8XL9fw8TJ4IbjiVYantjyQ5UQ1byt3BVgIA8CUNmEafsGS5S62Sd/FsN3urn4k
	 0i80WrZ6ootKw==
Message-ID: <sashiko-outbox-231227@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/2] drivers/watchdog: Add RISC-V SBI watchdog
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prajwal N" <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261124131542.613271-3-prajwal.n@oss.qualcomm.com>
References: <20261124131542.613271-1-prajwal.n@oss.qualcomm.com>
 <20261124131542.613271-3-prajwal.n@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:37:10 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] watchdog: riscv_sbi_wdt: unclamped timeout bounds in
  sbiwdt_init_attributes()
- [Medium] watchdog: riscv_sbi_wdt: stale firmware pretimeout in
  sbiwdt_init_attributes()
- [Medium] watchdog: riscv_sbi_wdt: missing running state check in
  sbiwdt_probe()
- [Medium] watchdog: riscv_sbi_wdt: probe fails in sbiwdt_probe()
  without S-mode IMSIC
--

commit 7154e44eab330baa1ded9a131b702c04ae8a2530
Author: Prajwal N <prajwal.n@oss.qualcomm.com>

drivers/watchdog: Add RISC-V SBI watchdog driver

This commit adds a Linux watchdog driver for the RISC-V SBI watchdog
extension, including MSI-based pretimeout notification support.

> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv_sb=
i_wdt.c
> new file mode 100644
> index 0000000000000..8e3db98547882
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

[Severity: Medium]
As reported by Guenter Roeck on RFC v3 [1], should sbiwdt_init_attributes()
check SBI_WATCHDOG_STATE and either stop an active watchdog or set
WDOG_HW_RUNNING on wdt->wdd.status?

wdt_state is declared in struct sbiwdt_attributes, but SBI_WATCHDOG_STATE is
never read.  If the bootloader, firmware, or a pre-kexec kernel leaves the
watchdog running, writing SBI_WATCHDOG_PERIOD below can fail in firmware, or
watchdog_register_device() will not start the kernel keepalive worker before
userspace opens /dev/watchdog.

> +
> +	/*
> +	 * Read watchdog min period supported in firmware
> +	 * The firmware ensures the MIN_PERIOD is in valid range
> +	 */
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
As reported by Guenter Roeck on RFC v3 [2], what happens if firmware reports
SBI_WATCHDOG_MIN_PERIOD greater than 60 seconds, or near U32_MAX?

Writing an unclamped 60-second SBI_WATCHDOG_DEFAULT_TIMEOUT to
SBI_WATCHDOG_PERIOD will be rejected by firmware when wdt_min_period exceeds
60,000,000 us, failing probe.  Also, if wdt_min_period is between
4,294,000,001 and U32_MAX, usec_to_sec_ceil() rounds min_timeout up to 4295
seconds while max_timeout is 4294 seconds, causing
watchdog_check_min_max_timeout() to reset both bounds to 0 and allowing
userspace timeouts that overflow u32 in sec_to_usec().

> +
> +	/*
> +	 * Initialize the pretimeout to default value
> +	 * The firmware ensures the pretimeout init value is 0
> +	 */
> +	wdt->attrs.wdt_notif_time =3D 0;
> +	wdt->wdd.pretimeout =3D 0;
> +
> +	return 0;
> +}

[Severity: Medium]
Does sbiwdt_init_attributes() leave a stale SBI_WATCHDOG_NOTIF_TIME program=
med
in firmware across module reload, driver rebind, or kexec?

Neither sbiwdt_stop() nor driver teardown clears SBI_WATCHDOG_NOTIF_TIME in
firmware, and sbiwdt_init_attributes() only zeroes wdt->wdd.pretimeout in
memory after writing SBI_WATCHDOG_PERIOD.  If a previous instance configure=
d a
pretimeout of 60 seconds or more, writing the 60-second default period fails
probe; if it configured 1 to 59 seconds, firmware keeps firing unexpected
pretimeout MSIs and rejects later sbiwdt_set_timeout() calls at or below the
stale firmware pretimeout.  Writing 0 to SBI_WATCHDOG_NOTIF_TIME before
programming SBI_WATCHDOG_PERIOD would keep software and firmware in sync.

[ ... ]

> +static int sbiwdt_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	/* Setup MSI if the capability is available */
> +	if (wdt->attrs.wdt_capability & SBI_WATCHDOG_CAP_MSI_SUPPORT_MASK) {
> +		imsic_global =3D imsic_get_global_config();
> +		if (!imsic_global)
> +			return dev_err_probe(dev, -ENODEV, "IMSIC firmware node is unavailabl=
e\n");
> +
> +		msi_domain =3D irq_find_matching_fwnode(imsic_global->fwnode,
> +							DOMAIN_BUS_PLATFORM_MSI);
> +
> +		if (!msi_domain)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "IMSIC platform MSI domain is unavailable\n");

[Severity: Medium]
Should a missing S-mode IMSIC or platform MSI domain abort the entire watch=
dog
probe when firmware sets SBI_WATCHDOG_CAP_MSI_SUPPORT_MASK?

On platforms or guests without an S-mode IMSIC platform MSI domain (such as
systems using PLIC or wired APLIC), returning -ENODEV here prevents basic
watchdog registration instead of falling back to non-pretimeout operation w=
ith
sbiwdt_info.

[1] https://lore.kernel.org/r/23c02c91-0f92-46aa-86e7-5d9692d9ba8a@roeck-us=
.net
[2] https://lore.kernel.org/r/23c02c91-0f92-46aa-86e7-5d9692d9ba8a@roeck-us=
.net

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124131542.6132=
71-1-prajwal.n@oss.qualcomm.com?part=3D2
