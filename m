Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9D416878
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377118; cv=none; b=lUBlARCA6qVNKpMSr8UKLu3vFsq9NrGH7xCHdC6ZU0e1Nm6iyxFKadYMCvl5Cd8g9qwu+W4l5kyNGaRIOqp7G75pVHA19bQcY9Xx0Om3IPeM3DefSz92t+BpmrPfTuXUlLCq6QezrKXCIT5ar57YSoI2HwPjKQTSFk3EcFkwq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377118; c=relaxed/simple;
	bh=0d6Gilmw8apv4xv4lOqzuS5D0aAConixpO6GZwDwtTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PBr0QRV+z2l2mo0NWHG4AA/dcABqojUCq9eFSrV6OY3ZngzjwdgbuYU6pEqOPsdhyDfOFtCaSSVGSaJyh+gxR4xi5ioIPSqwCWThcl29+7CDj52wcftdmLM2JQaIxbHZ1yJqisHVnUIIVga17J/qzASUCnSE25GmkGtPADPsLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUvh1fgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUvh1fgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2C21F000FF;
	Mon, 14 Sep 2026 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377116;
	bh=N+aHkXidM1OoocQ5cM8tCwDigQvqRr13PMG9uhhTp8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IUvh1fgxTl8X245uREMXxlgcQEgtXWJr5YyX6Zp5X8hfrl6g8PcRNu1bwu0lsv0I9
	 S3rtPvXBp1s4ppOG6kjPGMna+8xjFlUliJ3Bew2c33KgF/Q9OT2YpqtZluSflO+ExQ
	 ppiVird86iC+PvDOl+qoFmIsWz1lmwq4LSbDVGqn/Z8JJsu7NGMpXEfKCmG2t4KsNk
	 AIaJKmIlkLhfsB3BCTcwRNLZFfXH2ozURUgBYzeaZe04ztRqpsUo1Ffag2QemNMZbQ
	 4H4C1m3DLbBDEOaYeCnSwWZ4DCcLOFu/nMxaCmAscPleGWz+oIDocVPcoRxQ+bML56
	 HngUnE2IZSjKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] watchdog: keembay_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260914085451.891675-4-triet.hoang.dev@gmail.com>
References: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
 <20260914085451.891675-4-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:11:55 +0000
Message-Id: <20260914091155.EC2C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch uses `pm_sleep_ptr()` for the `dev_pm_ops` structure p=
ointer, which contradicts the commit message and violates PM subsystem guid=
elines.
--

commit c35ef6ee0f1ec7517f550f44b58852af01504c3c
Author: Triet Hoang <triet.hoang.dev@gmail.com>

watchdog: keembay_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

This commit updates the keembay_wdt driver to use DEFINE_SIMPLE_DEV_PM_OPS(=
),
allowing the removal of the __maybe_unused annotations on the suspend and
resume callbacks. It also aims to assign the operations using the updated
power management pointer macros.

> diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wd=
t.c
> index 7c8e53921e407..2c187b20a5ec1 100644
> --- a/drivers/watchdog/keembay_wdt.c
> +++ b/drivers/watchdog/keembay_wdt.c
[ ... ]
> @@ -284,7 +283,7 @@ static struct platform_driver keembay_wdt_driver =3D {
>  	.driver	=3D {
>  		.name		=3D "keembay_wdt",
>  		.of_match_table	=3D keembay_wdt_match,
> -		.pm		=3D &keembay_wdt_pm_ops,
> +		.pm		=3D pm_sleep_ptr(&keembay_wdt_pm_ops),
>  	},
>  };

[Severity: Medium]
The commit message mentions converting to pm_ptr(), but pm_sleep_ptr() is
used here for the dev_pm_ops structure pointer in keembay_wdt_driver.

According to the power management subsystem guidelines, pm_sleep_ptr()
should be used for individual sleep callbacks, while pm_ptr() should be
used for the dev_pm_ops structure pointer itself. Should this be updated
to use pm_ptr() to match both the subsystem guidelines and the stated
intent in the commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914085451.8916=
75-1-triet.hoang.dev@gmail.com?part=3D3
