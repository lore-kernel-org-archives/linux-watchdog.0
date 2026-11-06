Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985584;
	b=D6l/Pueucys7tg8RyvkoSFrO1AWYYTC6iOUaBU3CzrUxOAGFIEyL0MvFJEfL6Zc6DTHC
	 +DDzZV+6QTc4PxunQFFC5z6PgoBo7Kds7dz6ulyzX4cFBkF/eGcazh3h/fTjWYwb7asON
	 /YLg1tHGuQ52X0MYP8CoWk1OBn7cqbS5IuCOswohrjW/+xiRbSIgwP1UokHfDHfynh82L
	 g03ZgetDElKqb04GJDi1ZhUSg8+KceG4Oc/5J7I4Itm5eQjKws8zkDns2GNpwSFkenMhS
	 ffSdlnYvD/vk1CfoGetElpUb2S2Cro8Z82WLe+VPMAuc13Lv3F8HUAbVbr5cyvi6I6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985584;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+wwws9e1hdeNSE5v3XYCF7ze382+pNXAMb+VOr1nizs=;
	b=joiWc7bgvZ7+Y6IDTsiEAbKCz7pmuZDp3bCtE1ONoB8LNKZFjJYzc8Z7bOQqfbhSx/zh
	 /8cgatnwQt6cuuczdrOczheCIQuj5A0WhMHm0XSPWSqhhVOivbbKqQc5TkptxhMuCjact
	 KWPaO+r1UX/0fbC09siXTTTywZO7GE4pPmA45laMMe5pkx4qtlcC0lyFC4V9JcEj4CEuF
	 UOvk3kiPc6en77QRs33eS6nxIotYHT8bjHYhig1rlCGakXCcCtiWUGjgk5jPv2cRJTw+Z
	 sVy09t3Fqj/tYevE0ClQGpIC4OWvq3lCvJjbuVZosQmo7UIDE/0fCk68p1GPFv9pJQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJ25ENK6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A9606EEA5;
	Fri,  6 Nov 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJ25ENK6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B3D1F008A2;
	Fri,  6 Nov 2026 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985584;
	bh=+wwws9e1hdeNSE5v3XYCF7ze382+pNXAMb+VOr1nizs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJ25ENK60zr3aUbiilpTZ4CMW3lHO3jmwUoYRNEbh6lpKfvydTrM91PfpHh4SDcj0
	 37fi4gRdSsUJhyGCPekoKE3skGTCuUY2ISqznWl2ljbMf8XhXLs1ZmFpNQAeNIR1LJ
	 M/K/mL7s250eOBXuGrTk6gq/cUGuMiyPlQiBjgjKJX6MuIQpnU44FmyXsE6UmpJRFW
	 ssFpyzxIud1kE8g7W+mrtlPGghx/8nlT6ss1bzYsIyMpIGAr9PMMxHGW0/PoRVlR9j
	 ZdTlBx5RhhaEyTv3zjcn9pGeVedkN/wzQ3PFh4vgR949vTTgB8Wf89bRa/28uEPv8T
	 gkI9pC7CkyGvQ==
Message-ID: <sashiko-outbox-201910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/13] ARM: stm32: enable arm smc watchdog on
 stm32mp1xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106163429.618392-5-antonio.borneo@foss.st.com>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-5-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:19:43 +0000
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
- [Low] ARM: stm32: selecting WATCHDOG and ARM_SMC_WATCHDOG forces
  built-in config
--

commit 4450302b23f46b760d6b23f33c853eaddb3d821b
Author: Antonio Borneo <antonio.borneo@foss.st.com>

ARM: stm32: enable arm smc watchdog on stm32mp1xx

This commit selects WATCHDOG and ARM_SMC_WATCHDOG from ARCH_STM32 when
ARCH_MULTI_V7 is enabled.

> diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
> index 4ac3384e397aa..de09b2afa0f2e 100644
> --- a/arch/arm/mach-stm32/Kconfig
> +++ b/arch/arm/mach-stm32/Kconfig
> @@ -13,6 +13,8 @@ menuconfig ARCH_STM32
>  	select RESET_CONTROLLER
>  	select STM32_EXTI if ARM_SINGLE_ARMV7M
>  	select STM32_FIREWALL
> +	select WATCHDOG if ARCH_MULTI_V7
> +	select ARM_SMC_WATCHDOG if ARCH_MULTI_V7
>  	help
>  	  Support for STMicroelectronics STM32MP1 processors using Cortex-A7
>  	  cores. Note that support for the earlier Cortex-M based variants

[Severity: Low]
Does selecting WATCHDOG and the tristate ARM_SMC_WATCHDOG from the boolean
ARCH_STM32 force both symbols to y whenever ARCH_MULTI_V7 is enabled?  That
prevents building arm_smc_wdt as a loadable module or disabling the driver
and watchdog subsystem on multi-platform ARMv7 kernels with ARCH_STM32
enabled.

Could ARM_SMC_WATCHDOG instead use a default in drivers/watchdog/Kconfig
(the way STM32_WATCHDOG uses default ARCH_STM32) or be enabled in the
relevant defconfig?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106163429.6183=
92-1-antonio.borneo@foss.st.com?part=3D4
