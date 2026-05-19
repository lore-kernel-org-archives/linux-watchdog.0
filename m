Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F852D1931
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216996; cv=none; b=BiDrTOZJNjL3GEufdYcRpXHGavPB+63RQxPoz9+dgRC95tINdUCBAzfLi+cJd66gw26NW3TH042QsOOMPk58bI7+Zew7jMwq5xxMbShPj+FvTIYxMXuMQH+KZDmXTT5sACL34NmZ5JuOmQP/PWEZspzFnB7XfbfM+Jxod4x4xeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216996; c=relaxed/simple;
	bh=RB72f/gznbYsJ3M1kzGys7Lr5ikZSaG0kn9VCcCRxmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QqEaXv8li9kUkwy22dEY2kOraP0Yfclu5DRMiqYPNaKX/lJVxa3LqVeOYtMbNB3u6lrS8ZAwi8STJZa8NS9MfcF3RiD+RftYlcAqnnPg8ACCGJavjBN3T/i7E103fwQ8q/bciVFgKP4apVJ1nN+ym9EZb5Jcog0/ylyZjkIOeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/e/UAMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/e/UAMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77AD1F000E9;
	Tue, 19 May 2026 18:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779216994;
	bh=AgyGRq39ux8n7MegIHTljlqkbXThF/1Q6+2Js4rM7uc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I/e/UAMdnelVwqVadLVjOuumueBiRH+Ia3TkUIqhH8w8sPh4KMtDQimRXQqgKDxjK
	 d+30fmpvhwETTtw7cS59R4N0nTX7bE1AL1ynyCv2zo/3HgULLLeY5VSdLQcCTblUIa
	 Tfo1Cgac5kOFffGUdFQ3pnNRGuXn5rAv6MUGaE7Lic+6LmFTNgWq4EIuWKdn+8sPsr
	 +ZRR2+IIlp/I1UEkQhQfaE1l243cn3n5SOMZRmaZo249+HDGmpBqaBqlhqUOh4PCy2
	 eRTJkyiz28pXu+haAek/RqLmI3PQU0M3CbI53kUMTbURxmrxjA/YPE4EDWo+ibHKlw
	 u5x3FhS5Cma/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] watchdog: realtek-otto: Change to use regmap API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rustam Adilov" <adilov@disroot.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260519182329.24472-2-adilov@disroot.org>
References: <20260519182329.24472-2-adilov@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 18:56:34 +0000
Message-Id: <20260519185634.A77AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `disable_irq()` in the watchdog restart handler can cause =
a system deadlock and sleeps in an atomic context during reboot.
--

commit 31e0a644ed16d3bca39871dd569420fedb50663e
Author: Rustam Adilov <adilov@disroot.org>

watchdog: realtek-otto: Change to use regmap API

This commit converts the Realtek Otto watchdog driver to use the regmap API
for register access instead of direct MMIO. It simplifies the code by
replacing read/modify/write sequences with regmap-specific functions like
regmap_update_bits.

> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realt=
ek_otto_wdt.c
> index 01b3ef89bacfc..504a7d379f4ae 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c

[ ... ]

> @@ -193,7 +183,7 @@ static int otto_wdt_restart(struct watchdog_device *w=
dev, unsigned long reboot_m
> =20
>  	/* Configure for shortest timeout and wait for reset to occur */
>  	v =3D FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, reset_mode) | OTTO_WDT_CTRL_EN=
ABLE;
> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
> +	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, v);
> =20
>  	mdelay(3 * otto_wdt_tick_ms(ctrl, 0));
> =20

[Severity: High]
This isn't a bug introduced by this patch, but since you are modifying this
function, could the disable_irq() call earlier in otto_wdt_restart() cause a
deadlock during reboot?

Looking at the full otto_wdt_restart() function, it disables the interrupt
before triggering the hardware reset:

static int otto_wdt_restart(...)
{
    ...
    disable_irq(ctrl->irq_phase1);
    ...

Because otto_wdt_restart() acts as a system restart handler, it is executed
via machine_restart() in an atomic context with local interrupts disabled a=
nd
other CPUs halted.

Calling disable_irq() invokes synchronize_irq(), which waits for any
in-progress interrupt handler to complete. If the otto_wdt_phase1_isr handl=
er
was running on another CPU that was just halted via smp_send_stop(),
synchronize_irq() will spin indefinitely, deadlocking the restart process.

Would it be safer to use disable_irq_nosync() here instead to avoid waiting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519182329.2447=
2-2-adilov@disroot.org?part=3D1
