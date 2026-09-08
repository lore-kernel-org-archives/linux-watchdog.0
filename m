Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FF3644A6;
	Tue,  8 Sep 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890175; cv=none; b=DuZ7QFqIip6x3rhQmCwj/sGaF7rsCKCRJVPzskEPBU3rHgDUU6egUkhsCHBDi8b0YDRE+M29HswPTMFM1P27g4L3IMHcN84wnuIbfYFKS12NXwnuU8FV2clpazlIEEI//xrj1tSdjQOYGPKVu/OXm8qIVTriY5HBx2Y8GHCN0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890175; c=relaxed/simple;
	bh=7CpfYdD6wSkzSISnVDK4ugnzxr9yteaP9YUMT4SB68o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tFek3iyCinSB+wCAscByOBD/fhwpNGkoLC6afkRSTCDAltUmqpcpgLNfgDOOcuUY9fx+c3I/g5CUOc0JlqugMOGvIiVCu9ymx9O1cwwD8uPm0F7yfMskX0HZEd2Uu052uUzsl/bPx9fNOIBbfKxvDmKb+TAhiIFmmKW9ndC9EJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPIgml/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPIgml/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8B01F00A3A;
	Tue,  8 Sep 2026 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890174;
	bh=fHW4NUKCl+SxZlSjchtGF48BdtW4437v4vLO4jGvVEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPIgml/i4QQ/V81JmfB4MPt8uxAfrxjiHI+D1tiDSYXNkHP5sxey7vpBwpP/KIL3P
	 se+S74oGjHUI6Uglsbx8MHnIGR4DC71goY7jueIXO8+JgPz6z4QC/Ay5Nvy+xeYj1Z
	 4zeHGoq1iU25bKBsgGE/GkRUAYKXF5sZ9O2iXXulXqHOFsbQ7sJ0M2dyyd103ZqCeC
	 hy5oFcpBCrsry9YybcsTm+6wiExFqwtf1nwrSTo2+J94NnBEnMF5q/UMfziBpTXeAj
	 Ci0Cm9BF0YUdNwWYbvfW3GdJDGzLrkeYHeUy2BqhtuvnPRrR474145x5guB/Ty9Koh
	 yJLcFigZKEAZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] watchdog: mediatek: Add support for mt8167
 toprgu/watchdog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260908174259.9009-5-l.scorcia@gmail.com>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
 <20260908174259.9009-5-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:56:13 +0000
Message-Id: <20260908175613.DC8B01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The watchdog character device is registered and exposed to userspa=
ce before its configuration properties are parsed from the Device Tree, cre=
ating a time-of-check to time-of-use race condition. This problem wasn't in=
troduced by this patch, but it remains unfixed.
--

commit 636d28c87d7152b3a57c046cb13f6a93c3f5aaef
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

watchdog: mediatek: Add support for mt8167 toprgu/watchdog

Add support for the Top Reset Generation Unit/Watchdog Timer found on mt816=
7.
Since according to its data sheet mt8167 toprgu reset bits are not contiguo=
us,
add support for a reset table to the driver. Also address a preexisting Sas=
hiko
finding regarding has_swsysrst_en configuration.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index d609f0fa35e32..abe58ed6a5045 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c

[ ... ]

> @@ -457,12 +493,14 @@ static int mtk_wdt_probe(struct platform_device *pd=
ev)
> =20
>  	wdt_data =3D of_device_get_match_data(dev);
>  	if (wdt_data) {
> +		mtk_wdt->toprgu_sw_rst_num =3D wdt_data->toprgu_sw_rst_num;
> +		mtk_wdt->toprgu_sw_rst_tb =3D wdt_data->toprgu_sw_rst_tb;
> +		mtk_wdt->has_swsysrst_en =3D wdt_data->has_swsysrst_en;
> +
>  		err =3D toprgu_register_reset_controller(pdev,
>  						       wdt_data->toprgu_sw_rst_num);
>  		if (err)
>  			return err;
> -
> -		mtk_wdt->has_swsysrst_en =3D wdt_data->has_swsysrst_en;
>  	}
> =20
>  	mtk_wdt->disable_wdt_extrst =3D

[Severity: High]
This is a pre-existing issue, but it looks like the watchdog device is
exposed to userspace before its configuration properties are fully parsed
from the Device Tree.

In mtk_wdt_probe() in drivers/watchdog/mtk_wdt.c, the device is registered
earlier:

	err =3D devm_watchdog_register_device(dev, &mtk_wdt->wdt_dev);
	if (unlikely(err))
		return err;

This registration immediately fires a KOBJ_ADD uevent. If a process opens
/dev/watchdog during boot while the probe thread is blocked (for example,
if there is mutex contention in toprgu_register_reset_controller()),
watchdog_open() will call mtk_wdt_start().

However, mtk_wdt_start() relies on properties that are parsed after the
registration:

	if (mtk_wdt->disable_wdt_extrst)
		reg &=3D ~WDT_MODE_EXRST_EN;
	else
		reg |=3D WDT_MODE_EXRST_EN;

	if (mtk_wdt->reset_by_toprgu)
		reg |=3D WDT_MODE_CNT_SEL;
	else
		reg &=3D ~WDT_MODE_CNT_SEL;

Since mtk_wdt->disable_wdt_extrst and mtk_wdt->reset_by_toprgu are still
uninitialized (false) when this race occurs, could mtk_wdt_start() configure
the hardware incorrectly, potentially causing a system hang instead of a
reboot when a watchdog timeout triggers?

Would it be safer to move the property parsing before the call to
devm_watchdog_register_device()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174259.9009=
-1-l.scorcia@gmail.com?part=3D4
