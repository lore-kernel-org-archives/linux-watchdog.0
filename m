Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486757;
	b=tJg/XRXDJSRgxd3wtELWd1FZk3qVPMm0ea8VT5HmhM5mNbrGPyoFDTFyj1mfQNG8rhLx
	 AkGDx/wQGpyomaXE2mSbDfG7Pwe7W5cJrHzTmbfTf6teuPq8uUec1rX/3nlcpT5ov2xDI
	 J/UypY07aAtNl9ecW1iWJz+GpprJt5ULlK08ypHUZQ4CB/3OS8k2QO5AUD6xrmNer84CQ
	 k+PD5LqtTGfsyWkGIk+3t362QLTO+oFpgUBYle1Pd9XWkvZB7i7nUN2shHahSh3leOfaO
	 ktI+fRwzZsAVFSZJhso8nlmweDzoZeayIv0z0pSGNx2+lB8wHNIGh2GMiW14qjq9COQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486757;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A32ch7sVckNms2co5eK/FxJKJmTGDWzKAyjT0h90/xI=;
	b=GH8A09BeSqNnnfyTZIgdRNKh+uCrzx5I1SPEEXVxDSyROzWqZW+qr+34qUyhQoYBpvIo
	 esD8oW+fXjO6LHOPch1xU7xbkc9uRchGSpzrFa1/UxAWCPOlM0+6yMNQ+TGS6dM4eKiyi
	 Srp6Yvl8u4z1JhhRk6gVk0qL92ILLybUT3g+vwXBAsJFTkR9tVt4iWWyyyX/NPqWJbaSj
	 txzMzm/XHGoLwM6pMSXI5gXl3TmXBfifhB8V8tAaQGeQa3i/VkqRa71A4+tww2/G1Q2/G
	 1Df3RGA2sF/JJoHQLkEukzypnlui35304XGMG2AKCWKh68mUj5PKnqWLA5ZQ8IKDMyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W7oa7Qty;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FEA606A319
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W7oa7Qty
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140BE1F000C4;
	Tue, 20 Oct 2026 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792486757;
	bh=A32ch7sVckNms2co5eK/FxJKJmTGDWzKAyjT0h90/xI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W7oa7Qtys3Mm39QVY5rAb/tN3KAHl/3LxOhaIynfbk7HKq13He7W6loFVi0LOYU6I
	 yEgIADf7JS2lXimG7Ny5oQ4WxHOHyHSBLC2/L6iQMqgtY/IcgEfOnjJAb6RUQ0hjwh
	 PhbKsizBN5gARrrSrAly05dOYoIGGrVMmzhRibeMa1GULYzJdvRMviJ6s7cDRqBKZA
	 999LC6ppGje3DTFjR+t5onYtdzrpaDjoS6SBZFcPl+KUm/ULgJ4rmpH+m+V7JiS2Cs
	 61wqBb7kqefryddkbhfGhYNgnWuTN6oUjfaZu8s9Pxpw6tbUEY6NTNaltJHtWM5oX1
	 xyAxTkkb+9kwA==
Message-ID: <sashiko-outbox-178668@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] watchdog: w83627hf_wdt: Convert to platform
 driver model
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-2-90b226684fc7@bootlin.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
 <20261020-w83627hf_wdt-improvements-v5-2-90b226684fc7@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:59:16 +0000
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
- [Low] watchdog: w83627hf_wdt: format truncation warning in wdt_probe()
--

commit a96b55145c68318e10b7deaae2c19abda6f0df61
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Convert to platform driver model

This commit converts the w83627hf_wdt driver to use the platform driver
model with device-managed resources and adds error logging during probe.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index fa1808a4c6c88..96ea278e45c4e 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
[ ... ]
> @@ -462,6 +456,58 @@ static int wdt_find(int addr)
>  	return ret;
>  }
> =20
> +static int wdt_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id =3D platform_get_device_id(pdev);
> +	struct device *dev =3D &pdev->dev;
> +	struct watchdog_device *wdd;
> +	struct w83627hf_data *data;
> +	enum chips chip;
> +	int ret;
> +
> +	dev_info(dev, "WDT driver initialising\n");
> +
> +	if (!id)
> +		return dev_err_probe(dev, -EINVAL, "failed to get chip id\n");
> +
> +	chip =3D id->driver_data;
> +
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->info.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_M=
AGICCLOSE;
> +	snprintf(data->info.identity, sizeof(data->info.identity), "%s Watchdog=
",
> +		 id->name);

[Severity: Low]
Does this unchecked snprintf() call in wdt_probe() trigger a
-Wformat-truncation warning when building with GCC under W=3D1?

In include/linux/mod_devicetable.h, id->name is a 24-byte array:

    #define PLATFORM_NAME_SIZE	24
    ...
    struct platform_device_id {
    	char name[PLATFORM_NAME_SIZE];
    	kernel_ulong_t driver_data;
    };

And in include/uapi/linux/watchdog.h, data->info.identity is 32 bytes:

    struct watchdog_info {
    	__u32 options;		/* Options the card/driver supports */
    	__u32 firmware_version;	/* Firmware version of the card */
    	__u8  identity[32];	/* Identity of the board */
    };

Because id is retrieved via platform_get_device_id(pdev), GCC cannot narrow
id->name to the string literals in wdt_ids[] and sees up to 23 characters
plus " Watchdog" (33 bytes including NUL) being formatted into the 32-byte
data->info.identity buffer.

Would it be better to use scnprintf() here instead of snprintf() to avoid
the truncation warning?

[ ... ]

$>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-w83627hf_w=
dt-improvements-v5-0-90b226684fc7@bootlin.com?part=3D2
