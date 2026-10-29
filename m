Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285841;
	b=j1WfAjzpGQV9/RI+fkK7J23YsiLIw3WaQ7RIUm3UwzrKXokoLpOEM2KmVla8DgwP/XTq
	 voCEgRrKEOvgozbWqhBPgY9ZTf9wzNqvmQfz/h7pyuUlTjINmMVWqxBJyuXSgoPkXGyRR
	 LeLvuCujfmthGyFQGZTjb+b2XOuRVMqjxidtHumzyr1X1QZcS4tJd/GrusbN5C1jfAXjv
	 uRDXe3+fyETagfldkZD464hd8SCZcUyorHjoCkPMrDsV8//kECEiQQibVcuEb9WjGV8A1
	 jkTAwauasIy2OmCwHo4zHweI+zJzuJ6bwBT1E36baQ32gxMle6r1KfWpN1hJNzWMNmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285841;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U+2ydOmNxdFcp2uzdWp9Gv/U50gZkw/vvEZzNifIXlo=;
	b=SHPyURPqzcME2qfxc+j85CVPvWg/jIqEiKQWwLrdUtn7m1JqSo5lIIvTABtGSA74GuEv
	 nX7bC1mn/Q7ws9wIFDAqd7YVDVB94v1zI2TSLQ6cNEHyrb/VRZvSzgLim7KACb6L4Zi6A
	 ddo6HtaojH5eKh4+eqiP6HWqXNuoPagsoACtLXU/yqETmFBmPA8wCJCRNEu3ae+VS+4zp
	 svRJwAvQX2yBJLYzW9Xyt9AEZwAM+7cLDWa3AoyDZIu+B9YA5vJKEAY0+yKcQxily+gOr
	 8OXhZt5k0Ph5aXu4rVfoPN11D1qM+kWlOQ1ZvSDDz1CqwYY8LktehX7pztyUcp1nZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e87iFxTe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76785606A31F;
	Thu, 29 Oct 2026 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e87iFxTe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0E81F01825;
	Thu, 29 Oct 2026 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793285841;
	bh=U+2ydOmNxdFcp2uzdWp9Gv/U50gZkw/vvEZzNifIXlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e87iFxTeM3BaGTTSEFSGjZwq6NojB9gGZQIQHFRm/lUiarzF8f7u5ziby3ipkmH3Y
	 F2tLvGlte0ZBRGWJ0C0aNjshFcEGEq4B2x1NiW/Pc0KuneJKkqCXRQA7iCjaBmnxTN
	 Tuv2SnbRRzHp1MyZjVoe9q/C3x/yiZ0vTMHOEjp76V8nbR+Q42cY7DfU1SXc14BT0L
	 ITtq/r8Vg0WlI8fY9DY/ing+vwy9Kc9kOFayWUp9zIeJCN2pNRhwMA5Y7dibeSPHn9
	 Ok1ka4t6Y4J3B2YYtzhFZ3bzs8ppkZRJ5BMguHdebyD2LiyWt4ft+xWWaJVZEvmtkr
	 8nya3YnjoPQLg==
Message-ID: <sashiko-outbox-189560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] watchdog: aaeon: Add watchdog driver for
 SRG-IMX8P MCU
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFBlcnJvdCAoU2NobmVpZGVyIEVsZWN0cmljKQ==?= <thomas.perrot@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, imx@lists.linux.dev, linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, lee@kernel.org
In-Reply-To: <20261029-dev-b4-aaeon-mcu-driver-v9-4-f9b6d0cc180d@bootlin.com>
References: <20261029-dev-b4-aaeon-mcu-driver-v9-0-f9b6d0cc180d@bootlin.com>
 <20261029-dev-b4-aaeon-mcu-driver-v9-4-f9b6d0cc180d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:57:20 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] watchdog: aaeon: missing kernel-parameters.txt entry for timeout pa=
ram
--

commit 56cdb5c8b2505a3a5bbfb7ace81364353e737628
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

watchdog: aaeon: Add watchdog driver for SRG-IMX8P MCU

This commit adds a watchdog driver for the Aaeon SRG-IMX8P onboard
microcontroller, supporting configurable software timeouts via ioctl,
Device Tree, or a module parameter.

[ ... ]

> diff --git a/drivers/watchdog/aaeon_mcu_wdt.c b/drivers/watchdog/aaeon_mc=
u_wdt.c
> new file mode 100644
> index 0000000000000..beded3d6326fd
> --- /dev/null
> +++ b/drivers/watchdog/aaeon_mcu_wdt.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Aaeon MCU Watchdog driver
> + *
> + * Copyright (C) 2026 Bootlin
> + * Author: J=C3=A9r=C3=A9mie Dautheribes <jeremie.dautheribes@bootlin.co=
m>
> + * Author: Thomas Perrot <thomas.perrot@bootlin.com>
> + */
> +
> +#include <linux/mfd/aaeon-mcu.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/watchdog.h>
> +
> +#define AAEON_MCU_PING_WDT		0x73
> +
> +#define AAEON_MCU_WDT_TIMEOUT		240
> +#define AAEON_MCU_WDT_HEARTBEAT_MS	25000
> +/* The MCU cannot expire earlier than its fixed heartbeat. */
> +#define AAEON_MCU_WDT_MIN_TIMEOUT	(AAEON_MCU_WDT_HEARTBEAT_MS / 1000)
> +
> +static unsigned int timeout;
> +module_param(timeout, uint, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");

[Severity: Low]
Should this new timeout module parameter (accessible on the kernel command
line as aaeon_mcu_wdt.timeout) also be documented in
Documentation/admin-guide/kernel-parameters.txt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-dev-b4-aae=
on-mcu-driver-v9-0-f9b6d0cc180d@bootlin.com?part=3D4
