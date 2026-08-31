Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28B3BBFC2;
	Mon, 31 Aug 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192593; cv=none; b=sSbbV7EJHHPdC7Wy0oaW7GtLJEq3SwLABysTNc6UJne/PpJkmE5eQQKZjaIsx98RSgy9+IU8nsRieso+ACz+25HFQYjpBAngykP5fJLwL9XO9jUj5TenaS0egpGwBBdMHOEtFMfhpKiyVyxrnxKt9sWvDR5NC1sDHCty75WrTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192593; c=relaxed/simple;
	bh=1Rv8QqxJzJ36P6it8Tf4nXiRymDvKUaMVP5C/33zgyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AebUjbG7R96eIgrqRE3cQHsdlq8wEL1lUqqIdxSWOv+Vp1JFOqpZF80yq1WNlXZnHDutbioEHMdyUXaWZcSsKXCogkaPVgBxhqNjoPg5gPb3vccP17tsAIECYH781GLd9JHVVImDcKJW31pO7LoU2h4WqwJ9ylkzrlNe3YH1bkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ2b20Gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ2b20Gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A22F1F000E9;
	Mon, 31 Aug 2026 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788192591;
	bh=Ktz0TxxXjG2zfF/0hD+Ssp15yXv1Djs3KVXSNnhb7Gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZ2b20Ggu+Tt4ar6qW7yX8K/cjxk0l3TVG+yKpxaVk7q6iUPuVx3nZxeKNChZ+myz
	 CzlZKBJ4NE43EyG5KUaoqPEeoGtq07KTAslmu5qFkvOnhyfSLSVbBcUb40UIG90/7D
	 WfaM9V/qtXZqRYusKq89FgCb6OTaGG1jsTp8b/Ye5CBklAYhaiNomZU59N3H7I6U0C
	 h0mXznK2TwrxXYhJylsG6v1YUlpBbL4cJsWA1VA6AAIfewOAF8hxBke56wEIMvH1Ez
	 TL4aaNYF3iKVSF92PmlVcIpC17iF9kUDb88INmeVF4F6F7hbp/N/rt/JLKdAtrmLOL
	 hNQYXvClnMbRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] watchdog: imx7ulp_wdt: Keep WDOG
 running until A55 enters WFI on i.MX94
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: Frank.Li@kernel.org, linux-watchdog@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260831133314.4125787-398-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-398-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:09:50 +0000
Message-Id: <20260831160951.5A22F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware manipulation functions unconditionally re-enable local in=
terrupts and sleep, causing kernel panics when invoked from atomic contexts=
 such as the restart handler and noirq suspend.
- [High] Watchdog is not stopped during suspend if it was started by the bo=
otloader but not yet opened by userspace, leading to a system reset.
--

commit 3360fb6ec8b553a77597875579f51efb6523f1f5
Author: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
watchdog: imx7ulp_wdt: Keep WDOG running until A55 enters WFI on i.MX94

This commit introduces a hardware feature flag to indicate CPU low-power-mo=
de
auto clock gating support on i.MX94. It uses this flag to prevent the watch=
dog
from being stopped during suspend, allowing the LPCG hardware to safely man=
age
it.

Link: https://lore.kernel.org/r/20260206-imx94-wdog-v2-1-4dd725faec1f@nxp.c=
om

> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wd=
t.c
> index 0f13a30533574..33e5eb87e05e6 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c

[ ... ]

> @@ -359,7 +360,7 @@ static int __maybe_unused imx7ulp_wdt_suspend_noirq(s=
truct device *dev)
>  {
>  	struct imx7ulp_wdt_device *imx7ulp_wdt =3D dev_get_drvdata(dev);
> =20
> -	if (watchdog_active(&imx7ulp_wdt->wdd))
> +	if (watchdog_active(&imx7ulp_wdt->wdd) && !imx7ulp_wdt->hw->cpu_lpm_aut=
o_cg)

[Severity: High]
This is a pre-existing issue, but does this conditional overlook watchdogs =
left
running by the bootloader?

If the bootloader starts the watchdog (so watchdog_hw_running() is true) but
userspace has not yet opened it (so watchdog_active() is false), the kernel=
's
ping worker handles the pinging. During system suspend, the PM core cancels
this ping worker.

Because this code only checks watchdog_active(), it will fail to stop the
hardware watchdog in this scenario. Consequently, the watchdog hardware kee=
ps
running while the system is suspended, and because the ping worker is froze=
n,
the watchdog will time out and cause an unexpected system reset.

Should this code also check watchdog_hw_running(&imx7ulp_wdt->wdd)?

>  		imx7ulp_wdt_stop(&imx7ulp_wdt->wdd);

[Severity: High]
This is a pre-existing issue, but does this call chain trigger a "scheduling
while atomic" panic or break atomic context constraints?

imx7ulp_wdt_suspend_noirq() is called during the noirq phase of system susp=
end
with local interrupts disabled. It calls imx7ulp_wdt_stop(), which eventual=
ly
reaches _imx7ulp_wdt_enable().

_imx7ulp_wdt_enable() unconditionally calls local_irq_enable(), which breaks
the noirq interrupt constraints.

Furthermore, _imx7ulp_wdt_enable() then calls imx7ulp_wdt_wait_rcs(), which=
 can
execute usleep_range() or readl_poll_timeout(). Sleeping with interrupts
disabled or inside a noirq callback will trigger a panic.

Since this same path can be reached during reboot via imx7ulp_wdt_restart()
(which is also called with interrupts disabled), is it safe to allow
_imx7ulp_wdt_enable() to re-enable interrupts and sleep?

>  	clk_disable_unprepare(imx7ulp_wdt->clk);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-398-sashal@kernel.org?part=3D1
