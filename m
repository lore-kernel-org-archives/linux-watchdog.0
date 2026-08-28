Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84023EAA0
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934333; cv=none; b=uUoy/byufrCeky18HjhWzrdb2EcJdBGQMR6jNZ/iFGeZEG722OuSGwTXYE5eiMrnFpJUBKuNqVUYxKmPRqU0zxNY1xipUISLIw3Eik4CGGAYSUcyqdZXv9DwbpIqMICbIDwrmahktpRQjyvymk3dvYhkfdSbF3rAVSzcld+kwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934333; c=relaxed/simple;
	bh=WhCHNaxVu65fVL9AapJkoqPtJRIU+awbo/EawfzynOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MJ6CXpDEQUS7HLRP258ULSd0v7CbcrBwZ/QIahFGjCJDhomx++J6WiSNG8k26lk4Kin82IExdVcfd1xc6ElHMRYKnX6toPGu+83ScjaNh5teOZ5h3Dpnj/L6PKuu2hxGOWT2WITV1mF9DiOFOrqgT19XEgj1fNGsjp62grvdh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS/0tqyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS/0tqyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA3A1F000E9;
	Fri, 28 Aug 2026 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787934331;
	bh=3qIF0NmplFqon4q8dCBqOED82Hhb3IgAxadS95tghaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AS/0tqyO0X4G3ikETnJ6dv7JAUousqL6m7V76Em6utJzPwM1LDwM2KyQxeklXVG8n
	 ZER6nsnlzMLEssv1ExVGxdqEblZgWR7SOdzSkLssICydqpReWXLgoPfwwFW1L0/pEU
	 Ppol19YJ/UglWon3d+037dDptjkbqq6yGf0tNs6mS5tOAELMz9hTwG1N50XOLfRr0v
	 DiAB1XLmFMpLP7FxvIBlEy+FhvQDUCF4Csgn6+BcjDwADAuGvKwlfHx+99/F7Q1OF9
	 V/ZE2EVeWhRJpkOzG+MiANH1tVxaOp/C/eVDrR0XfyNJd5j5++GShA2osJ3b+gwT/6
	 su7avTFg7Ab6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] watchdog: msc313e: Enable clock before accessing
 hardware registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260828161348.13212-5-tzungbi@kernel.org>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-5-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:25:31 +0000
Message-Id: <20260828162531.7FA3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Probe error path disables the watchdog clock without executing the=
 hardware shutdown sequence, neutralizing the fail-safe.
--

commit 0b66291f7c8412075decd0cc0b1b00209ced44cb
Author: Tzung-Bi Shih <tzungbi@kernel.org>
watchdog: msc313e: Enable clock before accessing hardware registers

This commit fixes an issue where msc313e_wdt_probe() accesses hardware
registers before the required clock is enabled. It adds calls to properly
prepare and enable the clock, and ensures the clock reference count remains
balanced if the watchdog is already running at boot.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index 5dc5e3ab7001e..86e72aea96855 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
[ ... ]
> @@ -145,7 +158,13 @@ static int msc313e_wdt_probe(struct platform_device =
*pdev)
>  	watchdog_stop_on_reboot(&priv->wdev);
>  	watchdog_stop_on_unregister(&priv->wdev);
> =20
> -	return devm_watchdog_register_device(dev, &priv->wdev);
> +	ret =3D devm_watchdog_register_device(dev, &priv->wdev);
> +
> +	/* If the WDT is running and anything goes wrong, disable the clock. */
> +	if (ret && test_bit(WDOG_HW_RUNNING, &priv->wdev.status))
> +		clk_disable_unprepare(priv->clk);

[Severity: High]
If devm_watchdog_register_device() fails here, does disabling the clock
without properly executing the hardware shutdown sequence freeze the active
watchdog counter?

If the bootloader armed the watchdog and the probe sequence subsequently fa=
ils
(for example, due to a memory allocation failure), it seems gating the clock
without commanding the IP block to stop would neutralize the fail-safe. Does
this leave the system hanging indefinitely instead of allowing the timer to
expire and trigger a protective reset?

> +
> +	return ret;
>  }
> =20
>  static int __maybe_unused msc313e_wdt_suspend(struct device *dev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828161348.1321=
2-1-tzungbi@kernel.org?part=3D4
