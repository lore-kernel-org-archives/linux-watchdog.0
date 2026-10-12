Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31077223328
	for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791766937; cv=none; b=C8ahqk0tKKopKbwAe23y2IPb3fZqxDgM1Iyi/SEf7JrYGbrIPvK5PbdAAvzVpEX3b8RrOBUbBAiqWbY1ZSWENOkSm7nGNpYZJxLQXwuNB78geDOQUrmiYd4mCSzMKdTqqGKvPm3jYTNzbuS/hR6B03QAXsQsNQa19dUdFYcRqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791766937; c=relaxed/simple;
	bh=+r/8D+CVM1YJUoi8qpMDtS6ek8WPkvqKqKcP+Lpvioc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Vf89O18V8vsnPA6P0EhDVKx5uOarQSgSUpnHGCbi7cijozqrqO5MzgCrYV6SqWIpzzCVDpDAMsfmP924FXhvtooqAVjFH426RP+xcY1aF6X85juvWOv1w/0VfeAJmZvcI1MfZSWaWSQho6XdQUh9VLad/4QuliFpdMwfaQX8f2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XehZpbXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XehZpbXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6AA1F0089B;
	Mon, 12 Oct 2026 01:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791766935;
	bh=vfRjEfjXk1mpN54Mo7HgQ//5AQUdtGFtgQdUVbg8aZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XehZpbXqTW9oSwD2C0MjBRjssKIe/oHVKgHldnOjlxO+ZLq/92TTPyUHNtd0puV2k
	 A+oXGOS27qWSBdzjimfahLACzBCd5D6MsR3rAP0lOvPaBhAa6fJHOOfZqaSdPb8SQz
	 QSM4Z9yiG+75f9ceop7Cw+qjzcunFzeThRJanYKqD512jv+7tcbalJ/RYENdjIbIuL
	 h5XnTmj7S9v8waNdCwOt+t3NIM1RNqQotCljyLD6H+5DJDMltY0r+yjFDXBYxMXMTh
	 R0aAqAOpSqH0XF0HsiHDUQOZjoPFOeLG/Igq4jnNPodiM4f3dCw418XmdaDRUuOG3X
	 jaS44CZt4YDzA==
Message-ID: <sashiko-outbox-167534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: orion_wdt: load the pretimeout counter
 on Armada 370/XP start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261012-orion-wdt-suspend-v2-1-f13cf71443ba@iav.lv>
References: <20261012-orion-wdt-suspend-v2-0-f13cf71443ba@iav.lv>
 <20261012-orion-wdt-suspend-v2-1-f13cf71443ba@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 01:02:15 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] watchdog: orion_wdt: global orion_wdt_info struct contamination
- [Low] watchdog: orion_wdt: TIMER1 clock rate mismatch for pretimeout on A=
rmada 370/375
--

commit dbf1fe3fb63d91004e0ddd635005322182202b47
Author: Igor Velkov <iav@iav.lv>

watchdog: orion_wdt: load the pretimeout counter on Armada 370/XP start

armada370_start() enables TIMER1 for the pretimeout but, unlike
armada375_start(), does not load its counter, so TIMER1 runs down from
whatever value it holds and the pretimeout can fire early. Load TIMER1 on
start the same way armada375_start() does.

Link: https://sashiko.dev/#/patchset/20261012-orion-wdt-suspend-v1-1-1676cb=
79e29e@iav.lv?part=3D1

> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 5d56e93f04064..ef64e37300012 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -232,6 +232,9 @@ static int armada370_start(struct watchdog_device *wd=
t_dev)
>  	/* Set watchdog duration */
>  	writel(dev->clk_rate * wdt_dev->timeout,
>  	       dev->reg + dev->data->wdt_counter_offset);
> +	if (dev->wdt.info->options & WDIOF_PRETIMEOUT)
[Severity: Medium]
Is it possible for WDIOF_PRETIMEOUT to be set spuriously due to global
state contamination?

In drivers/watchdog/orion_wdt.c:orion_wdt_probe(), the global static
structure orion_wdt_info is unconditionally mutated if a pretimeout IRQ
is found:

static struct watchdog_info orion_wdt_info =3D {
    ...
};

orion_wdt_probe() {
    ...
    if (irq > 0) {
        orion_wdt_info.options |=3D WDIOF_PRETIMEOUT;
...
}

If a prior probe on a device or platform had the IRQ, a subsequent device
that does not have the IRQ will still inherit the flag across unbind/rebind
cycles or multiple instances.

Does this cause the newly added code here to erroneously write to
TIMER1_VAL_OFF and mistakenly enable the TIMER1 pretimeout interrupt, riski=
ng
an unhandled interrupt storm?

> +		writel(dev->clk_rate * (wdt_dev->timeout - wdt_dev->pretimeout),
> +		       dev->reg + TIMER1_VAL_OFF);
[Severity: Low]
Does this calculation incorrectly assume TIMER1 counts down at the
divided/fixed clock rate dev->clk_rate?

On Armada 370, drivers/watchdog/orion_wdt.c:armada370_wdt_clock_init() sets
WDT_A370_RATIO_MASK for the watchdog, but fails to set the corresponding
TIMER1_DIV:

static int armada370_wdt_clock_init(...)
{
    ...
    /* Setup watchdog input clock */
    atomic_io_modify(dev->reg + TIMER_CTRL,
            WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
            WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
   =20
    dev->clk_rate =3D clk_get_rate(dev->clk) / WDT_A370_RATIO;
    ...
}

Similarly on Armada 375, the initialization in armada375_wdt_clock_init()
sets WDT_AXP_FIXED_ENABLE_BIT but omits TIMER1_FIXED_ENABLE_BIT, unlike
Armada XP.

If a user boots Armada 370 or Armada 375 with a device tree that defines the
pretimeout interrupt, won't the pretimeout fire prematurely because TIMER1
counts down at the undivided/unfixed clock rate, while the initial counter
value is calculated using the slower dev->clk_rate?

> =20
>  	/* Clear the watchdog expiration bit */
>  	atomic_io_modify(dev->reg + TIMER_A370_STATUS, WDT_A370_EXPIRED, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-orion-wdt-=
suspend-v2-0-f13cf71443ba@iav.lv?part=3D1
