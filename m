Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4B36F901
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934133; cv=none; b=F0IzAxrxuAV3KNahuZgaE6DwQXLAssMOTqgM5kOEZnQDjU7OhN5uyFc44p4NEX0HmPA9GdpF2/1McVrJHElEcGKIahAyDJ8dCJtVlG8R0dxB9WOPblLAUY2Qy13K9Wh8lUMj1e32Qy0r0PFyy9IZnmZgdkEnTWOiWG5In5Nv4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934133; c=relaxed/simple;
	bh=tyFiqQHv7K4h/P8tdgaOHP4a0hWoZw3hxCe4MG6Hg5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TvvJSOMU3Ai9pTy4QDhRIyRH8XDHIfTyxqVauZK8xgX6MC4C20T8o7gvDDhE/ebukW23AU886sAbuQ/fg/lGAsYdmBew0Dpv4jkF6MdgE6L8fDHMlRJZPesNhGslyazRSX66D8+x6ftoMlBpVIfQ757mbuUB/l0R728EwXPWl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8ib6Ncv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8ib6Ncv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2881F000E9;
	Fri, 28 Aug 2026 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787934130;
	bh=w1pib72ZydQU1DuJjGEbUlKbk4FJiVYtg+HpqXI6byI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a8ib6Ncv6a6IeJxjYoHP44nhT/jFNvW0cOaDDGz6WOcd3mKzyDCZZkbd/iILpVMCZ
	 /HZ6jD9ipKaQ6pH9cEVBj/dq+5VdpaOmUMppAyX7ymVNEMvmYg+pi2bX/DNtylW1pO
	 iY7qaU/t2x6pfBctio3vD8j9FCVoITB/wPsICjCZyVkYjPw05SF9n5mS9xTvo4DisS
	 1RtTmKUPV7KnCzP1qgj5GXsEaUiMWcj5wyXqs/vyJPx9wSEjm1Ei2pSu16aQJJW7a5
	 VSxhfvmlCsp+zyePQaHYByzf8xIehixvphyitBdKfQhjZ7rJ/VKZv5fXHVK5bLBRmL
	 Q66KIEYf8xGkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] watchdog: msc313e: Sync timeout value if WDT was
 running at boot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260828161348.13212-8-tzungbi@kernel.org>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-8-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:22:09 +0000
Message-Id: <20260828162210.3C2881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Non-atomic update of 32-bit hardware watchdog timeout registers =
while the timer is actively running, risking premature system reset.
--

commit 6f0fb889160225480fa3164d876a1cf0757c5b2c
Author: Tzung-Bi Shih <tzungbi@kernel.org>

watchdog: msc313e: Sync timeout value if WDT was running at boot

If WDT was running at boot, the hardware timeout might be set to values
other than the final software timeout. This commit syncs the hardware
timeout to match the software timeout during probe.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index 72620adec641a..eea26c6c95d84 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
[ ... ]
> @@ -145,12 +145,21 @@ static int msc313e_wdt_probe(struct platform_device=
 *pdev)
[ ... ]
>  	/* If the period is non-zero the WDT is running */
>  	if (msc313e_wdt_get_hw_timeout(priv)) {
> +		msc313e_wdt_set_hw_timeout(priv, priv->wdev.timeout);

[Severity: Medium]
Could this trigger a premature system reset during boot?

This new call updates the hardware timeout while the watchdog timer is
actively running. Looking at msc313e_wdt_set_hw_timeout():

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_set_hw_timeout() {
	...
	writew(t & 0xffff, priv->base + REG_WDT_MAX_PRD_L);
	writew((t >> 16) & 0xffff, priv->base + REG_WDT_MAX_PRD_H);
	writew(1, priv->base + REG_WDT_CLR);
}

The two 16-bit registers are updated sequentially before the counter is
cleared. If the hardware does not shadow these registers, the intermediate
32-bit max period value could fall below the running hardware counter.

This creates a window where the watchdog might immediately reset the system
before the counter is cleared.

>  		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
>  		/*
>  		 * Keep the clock enabled. The watchdog core will skip the next

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828161348.1321=
2-1-tzungbi@kernel.org?part=3D7
