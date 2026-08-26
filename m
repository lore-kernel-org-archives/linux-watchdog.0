Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE4391E5F
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725059; cv=none; b=GV8XLEsWyex0Z3dBnyQyUZhdEIKCoEZfjMgw2kLKGjc6cAk235cnd0ra+rgHwnPIjyCWEWGLSFb6rL/ShV+cbq3YI7oSujIZNytRKlCW4Cwrfk3O6EGTmB/KdJhEC/ppgWqG3r2Wr7TRT19vFDRY4XEx1oamsUPf15vdYaQt81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725059; c=relaxed/simple;
	bh=7/Hkl6hky6v1bCmD5LO1eenabwX+FHGcgA0m5xBlE3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vf/mmjurocwEVCeAFXeOpNTYv2Xba97X5zYH5ksO6xJZ5dVHYZJppEkI1OeHueeAi/Q7dn5yy30CONy0eY8vW7rMlqMcFogwevE4smcntg+EVDxzBE5anbCYwb95GVosR9lJ4fPDgQdWNVNG3QfMvqiMvhSeXrcZcBDkbo8sZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHoAPN9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHoAPN9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6B91F000E9;
	Wed, 26 Aug 2026 06:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787725058;
	bh=BSh5wrfjySgRbdEgNNQJBcb7MIfl0vmuqEfS9FzObNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LHoAPN9/ngJtekOyQROIoo4mUPBCC+IwcGWWMOs0SudN7lgMFNB13j8V8SeAysmf0
	 ihd+xDog4BnH36oPeRLFMuuZZHArU72mAmpjz5JyEMpB/UJo5t6eqCXhASl3CgT3Bk
	 ZO40o1oPdIgGLO8ZyNJAP/LbswbOLHbnjj1+NrAROnEjNY08CgZA7tKb/7qlnFUWlf
	 eCpQLU/zhifvmh3gcs/QUMFIuOzhGmtAgHkgEGrhC7peVpywpKndVOlG0BrhgvC8lv
	 2Zr8OLNfayZs/ebP+c6G5sXu1iTjGPGo4eC0h+cUzwpAfOESL6hAc0Ed8Strvef+uG
	 CdmafdV24OjaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] watchdog: keembay_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260826060839.203297-4-triet.hoang.dev@gmail.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
 <20260826060839.203297-4-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 06:17:37 +0000
Message-Id: <20260826061737.EF6B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The driver uses `pm_sleep_ptr()` for the `dev_pm_ops` structure poi=
nter in the platform driver definition, which violates the strict subsystem=
 guidelines mandating `pm_ptr()`.
--

commit a755ace210f3814431fd01a8ffbd96e121f18dda
Author: Triet Hoang <triet.hoang.dev@gmail.com>

watchdog: keembay_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

This commit converts the deprecated SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and wraps the PM operations pointer with
pm_sleep_ptr(). This enables dropping the __maybe_unused annotations from
the suspend and resume callbacks.

> diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wd=
t.c
> index 2a39114dbc641..9424ea4155f07 100644
> --- a/drivers/watchdog/keembay_wdt.c
> +++ b/drivers/watchdog/keembay_wdt.c
[ ... ]
> @@ -285,7 +285,7 @@ static struct platform_driver keembay_wdt_driver =3D {
>  	.driver	=3D {
>  		.name		=3D "keembay_wdt",
>  		.of_match_table	=3D keembay_wdt_match,
> -		.pm		=3D &keembay_wdt_pm_ops,
> +		.pm		=3D pm_sleep_ptr(&keembay_wdt_pm_ops),

[Severity: Low]
Is it correct to use pm_sleep_ptr() here for the dev_pm_ops structure point=
er?
The PM subsystem guidelines require using pm_ptr() for dev_pm_ops structure
pointers, reserving pm_sleep_ptr() for the sleep callbacks themselves.

>  	},
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826060839.2032=
97-1-triet.hoang.dev@gmail.com?part=3D3
