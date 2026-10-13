Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF45391E52;
	Tue, 13 Oct 2026 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873642; cv=none; b=BsvMvspZdTeiTIlgMQxxaqNbduYV7ppbT887B2ovkMYFxsmrvRcDsOGBfcTnhvUuFzxGrtQFMhSsWBbGGWRd/XpsvLVbd+o496kBcWiH+hSAXAKUHydMWF66BgCIi77P/UBRCe8gEf6LCjgwHXXcIzNK7n5FiQkZ3kci6Qe89fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873642; c=relaxed/simple;
	bh=I1hF1bUG9AC3olm/4oyubqxWfcmKP8VTItSEbQMjqg4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hqMc2+RPNddq+9owdBMsoafNWjjoyPRbAy3AiakknPWiaDjQHQYLPBf6zrms4T9UtBJ5ZUAb5lXCgeRUYOYi9HI1clPWoXkYMa3pA2tza93x7fuY3jYfQR1uGCCZhVqtdUXl4xAwD/AlS6oiThXX7vT0D/5nTaxVEokpZMw/r2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSYr3XMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSYr3XMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB0D1F000FF;
	Tue, 13 Oct 2026 06:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791873639;
	bh=zaP6goXy+kbJbgj01DP0mrOJo7heO7XSLQ7ALEX07oE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSYr3XMaGEb5breTdAOPZBlsnVHiktueP5A2JnvYm4rZMpLCLJ12+5+evCcwqu8kv
	 j7CypyMo9Bpc0iJh6sjs0Rz7FV8oa6nSzb4BJ7RPSuZvEoGrF1+Wt01e1wHjjzSVrO
	 ZPP6KxlYNYmwEbRG9eu2UyWw0a1Tltcj4YR6y/qHp8KuaaxYCjzGUdDeUZlCSSgq4A
	 k1FXxBf/Clw1QNKmAm2IprwsiwibvC8Mby6gZNZ6HmyiG1A+TA3EXfmY57az7DsCvY
	 qgStMzn8pHsphK6vd3mpo+OgwQH0mY63E/awx8KFr5sk+GqNBB3ig0zoIhrX+kDieW
	 nVU6P10x8y0XQ==
Message-ID: <sashiko-outbox-169117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/12] mfd: nct6694: Move module type macros to
 shared header
Reply-To: sashiko-reviews@lists.linux.dev
To: a0282524688@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-can@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org
In-Reply-To: <20261013063259.2734757-6-a0282524688@gmail.com>
References: <20261013063259.2734757-1-a0282524688@gmail.com>
 <20261013063259.2734757-6-a0282524688@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:40:38 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mfd: driver-specific header modified in global include/linux/mfd/
--

commit d639c18480f1ac35c44ced9c53986d041709e15f
Author: Ming Yu <a0282524688@gmail.com>

mfd: nct6694: Move module type macros to shared header

This commit moves module type macros from individual sub-device drivers int=
o a
shared header include/linux/mfd/nct6694.h. The rationale is that the upcomi=
ng
HIF transport needs to recognise these module types. The change centralizes
definitions previously spread across several subsystems.

> diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
> index 69e4652cf16c4..d46ae34a497e1 100644
> --- a/include/linux/mfd/nct6694.h
> +++ b/include/linux/mfd/nct6694.h
> @@ -8,6 +8,15 @@
>  #ifndef __MFD_NCT6694_H
>  #define __MFD_NCT6694_H
> =20
> +#define NCT6694_HWMON_MOD	0x00
> +#define NCT6694_PWM_MOD		0x01
> +#define NCT6694_I2C_MOD		0x03
> +#define NCT6694_CANFD_MOD	0x05
> +#define NCT6694_WDT_MOD		0x07
> +#define NCT6694_RTC_MOD		0x08
> +#define NCT6694_RPT_MOD		0xFF
> +#define NCT6694_GPIO_MOD	NCT6694_RPT_MOD
> +

[Severity: Low]
Are these driver-specific module type macros only used by the parent and its
immediate children?

According to MFD subsystem guidelines, driver-specific header files should =
not
be placed in the global include/linux/mfd/ directory if they are only used
by the parent and its immediate children. They should be kept local to
drivers/mfd/ instead.

Does this addition of driver-specific macros to the global header violate
the subsystem architecture guidelines?

>  #define NCT6694_VENDOR_ID	0x0416
>  #define NCT6694_PRODUCT_ID	0x200B
>  #define NCT6694_INT_IN_EP	0x01

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013063259.2734=
757-1-a0282524688@gmail.com?part=3D5
