Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2519463CB;
	Mon, 10 Aug 2026 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358619; cv=none; b=IberXFXeQqBvSX0c1mnAmDxzzdHngbHK08EVmB51g9umkOgVFgM7GhmUg5JDfgOBZd7wgpPVRb8jra1YPA+39cBLKNhkpG8MOywe9soCRmZNj/vH+42Sr8jFSLLEZksC9VgL73xgswoYx2cqLnajx1qOkP66hXVIhfUY+/3zSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358619; c=relaxed/simple;
	bh=epolczuAc7GxWGuU6Bvb17IYNH0UhTUkzI3167ryA9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyOzOXjF5H06c/Fk6I2Efz+2kem+C+xS7p4juk9GYrGsBTvT9UUrChaXAaaRzvSY1+6LEN1jkCWgTPDbyAIUYydKlrsNpTLJiuA2FeNwpBajRJ0/IFDhkSsES5gS2snZRDCcTYKPmQvXY77MvPFhUMhQdb9Q8+H3LbQfUXhvHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5YCJPqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5YCJPqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AA21F000E9;
	Mon, 10 Aug 2026 10:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358617;
	bh=GgZ70L0wlgjg35CbCp9eIm1NV7cv1FWYClANFiFsvW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N5YCJPqkc9MoVS1gejFwO5Or9z7HmV3NM0Y2+2quFgMl9VygR13TRpA7IMNitvcKo
	 m88VhiTNIhqNuaspNE8OFtVh3c/pD1nIxshzCJjjp1Qrgr32veAbtBXcX0ZMs0glcx
	 AgN0JdC63xjiltCUc4tAPnUBNty8g2K3u3C6gLxwFtworLqJR4dvoJyOthaJFrpNJA
	 dvIzaNqFRCsB0o2zqDQtw3GlRtUiWNTsn/2qeXj+WU9A9+HttMQS3vf9tKmLfa9zkV
	 WVBfGYDTdDk8mOAw5pL2i5pw/ug6l9VXaVcH/l+ASWR5pUN72MZKT88TF1TQdndszl
	 UY7KNvHFJY3Cg==
Date: Mon, 10 Aug 2026 11:43:30 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Ramiro Oliveira <ramiro.oliveira@advantech.com>
Cc: Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Wenkai Chung <wenkai.chung@advantech.com.tw>,
	Francisco Aragon-Trivino <francisco.aragon-trivino@advantech.com>,
	Hongzhi Wang <hongzhi.wang@advantech.com>,
	Mikhail Tsukerman <mikhail.tsukerman@advantech.com>,
	Thomas Kastner <thomas.kastner@advantech.com>
Subject: Re: [PATCH v2 5/8] Add Advantech EIO Backlight driver
Message-ID: <anmrUnA9fBfUCEYU@aspen.lan>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-5-76e5e41026db@advantech.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-upstream-v2-v2-5-76e5e41026db@advantech.com>

On Tue, Jul 14, 2026 at 05:54:19PM +0200, Ramiro Oliveira wrote:
> diff --git a/drivers/video/backlight/eio_bl.c b/drivers/video/backlight/eio_bl.c
> new file mode 100644
> index 000000000000..c2826400de45
> --- /dev/null
> +++ b/drivers/video/backlight/eio_bl.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Backlight driver for Advantech EIO Embedded controller.
> + *
> + * Copyright (C) 2025 Advantech Corporation. All rights reserved.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/errno.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/eio.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +
> +#define PMC_BL_WRITE		0x20
> +#define PMC_BL_READ		0x21
> +
> +#define BL_CTRL_STATUS		0x00
> +#define BL_CTRL_ENABLE		0x12
> +#define BL_CTRL_ENABLE_INVERT	0x13
> +#define BL_CTRL_DUTY		0x14
> +#define BL_CTRL_INVERT		0x15
> +#define BL_CTRL_FREQ		0x16
> +
> +#define BL_MAX			2
> +
> +#define BL_STATUS_AVAIL		0x01
> +#define BL_ENABLE_OFF		0x00
> +#define BL_ENABLE_ON		0x01
> +#define BL_ENABLE_AUTO		BIT(1)
> +
> +#define USE_DEFAULT		-1
> +#define THERMAL_MAX		100
> +
> +static uint bri_freq = USE_DEFAULT;
> +module_param(bri_freq, uint, 0444);
> +MODULE_PARM_DESC(bri_freq, "Setup backlight PWM frequency.\n");
> +
> +static int bri_invert = USE_DEFAULT;
> +module_param(bri_invert, int, 0444);
> +MODULE_PARM_DESC(bri_invert, "Setup backlight PWM polarity.\n");
> +
> +static int bl_power_invert = USE_DEFAULT;
> +module_param(bl_power_invert, int, 0444);
> +MODULE_PARM_DESC(bl_power_invert, "Setup backlight enable pin polarity.\n");

There is still pending feedback on the module parameters and I can't see
any reaction anywhere.

: Module parameters are not really expected these days and are
: pretty user hostile.
:
: Are they really needed? AFAICT this is a firmware based device. Why
: doesn't the firmware provide this information if the drivers need it
: (either directly or via PNP ID and a lookup table)?

Please don't ignore feedback!


Daniel.
