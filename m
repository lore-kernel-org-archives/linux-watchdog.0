Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609E41E6DC
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377613; cv=none; b=WjVcBaxBpOdnWnconPtIicYV1YbTn38lHU1GeziDIUdQZypwc1RCS35FGHSHhVdpSJ33hxDz2rZY1TMReh7DZxUdAvyMc60Jhpy8c84wU/hFPETTgZ9ivS8B2cEkfmz6izyJuM9mQzHKjwCK5HPVZ6lqBzCnPVopRoaON16RF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377613; c=relaxed/simple;
	bh=2kOKke2i7YAnCTUEEq2ZIV1X1J3RMj7upMqt1YLNlnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uYnN6uGK6aCp0CgpwS92ssHjbyAS1/bKoytFzwGafjRlenoSTUDNJUv4bHdQzeW4mX5my0P01TkRKZB3uBnOLtRjszfVcK1Uizl20nL9GSK7bdML7CJjqvxZDQRSMocxuqJsOWm2o+NLQLRxryGcl6b9e9GvIh0eEtZvrsEwSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DILdYFvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DILdYFvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B861F000FF;
	Mon, 14 Sep 2026 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377612;
	bh=s/sA5ngUYawD4STCbuul9srZPA6FTUPFQ8OUwBwBVMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DILdYFvzCUMq2svYqhzjjl5gR5Haur8z3eJrXFAIvHK9XRffc9jYjj8VqGbPFqKL+
	 xPu6qisjQw1mS0VDawWdPFId4qYAiWlSVcJHE9ZySok/S67RPaq1fJCSCyatmmPnGf
	 YusQ4sQlazm4j6cWF4/6pR77FT1RoJ2H754D8q5XcU1aTl8jQ/q08XUBiz4c5WUMxa
	 uXcvEBb72Q6O74qyzyarTjh/hKPOZtQ8TxSGW9azlHMBTKWdhvdlzQsgc9bZsquyu/
	 P/n7e9j3FWYTNqV+LbeWCNsxFsCISpZem9HTfW0xcD5xjut+fqlbxGwppcKKGz2ZGV
	 ljXbwnX08vANg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] watchdog: msc313e_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260914085451.891675-5-triet.hoang.dev@gmail.com>
References: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
 <20260914085451.891675-5-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:20:11 +0000
Message-Id: <20260914092012.20B861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The msc313e_wdt_resume() callback ignores the return value of msc3=
13e_wdt_start(). If clk_prepare_enable() fails, the clock remains disabled =
but the watchdog core state still considers it active/running. Subsequent w=
atchdog operations (like ping) will perform blind writes to unclocked hardw=
are registers (e.g., REG_WDT_CLR), leading to a system crash. Additionally,=
 any subsequent stop() call will incorrectly decrement the clock's referenc=
e count.
--

commit e0ef26398a011a110179678902a905e77bb75d61
Author: Triet Hoang <triet.hoang.dev@gmail.com>

watchdog: msc313e_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

This commit converts the deprecated SIMPLE_DEV_PM_OPS() macro to
DEFINE_SIMPLE_DEV_PM_OPS() and uses pm_ptr(). It also removes the
__maybe_unused annotations from the suspend and resume callbacks.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index 4a5cce2a16b18..a77ff57a44571 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c

[ ... ]

> -static int __maybe_unused msc313e_wdt_resume(struct device *dev)
> +static int msc313e_wdt_resume(struct device *dev)
>  {
>  	struct msc313e_wdt_priv *priv =3D dev_get_drvdata(dev);
> =20
>  	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev))
>  		msc313e_wdt_start(&priv->wdev);
> =20
>  	return 0;

[Severity: High]
This is a pre-existing issue, but does msc313e_wdt_resume() need to handle
the return value of msc313e_wdt_start()?

If clk_prepare_enable() fails inside msc313e_wdt_start():

msc313e_wdt_start() {
	...
	err =3D clk_prepare_enable(priv->clk);
	if (err)
		return err;
	...
}

The error is returned to msc313e_wdt_resume(), which discards it and returns
0. Because the watchdog core state still considers the hardware active,
could subsequent operations like watchdog ping perform writes to unclocked
hardware registers (such as REG_WDT_CLR) and trigger a bus fault or system
crash?

Additionally, if the clock remains disabled but the watchdog is still track=
ed
as running, will a subsequent stop() call incorrectly decrement the clock's
enable reference count?

>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914085451.8916=
75-1-triet.hoang.dev@gmail.com?part=3D4
