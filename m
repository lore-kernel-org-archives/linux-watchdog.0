Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785E438473
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323048; cv=none; b=scrY7P07HMZinxB6H0mG1lNMjA27YEWyCSkbUp6YbAWD0SCRuvVt0qJUn79m/qCvk5oDsrBT/U5DnGJeDjZz9Ng4/C6nCCO6k+oasY21rovQPIDRQb2vBNVNwmFVl5AD6OaqOGdIMAmX1AHna3Jh5XUal21LPA1u5pgaaypVr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323048; c=relaxed/simple;
	bh=bE3P099hp01+Ia9RpIP7b4oHr8qSg7lJsuzsx7BqUy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kgeSKE+MXo7vlDknN+cx6YLNAnqLB6l6zon21xoTl7Bs0Gby7BWETs6b4QDpWCwgMJw6xo3yTSkqF0/u35ZgI7Bqc/pJZ7hx5fooP5u7LggR1jBIBGANmofkSyhpMvIy218zSh9OvPeU+9w1Fk94PAfks9TvXCg9kbJQ9/C91Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5QnZkbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5QnZkbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A6B1F000FF;
	Fri, 25 Sep 2026 07:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790323046;
	bh=DpFwXHNrGQh4lwAfg5As30dfbw+dtuQuseklUOAgydA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5QnZkbbd0Ub8A5OC7zOda34q0Pzchd5zun9tkhL0uWDf+n75p4uYRTG6R7IxvP4L
	 QpO32cX+jXAvjCwU3M/k/5ecy9z42KCmOrJ5T/aWn1dKy3UiF763vjnisenaniTWBy
	 z4xX616tpVDUs5sDsZv0X89rse1sopuGnrRrQPn0oMGoM+venyBAbHKcY4j4cdttBF
	 L4gBlY9JZgSQyjZSohwaWRiZmIyD4ugN/WgToO0sBlFPBXXXutj215fLYq2+TT1Q2t
	 5yZdHYH+vAvcpuUzF8S04xMXfbh/W9PtjrGL4gEF3qUs35/6e5C+JKB3M3iTIMRYtj
	 cFyF3tGJTxTEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/11] watchdog: sbsa: Handle IRQ probe deferral
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-8-2c62125d0085@kernel.org>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-8-2c62125d0085@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 07:57:26 +0000
Message-Id: <20260925075726.B0A6B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: sbsa: system reset due to unserviced watchdog on probe d=
efer
--

commit 82d6b6d0cf8ddd44758931db5360cd8439795f6f
Author: Lorenzo Pieralisi <lpieralisi@kernel.org>

watchdog: sbsa: Handle IRQ probe deferral

This commit handles probe deferral when mapping the IRQ for the SBSA watchd=
og
by returning -EPROBE_DEFER.

> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index e04d42cc7774d..f4491409caf5d 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -352,6 +352,8 @@ static int sbsa_gwdt_probe(struct platform_device *pd=
ev)
> =20
>  	if (action) {
>  		irq =3D platform_get_irq(pdev, 0);
> +		if (irq =3D=3D -EPROBE_DEFER)
> +			return dev_err_probe(dev, irq, "failed to get ws0 interrupt\n");

[Severity: High]
Does returning here during probe deferral risk an unintended system reset?

If the bootloader leaves the SBSA hardware watchdog running, the driver
correctly detects this via status & SBSA_GWDT_WCS_EN and sets
WDOG_HW_RUNNING.

Because we abort probe registration here, the core remains unaware of the
device and will not ping it.  If the deferral period exceeds the hardware
watchdog timeout, won't it expire and trigger a reset?

Previously, if platform_get_irq() returned -EPROBE_DEFER, the driver fell
back to single-stage mode (action =3D 0), and successfully registered the
watchdog, allowing the core to immediately start servicing it.

>  		if (irq < 0) {
>  			action =3D 0;
>  			dev_warn(dev, "unable to get ws0 interrupt.\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-acpi-stati=
c-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org?part=3D8
