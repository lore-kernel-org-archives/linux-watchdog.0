Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835986;
	b=fzR2R4rO9RkEsv0SR5+tcOnioaRmI3oFe7tCsgm56FGyJnQH4CGPve+CWbPJP5ZtysjV
	 AkGb21JnKZytRZVVf2mtj/+XZP3EyJxENh7zSwyyXgBBwPA93h6kj2nn5ALYxHsauSNB1
	 N3kOZFQOzBsnQt5Crz+LFVVLC20SjVmJr6vixVtywR41WZwl+uW1M4/ItrlcVArPhVf3a
	 oiFIxM1niq4QvfwDdLLSRG3FV4pZQ2NZ1FUejIB4gZIPTNpf3yQeDOv0woeSQfR3Mr8Bf
	 1sIGuw2JPQnGivPz5Ul/Jq00jliDepPr3yEhZ3cxyDBDXW7myFJTQKOFpGC2y/yC8jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eiPg2yCJFtYIWI6V2qwXsC2zqiNsNDI1WnG9a5Z8z1E=;
	b=N625gz/1bkJRTtC001Ghmn6kJqsF7N9rgT0nm5xFtqQ9+Mtt3mVS/dNhh3tkq6BMP0fy
	 lqJSs8gMIWat+F4i0lxaISRI+slG2UYY1JySZkwurIE1Kdig/lxov31L8xPY8KIxbja2+
	 0p2fH9yO2mi3QYvliY318W5LXwiSYkA1Vep2hRcK2+A0JYvi87aT1vPo4R0KsYilKRodO
	 wDKGnnasGHCPGA/cs4RUTtLvdBJuybHnPrQ6+/W3S21ZuD4+BJO1EbGbSRDLz0V0Bj+rn
	 8uIdHmscpPlamrMRAcjOjKJ1fDEtHZmTQNOJK7z7KihtQBd8lSSIeWfVjZNmC2I8rEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNyNWN5T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8D606A31C;
	Mon, 16 Nov 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNyNWN5T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE641F000C4;
	Mon, 16 Nov 2026 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794835985;
	bh=eiPg2yCJFtYIWI6V2qwXsC2zqiNsNDI1WnG9a5Z8z1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CNyNWN5TJzWm4zmc/VNLOI2msi6cYHO9nlu7uj5xJ+gyUpnC6KZd1azvclzG7e0lC
	 rMkoWsi9p5heWWo6ehX92Kw2GgQ/uRFejTm3AuV9ySuYSFj5QXFse1xNjYytC7Tko0
	 vtCom05aUEQOOQ3qcwVo6H2im3KyMG0gLD2K3iPEcGMd0G9QGDGEMq4FLpwV+CWQip
	 1inTWZfktvwGFZYMNetR4iWrpYsqIb/xdCSXy9eXhGrDc0CBEn9w9iuMT3xXvkgDKP
	 6anFNC9BVDI0ec7VZFJLBE4mVLx/fWpU1RDeB29omcl3e7PZy+DwXPJnGjXTu5g3GE
	 Gh8bWnvLaoHew==
Message-ID: <sashiko-outbox-217083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/15] ARM: stm32: enable arm smc watchdog on
 stm32mp1xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116132416.1184447-7-antonio.borneo@foss.st.com>
References: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
 <20261116132416.1184447-7-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:33:04 +0000
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

commit 8f27de8f1df1e95c22eb21ddbb73d67212964859
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

[Severity: Low]
As reported by Guenter Roeck on v3 [1], does selecting WATCHDOG and the
tristate ARM_SMC_WATCHDOG from the boolean ARCH_STM32 force both symbols
to y whenever ARCH_MULTI_V7 is enabled?  This prevents building
arm_smc_wdt as a module or disabling WATCHDOG and ARM_SMC_WATCHDOG on
multi-platform ARMv7 configurations that enable ARCH_STM32; enabling the
driver in defconfig or via a default statement in drivers/watchdog/Kconfig
(like STM32_WATCHDOG) would keep it configurable.

[1] https://lore.kernel.org/r/bf99b912-7a98-4d97-852b-45cb3c3c58be@roeck-us=
.net

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116132416.1184=
447-1-antonio.borneo@foss.st.com?part=3D6
