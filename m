Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57F5437CD
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953374; cv=none; b=hoZ+CjfWxkOVUM8Ga6v/M07H3lsyK4ct/ycxkwSUus/M5SMKu0ftIOazDoIewd4FaZn990ph+KQ1/bxpj5b7J/G1wlDXjOnu+2TG60dxY9M+B9Tvf1YBRt4RtrEQ0LX6O6CgB8nyUNdBT4UCrOVmzsMxYtUY7HaMuFiGkURxko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953374; c=relaxed/simple;
	bh=Ouf23ZMTBO/6EWl3g+HVMySkM9x4YqCLYUWtl5Sj0Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qEZscHW+XhBknSDUuYYudsGICq7MxV0vV/TKz8bf9inPEkYivPdHE9gnMFnFAHUZlbF8MaTNXnfoigY0HjzfVnTZbBhKL56WxfVRTz+8mPrrgBMnEJ5vyFv3xLn+8pYHCGup/Ju1lk+W8lUpivHPBWJEGmo1N5vJAqB8HY2j3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoDv3Tcg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoDv3Tcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1951F00A3E;
	Wed,  9 Sep 2026 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953372;
	bh=EX9NkEddBW01mSS6qhRdmfMaXP7BrX9U+5sZnwa2WXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hoDv3TcgGEYtoJb0WiVwBawZBmidN3pYFgCBcVuv08HUjH049+gWtJARW+rD7zaZy
	 AflduUPqxJH3d6/nRPP6VIZIoHjF2i8wHp8LhaBp/sO2ZHvQOBt9vm5ZpCiKXYcGRh
	 s0ftXWrq/MbCJeGnESvjNZs+vAYi8F6LJV0STIEQN2kXjIn4Rg1xNx3JEeUu9VLagq
	 kK8ZIk+zUXI0zk1+pfwWCysDc/qyxpyprz5/G8WV7Ni1+IbCO0APQ73TTqJ5h3lIe0
	 Z/UZSUdKH/HBosTOaptXv83vXnNmgk2tJ400Lalr0c9xTiZuAXy13HqHJbcEDd16iT
	 egoG8zZP0lydQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: i6300esb: do not stop an already running
 watchdog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <ea413e5d-9f37-46b8-8d93-863aa065a784@siemens.com>
References: <ea413e5d-9f37-46b8-8d93-863aa065a784@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:29:32 +0000
Message-Id: <20260909112932.6E1951F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] esb_timer_stop() returns a positive integer on failure instead of =
a negative error code, silently breaking watchdog core error handling.
- [High] Driver fails to enforce WDOG_NO_WAY_OUT when the hardware watchdog=
 is locked by firmware.
--

commit 558955a28d6872fa0e35bdd2eed150583051de56
Author: Jan Kiszka <jan.kiszka@siemens.com>

watchdog: i6300esb: do not stop an already running watchdog

This commit updates the i6300esb driver to detect if the watchdog was
already enabled by firmware. Instead of unconditionally disabling it,
the driver sets WDOG_HW_RUNNING and resets the timeout, allowing the
watchdog to continue running correctly.

> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index a30835f547b32..13daafe05c43c 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -264,13 +264,21 @@ static void esb_initdevice(struct esb_dev *edev)
>  	 */
>  	pci_write_config_word(edev->pdev, ESB_CONFIG_REG, 0x0003);
> =20
> -	/* Check that the WDT isn't already locked */
> +	/* Check the current state of the WDT */
>  	pci_read_config_byte(edev->pdev, ESB_LOCK_REG, &val1);
>  	if (val1 & ESB_WDT_LOCK)
>  		dev_warn(&edev->pdev->dev, "nowayout already set\n");

[Severity: High]
This is a pre-existing issue, but does this code fail to enforce
WDOG_NO_WAY_OUT when the hardware watchdog is locked by firmware?

If ESB_WDT_LOCK is set, the driver prints a warning but doesn't set
WDOG_NO_WAY_OUT.  Later, when the character device is closed, watchdog_stop=
()
tries to stop the device, incorrectly clears WDOG_HW_RUNNING, and fails.

Because WDOG_NO_WAY_OUT is absent, the core doesn't abort with -EBUSY.  Sin=
ce
WDOG_HW_RUNNING is cleared, watchdog_release() assumes the hardware is stop=
ped
and calls module_put(), allowing the driver to be removed and I/O regions
unmapped while the timer keeps running, leading to an unexpected system res=
et.

Additionally, this is a pre-existing issue, but does esb_timer_stop() return
a positive integer on failure instead of a negative error code, silently
breaking watchdog core error handling?

Looking at esb_timer_stop():

drivers/watchdog/i6300esb.c:esb_timer_stop() {
	...
	pci_read_config_byte(edev->pdev, ESB_LOCK_REG, &val);

	/* Returns 0 if the timer was disabled, non-zero otherwise */
	return val & ESB_WDT_ENABLE;
}

When the watchdog cannot be stopped (e.g. locked by hardware), this returns
val & ESB_WDT_ENABLE, which evaluates to 2.

The watchdog core's watchdog_release() checks for err < 0 to detect stop
failures. Since 2 is positive, the core assumes the device stopped
successfully, fails to issue the critical warning, misses the fallback
keepalive ping, and cancels the background worker, leading to an unexpected
system reboot.

> =20
> -	/* Set the timer to watchdog mode and disable it for now */
> -	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x00);
> +	if (val1 & ESB_WDT_ENABLE) {
> +		/*
> +		 * The watchdog is already running, e.g. enabled by
> +		 * firmware. Do not stop it, just mark it as running.
> +		 */
> +		set_bit(WDOG_HW_RUNNING, &edev->wdd.status);
> +	} else {
> +		/* Set the timer to watchdog mode and disable it for now */
> +		pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x00);
> +	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ea413e5d-9f37-46b8-=
8d93-863aa065a784@siemens.com?part=3D1
