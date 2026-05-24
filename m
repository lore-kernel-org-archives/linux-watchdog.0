Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18ED15A864
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779588683; cv=none; b=khGEfANZQqRauSmjYCemHEEiFF0L99Hs4/hHUW2GgIp5I7kVKHQSuF0KM+P96mLyhIlXe1GxO66Xmcy9Gzzke0WioAUXBZZM87qN+QRfMrqoBoElcreAgmUdet4FCabV5l5zsH6rvNuJRJp8lTiqGjmrEuN2x/98mSdERUIscwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779588683; c=relaxed/simple;
	bh=8jj9KVvJihN31FTYq/CgBtLPxzvPR84K4VsO/cXj7ZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lmcT7D0uB/gmSnNHgOiw8cuPN3LeEnjx3hIVVA/c/ERjI794IpSVFxovbx+cO17+t5ZBr7ibnPinIgOOaFPvHmMkNrTY2wthWjbrG7bt1QEKMkGn3cIU+NKCNq1rtteWLD7od1KPr7Nhn4sUvl6a7MnM8CZy9jU3hnkiW6Thp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAvvVhob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAvvVhob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7236F1F000E9;
	Sun, 24 May 2026 02:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779588681;
	bh=rpeV3nByxKmnpOUPATxrPdMCrkOc4q4HfmcX3G4itOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAvvVhobRCzQRpap70dcXWOf5DsQnl8Mo51EXqnsttRZtm2TeOEAh0iSwxNp55wef
	 nXB73CZbkpaHSSrOfWRlQD9tEGq3yRrEMISJ/sQtBaJZ1ndlTNJ0ZQfaTcAS0bz68f
	 IKbprXjiL4y4eDPN6tESEfHRCJeCi/EpXc+OFiEoDyqFep9wb9b7lvsV7Vu4z+5caY
	 7ELDUZeyjlFlgIh2lFlzTXjKuDM6r41MycLqOhRqyww51vBx3R58Jrha6et8Hqvkxn
	 d+NkLiek6U8Zn4n802rUQqVMEH/WnaObtTU5m7wZ93hwztgLQUsLlEXX1vzsa0lEjw
	 VaSjrPxt0WV2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 1/2] watchdog: ath79_wdt: select OF and COMPILE_TEST
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260524015042.175271-2-rosenp@gmail.com>
References: <20260524015042.175271-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 02:11:21 +0000
Message-Id: <20260524021121.7236F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The global pointer `wdt_base` is assigned during probe but is neve=
r cleared on error paths or during driver removal, breaking deferred probin=
g and driver rebinding.
- [High] The driver fails to prevent concurrent access from open miscdevice=
 file descriptors after the device is unbound, leading to a use-after-free =
or page fault.
- [High] The watchdog hardware is not disabled during driver removal before=
 its clock is disabled, potentially leading to uncontrolled system resets o=
r hardware locks.
--

commit 71b88482365f22ded9cd7ae662eb7b028ce262ea
Author: Rosen Penev <rosenp@gmail.com>

watchdog: ath79_wdt: select OF and COMPILE_TEST

This commit makes the driver depend on OF in Kconfig, as it is inherently
an OF driver. It also adds COMPILE_TEST support for all platforms instead
of just ARM.

> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
> index 7df703e9852a6..409a40b149015 100644
> --- a/drivers/watchdog/ath79_wdt.c
> +++ b/drivers/watchdog/ath79_wdt.c

[ ... ]

> @@ -295,13 +295,11 @@ static void ath79_wdt_shutdown(struct platform_devi=
ce *pdev)
>  	ath79_wdt_disable();
>  }
> =20
> -#ifdef CONFIG_OF
>  static const struct of_device_id ath79_wdt_match[] =3D {
>  	{ .compatible =3D "qca,ar7130-wdt" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ath79_wdt_match);
> -#endif

[Severity: High]
This is a pre-existing issue, but does the driver properly clear the global
wdt_base pointer on error paths and during removal?

The wdt_base pointer is assigned during probe, but if a subsequent
step like devm_clk_get_enabled() or misc_register() fails, wdt_base is
never cleared.

When the driver core later retries the probe, the initial check evaluates
to true, causing the probe to indefinitely return -EBUSY:

drivers/watchdog/ath79_wdt.c:ath79_wdt_probe() {
    ...
	if (wdt_base)
		return -EBUSY;

	wdt_base =3D devm_platform_ioremap_resource(pdev, 0);
	if (IS_ERR(wdt_base))
		return PTR_ERR(wdt_base);
    ...
}

Similarly, ath79_wdt_remove() does not clear wdt_base when the device is
unbound. Because devres automatically unmaps the memory, wdt_base is left
as a dangling pointer, preventing future unbind/rebind operations.

Should wdt_base be cleared on error paths and in the remove function?

[Severity: High]
This is a pre-existing issue, but does ath79_wdt_remove() prevent concurrent
access from open miscdevice file descriptors after the device is unbound?

The driver uses devm_platform_ioremap_resource(), which automatically unmaps
wdt_base when the device is removed. However, misc_deregister() does not
revoke existing open file descriptors.

If a user space application keeps /dev/watchdog open and calls write,
ioctl, or close after the driver is unbound, functions like
ath79_wdt_release() or ath79_wdt_write() will dereference the unmapped
wdt_base pointer.

[Severity: High]
This is a pre-existing issue, but is the watchdog hardware safely disabled
during removal?

The watchdog hardware is not explicitly disabled before its clock is
disabled. Because wdt_clk is acquired using devm_clk_get_enabled(), the
device manager will automatically disable the clock immediately after the
remove function completes.

Disabling the clock while the watchdog timer is still running leaves the
hardware in an active but unclocked state.

drivers/watchdog/ath79_wdt.c:ath79_wdt_remove() {
	misc_deregister(&ath79_wdt_miscdev);
}

Should the timer be stopped explicitly before the clock is disabled?

> @@ -309,7 +307,7 @@ static struct platform_driver ath79_wdt_driver =3D {
>  	.shutdown	=3D ath79_wdt_shutdown,
>  	.driver		=3D {
>  		.name	=3D DRIVER_NAME,
> -		.of_match_table =3D of_match_ptr(ath79_wdt_match),
> +		.of_match_table =3D ath79_wdt_match,
>  	},
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524015042.1752=
71-2-rosenp@gmail.com?part=3D1
