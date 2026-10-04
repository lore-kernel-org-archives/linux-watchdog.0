Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502221FF29
	for <linux-watchdog@vger.kernel.org>; Sun,  4 Oct 2026 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116489; cv=none; b=q2+qVbTRuQnZV+SrdGbftpun64rVFHT7R5TTx3BwSGyzSX/AkLLvJXSluIZ4P/n3JY2xrbQ+ZCXsS0XivRGyRrKcN5OMssLLGd94PhCM4lLfgUXL5v/V93W/hX1XGD8JeqhE+bh9kdX9vtClBNWHcOW8mnntAknVUBorCUN+5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116489; c=relaxed/simple;
	bh=5BVdYmK8g0+EhyCfPHRbY0DNIIi0YKZFHHKMZ0SiWaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EWZ4woj4Ky4PQtNQv21wUv0W9Xd8545uJqEdR1QCcT1ciDXlwRMpRdZZ3GnmS9y9gYgViVe+bqCX7+Aq+RJFNfTty4KlBbDOT+EiVk1lkAvWeFC+hz/offXjaIdOdDoTMo/YwoNKtAelzofvi0X16zQa1zDEOuBgxrWmI1CwvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ9C1bcv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ9C1bcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492B61F000FF;
	Sun,  4 Oct 2026 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116488;
	bh=UWrSFUq0UJRVw9GlM5BMgWsI/BTgqLrnR8VoCxZLsEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZ9C1bcvgJ3QjNNT+MVO7bg+iihr3QLbCEG4qXAyFYDuXcW4HS/UNnlC19lPFLVAc
	 DZuw1kr8W4h56bhZkcbAFMVityuL5e9q3F5gK7q8NgxTpLN6gqPi4bRn35aQ6XrnjV
	 45hJk7tITF0BwUAu8ABIrEyvdaa8QzFLSefnDQ0H9elKsI8xhd+Y2p8xP4MHIIKRRe
	 4In/rKmEyF8iV0ftqd0s8YuDci7TRk84ZYfdOHzIV9Cq1DI6sSOOkmsbfI9XhtdF32
	 1dxois7ZyTJDDyMBmMsk4fWkJQs9vQdwn1D0a4EDRktt3HyA4WOrXQvNll20ynH07B
	 Gttc69MKdi3lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] watchdog: w83627hf_wdt: Store Super I/O
 configurations in platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-4-8e27b518595e@bootlin.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
 <20261004-w83627hf_wdt-improvements-v3-4-8e27b518595e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:21:27 +0000
Message-Id: <20261004122128.492B61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] watchdog: w83627hf: macros implicitly depend on local variable base
--

commit 7755bf14a50c6dd55f8caec9bfbe7bfcc9d7de23
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Store Super I/O configurations in platform data

Instead of using global variables, this commit stores Super I/O related
configurations in platform data.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 44ec2f2e23eab..1ef7b61d7e558 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
[ ... ]
> @@ -76,9 +72,8 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at bo=
ot time (default=3D0)");
>  #define SIO_REG_CONF_ADDR0	0x2E
>  #define SIO_REG_CONF_ADDR1	0x4E
> =20
> -#define WDT_EFER (wdt_io+0)   /* Extended Function Enable Registers */
> -#define WDT_EFIR (wdt_io+0)   /* Extended Function Index Register
> -							(same as EFER) */
> +#define WDT_EFER (base+0)   /* Extended Function Enable Registers */
> +#define WDT_EFIR (base+0)   /* Extended Function Index Register (same as=
 EFER) */
>  #define WDT_EFDR (WDT_EFIR+1) /* Extended Function Data Register */

[Severity: Low]
Does this code implicitly rely on the calling function having a local varia=
ble
named base?

This isn't a runtime bug, but the patch replaces a global variable reference
with an undeclared identifier. This creates macros that rely on a magic loc=
al
variable name base in the scope of the caller, which can cause build failur=
es
for future developers if they invoke these macros in a function scope that
lacks this local variable. This pattern is noted as an anti-pattern in the
Linux kernel coding style under "Things to avoid when using macros".

Could base be passed explicitly as a parameter to the macro to avoid this
implicit dependency? For example, redefining them as WDT_EFER(base) and
WDT_EFIR(base).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-w83627hf_w=
dt-improvements-v3-0-8e27b518595e@bootlin.com?part=3D4
