Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDC282F27;
	Fri, 11 Sep 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119028; cv=none; b=e6zbGXqBRozb+0JQNRvsWvVrEnfMIW4cCIxSqclJZ7r9vg5CKoBrC8saqYTtyw8+Jjg3kfsNpTC7fiftG0Q0mRByc8G9lUx+r6zhglMYWN8WNEs2IWC28DHG6TE8WvKn9jkx5VPqK/m+fu0gJ0ukCTkDZJlpKZ/3zQQLoYUA29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119028; c=relaxed/simple;
	bh=RPGKuScXWDLalqcznnbDC4l+YW1jyQ8ncbrQBOyrNcc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LgJXQlQ57kK8jI6MAhDmiceOaynIUd3gVDzDlsxxfJbv6XzQZCHjdqQg7NQt8Z2coJzDlaCaxbWsnmtyIIUNUhTMxy90pQGgCU0rDvz3uzUAwFzaoA4EFZMkwI/Lpv6xQxtpj6edVv+Xu3BUI0ZlKrqx8qGatzpvaJOSefrk1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1oe3cnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1oe3cnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDD01F000FF;
	Fri, 11 Sep 2026 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119026;
	bh=2G6FY5tHvOpNRNsJ06b9aP5e5b1LdPRXpG9wQ95C168=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R1oe3cnImXlW121+3KlCNlmh2tWJmkUpKMwFlY3ZtYdcEbOO3J9/a367bHnlxWCk0
	 DS5OnosJ+PCvymrTjTY2UYlVWsL3dJC88P5CA6pnXYROzDhZPiX6hkAKeRt0Wke1Yx
	 wlmGl+uCyAsIDojjOniAKfzRH9zIUDdw2j2FUvDJGREmv+wZ3mt52nfkP1XZt1oM9A
	 NRnPsGwuGTwrNVVpSLrWECWfYFHE67tfp24WErSSwsj6fQ2N7QUS7v1c3lpJsMQ/Hg
	 G3QxQAi3MllY/gTsRmFmQfuH6jnTIIHKeWEEh7HQ+y9NcCXIbct8VbdEom9KlkVljA
	 DV6O7ePV4DVNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm: dts: ti: omap: Prevent watchdog from being
 reset on kernel boot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260911-omap4-wdt_boot-v1-3-637d778a4a1e@bootlin.com>
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
 <20260911-omap4-wdt_boot-v1-3-637d778a4a1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:30:25 +0000
Message-Id: <20260911093025.DBDD01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch exposes the system to unexpected reboots due to a 30-sec=
ond window before the watchdog is idled, contrary to the '3 second window' =
claimed in the commit message.
--

commit 1abe23cd5472149baeeab9af481deaf65caccd1f
Author: Diogo Ivo <diogo.ivo@bootlin.com>
Subject: arm: dts: ti: omap: Prevent watchdog from being reset on kernel bo=
ot

This commit prevents the watchdog from being reset and idled during kernel
boot by adding the ti,no-reset-on-init property to the target-module node.
This is intended to provide a 3-second window for the watchdog driver to
probe without resetting the watchdog.

> diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/=
ti/omap/omap4-l4.dtsi
> index 4c78a0b28fab3..e061ea3fc8e70 100644
> --- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
> @@ -1126,6 +1126,7 @@ target-module@4000 {			/* 0x4a314000, ap 7 18.0 */
>  					<SYSC_IDLE_SMART>,
>  					<SYSC_IDLE_SMART_WKUP>;
>  			ti,syss-mask =3D <1>;
> +			ti,no-reset-on-init;

[Severity: High]
Does adding this property unintentionally cause a regression where the syst=
em
experiences unexpected reboots due to a 30-second delay instead of the
intended 3-second window?

Adding ti,no-reset-on-init skips the immediate hardware reset and triggers =
the
delayed work fallback in sysc_probe():

drivers/bus/ti-sysc.c:sysc_probe() {
    ...
    schedule_delayed_work(&ddata->idle_work, 3000);
    ...
}

Because schedule_delayed_work() takes its delay in jiffies rather than
milliseconds, passing 3000 evaluates to 3000 jiffies. On typical ARM
configurations where HZ=3D100 (the default), this results in a 30-second de=
lay
instead of the expected 3 seconds.

This could lead to a boot loop if the bootloader configures a watchdog time=
out
of less than 30 seconds and the system relies on the driver to stop it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-omap4-wdt_=
boot-v1-0-637d778a4a1e@bootlin.com?part=3D3
