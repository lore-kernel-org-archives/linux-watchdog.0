Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA934D929
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725191; cv=none; b=M2QF38y53ytT+ggVVvoutOwGzcCeOGLK6Dk3msHTa3Pj8py1oHBa8AfGWRsweDvtaEGZX6Ma3bwLQNMVJCXXJqFs2nygUrZq0NfAi/GgXN4OtzXb+FEOSHpDO3WWXoNz0lScpkxXJQQSdqCmIjSqRHbpC61ZA79/UYg7206DK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725191; c=relaxed/simple;
	bh=vF4ANGGePrHTyDHFGHzUGCSNt3C3WFnzYvFXQVVSMj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=APVN38luTmHBr2XjoWIvJ35aaLluKm7rJ9gc3Pl/EBjSKKFq1MWx9YAiIefrYAL8wm6oaDnFtsJNsx/6tfqryHHEN997HsSuiQmdBzyeW41zSU24Ve9lXWUgMYTVZ3gfa+z0HiiQ2zirMJ2vL2rrncqggLnOGrm+gCKgQmuqEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjrXrCZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjrXrCZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D7C1F000E9;
	Wed, 26 Aug 2026 06:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787725189;
	bh=JByl+JFhmu8DhW7y1HyLjVHiNmpLkd+CephrikFZLqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YjrXrCZhFX+07GeWesXtgPE5cOTbX5RkeCp5mbkX6M6zVfJaH6Zmeqm6GYWqmgxQG
	 d/04e3q//dCGguQdVg9ZHiZl8uj5Pt/0d+s7OAmarnAzo8pGakNCGmNmTRfZ9PQZig
	 9LylWGQKheh/zKU+x549OOBEO2tdkthAiMyyp/fGPBNWpq9lU6xyupeHQBYsMqUqSf
	 KhDid17TeSPYmkaMOMmVnyCAenW+mjjXAiBTkFNSZK5B31V4XOeFo5j65bbmwvbHsK
	 iyTnV1u9tKwlU6MI+EmAB4XAtgHT8EwnTdjtmlrc701NFRd5mWtDwWyowxV41QBxf5
	 b6m6TIdNcphZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] watchdog: stmp3xxx_rtc_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260826060839.203297-9-triet.hoang.dev@gmail.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
 <20260826060839.203297-9-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 06:19:49 +0000
Message-Id: <20260826061949.C0D7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect wrapper macro used for the dev_pm_ops structure pointer.
--

commit 1f11ea674c46c75875588fac7d892578dd01a7b5
Author: Triet Hoang <triet.hoang.dev@gmail.com>

watchdog: stmp3xxx_rtc_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

This commit converts the deprecated SIMPLE_DEV_PM_OPS macro to
DEFINE_SIMPLE_DEV_PM_OPS and wraps the pm_ops pointer, which allows dropping
the maybe_unused annotations from the suspend and resume callbacks.

> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3=
xxx_rtc_wdt.c
> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
[ ... ]
> -static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
> +static DEFINE_SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
>  			 stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
> =20
>  static struct platform_driver stmp3xxx_wdt_driver =3D {
>  	.driver =3D {
>  		.name =3D "stmp3xxx_rtc_wdt",
> -		.pm =3D &stmp3xxx_wdt_pm_ops,
> +		.pm =3D pm_sleep_ptr(&stmp3xxx_wdt_pm_ops),

[Severity: Low]
Is it correct to use pm_sleep_ptr() here instead of pm_ptr() for the
dev_pm_ops structure pointer?

According to the power management callback conditional compilation
guidelines, pm_ptr() should be used for dev_pm_ops structure pointers,
while pm_sleep_ptr() is intended for the specific sleep callbacks
(like suspend, resume, freeze, thaw, etc.).

By using pm_sleep_ptr() on the structure pointer itself, it will evaluate
to NULL when CONFIG_PM_SLEEP is disabled. If any runtime PM callbacks were
later added to this dev_pm_ops structure, they would be silently compiled
out even if CONFIG_PM is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826060839.2032=
97-1-triet.hoang.dev@gmail.com?part=3D8
