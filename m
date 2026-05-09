Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7C258CD0;
	Sat,  9 May 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346963; cv=none; b=qiN0Y5eHVphwn2ugthvu8BgRJN/u6We+ZXkKu0xBqsqmU6ZtPMEy5MTygVaAmrA3dx+4iey5QhOAn1/inibpSErCLN6DfTVB3AnZ8k5Nl7E41Jfjj1lRGsnuq3JuCz/7zZo+NyMgC1KcJbWg1quqL8XGyIHdaZ11493qhIS0BeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346963; c=relaxed/simple;
	bh=Gt0Kp7pol/ZXvEcD3VLlX7yuiA9z+y00Agr1asuwIgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hwjfK9RU5OjYHzMZRfbeVs3fW201nlNaOUyms+14s/uHxs3iMAf5mPfJqLxc4hJvQivK4E5EjgpNCZv1JzEyCL+3Gk+F9TMesatZAG7gNQ8E6btrFyTav8Kejhe+ukmygIYx3rRNtIYvjQctChY1bLCfVnurOwCU+JOcw+VprCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9aBMn0Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9aBMn0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B74FC2BCB2;
	Sat,  9 May 2026 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778346962;
	bh=Gt0Kp7pol/ZXvEcD3VLlX7yuiA9z+y00Agr1asuwIgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=B9aBMn0ZfJW9mjxW0FsGcRN0m5PBq3rwPaEWgwWf2hYJlR7rNmXJDJgrJAcCE7UN3
	 I89jWZpPrBY3Mtb60BRPNSq4TXmY4TXJX6bROxp3twv3zWB2yYxZnWIRydH6TuH18N
	 xarphF8PBgn2OU60ejXNDLi2tOhliHyA138Vyj5mMdHi58qzyhqMLD/nzAwEZm/Ejh
	 g6M+M9HYguXUg1xaURFsTxBvE2znF++qI8JFmxAJ68d/hR+mlSABMtUkkFBF+T5rGa
	 DpDirTdI8sJdWNvzPkJegHb0f/XgJUmkgV8IGS6jh6CWhJu7A7irveKP1/z8OzaRYW
	 SEo8ly9AeKHOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] watchdog: realtek-otto: Change to use regmap API
Reply-To: sashiko@lists.linux.dev
To: "Rustam Adilov" <adilov@disroot.org>
Cc: linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org
In-Reply-To: <20260509163101.722793-2-adilov@disroot.org>
References: <20260509163101.722793-2-adilov@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 17:16:01 +0000
Message-Id: <20260509171602.6B74FC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deadlock risk in the atomic restart handler due to regmap's intern=
al spinlock.
--

commit a520c8e2203154ba331a6ae28f00daec074e62ee
Author: Rustam Adilov <adilov@disroot.org>

watchdog: realtek-otto: Change to use regmap API

This commit converts the realtek-otto watchdog driver to use the regmap API
instead of direct mmio accesses. It replaces direct read/modify/write
sequences with regmap functions and selects REGMAP_MMIO.

> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realt=
ek_otto_wdt.c
> index 2c30ddd574c59..e5e9cb480f4f9 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c
[ ... ]
> @@ -199,7 +189,7 @@ static int otto_wdt_restart(struct watchdog_device *w=
dev, unsigned long reboot_m
> =20
>  	/* Configure for shortest timeout and wait for reset to occur */
>  	v =3D FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, reset_mode) | OTTO_WDT_CTRL_EN=
ABLE;
> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
> +	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, v);

Could this regmap_write() cause a deadlock during system restart?

The restart handler is often called during system shutdown or kernel panic
in an atomic context with local interrupts disabled. Since
devm_regmap_init_mmio() configures the regmap to use a spinlock by default,
if a panic occurs while another cpu holds the regmap lock (e.g., during
a ping or timeout update) and that cpu is halted by smp_send_stop(), this
regmap_write() could spin endlessly and prevent the system from rebooting.

Additionally, on preempt-rt kernels, the regmap spinlock becomes a sleepable
rt_mutex, which could cause a sleeping in atomic context bug when acquired
with interrupts disabled.

>  	mdelay(3 * otto_wdt_tick_ms(ctrl, 0));
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509163101.7227=
93-1-adilov@disroot.org?part=3D1
