Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03053449EA6
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128741; cv=pass; b=HcTghC8vsYjwvs0qijEsPZV08dN9ncLRuTPSrC9qx5HAEafkn85jmFEEICDyDyKyUtRPvcvXFXDmTADkO3D0lHf4GusihF8pQAuuMDslunbSAIDl4sQWOmJZSBl463K+5Wk/VriANnRzzy7XuSOTnmqZacJFe3EPOzo8Lag/RCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128741; c=relaxed/simple;
	bh=y0XIFCeENQJqN8g/vbt7VAjbJq+Nz3Xv9yF4zfVVk+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwEs5AJf3BpLZIND30mQdg3yPWBpWbvObyNaaY5Di50o6DQP893Q5MG1U5x5+WkrJF7J3k1eV8abNSh/iYTFCGWZy4l+W/JN7C9NRFaFedPFlq2Py8SS/M2uG8dfQokbkwX8oTiLoXZc3RCCSEJBZZIBNBhoXpusrBgWO3lixhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5qY8lxc; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5qY8lxc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so4290565e9.0
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 05:12:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789128737; cv=none;
        d=google.com; s=arc-20260327;
        b=UOkLNs+FmDWnl1FU8YbvsjiTlRH/3WNop1KO/3Bq/yM7/mqsglh8izWtBNyTaauGLQ
         2Bjmt671zoVSVVXF9eZLzJAWT6tQ9N4jgAjTCeOvmb/BNoIPFw1CpuK7Zh98nXewVBGD
         oJiVKdGcRiN4fwyZVaZgcKqEatVwTCYRAVIEh1kBU02P7PzkkHseYpi2wHyGXSmdbGm8
         fGQMMQxgLx2LuvZ0C048+H7gbVRakiW2lePqEHSasphx//Kafyu5FokoCO6KtIGigcUJ
         mj6p0s3GKlpggJ2gpwnGmCW/4pjRvyaiqpa80xl1xVMoNnAbLSCWHLnPkT9WYOLg/IDD
         qHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNwnWJHPLgasWdBDmLTUGAni7FNn6xt21s/9H9MyjEs=;
        fh=wPum3L4ni45aDTvg/4LnH0ChDi6pfoRyhYKL8YRQwR8=;
        b=j4E3CXkGGtWAk1oi1AXIl0G6w3hU3Ad0cw3Nk2XFJYIom5CZ25zfo5aH7ssnZpbvJ3
         2E8uQ9aVy4sQGTEGStdk4i+ijl4zKwSaDwg8zOW0JA53Iznm+RHaygqMbdimjPXtPL/A
         +1uF7Qi+/4oN6odj8iJqixyEMSnMI0eWOId3NJFc8SOz4zFyAr2Wm87YAgmy64v6X3HA
         fn2dgfPI+p8/lmrEY8qj15TRKJVn7/bWrn+M+siJUeUMJIuJoGMxXDh5wYn2/QTyfmvW
         Gwid0MPvfvn/bJufgCOTFjGKrk0KEZuTVmLBOaivG653myFctcyk/8TkCBSrDQSgcq+z
         1DCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789128737; x=1789733537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lNwnWJHPLgasWdBDmLTUGAni7FNn6xt21s/9H9MyjEs=;
        b=V5qY8lxcYRx5ZkIgRmvJ9ikvQM9tfa1YVpHh6YCgYiAmdE6HSAt5KOhaMYdaJQQzCa
         Hj8dI0T54rgkj+2XeN0gpFjo6DOZTdu57sTzoCn3XKHn2mBfyk+agK9tVCBoAb0iXt17
         C2toev6+JdfrF7feTUBAheboKY64UOpMslY9Lm4C+7aN9yKRFPFwgGh6YdYrnG8YAijH
         46Kl1Dmxsbwmn+KtFd6qxEFx8cf3gsjhCjpQFjkLcyrBkIgJGbf9LFt2qbLk+aT8dosn
         sVjlm3KmBoAKqRT0EqZVfLydjEQTE+uKcqmtqBAvS5bFW0KntWKPlVV9CSwsCPir5FBt
         9XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789128737; x=1789733537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNwnWJHPLgasWdBDmLTUGAni7FNn6xt21s/9H9MyjEs=;
        b=QT0RuCgk7A4rf8Ofg/UFLR6cmuxLNzKlP1RVbh7lfXpA7HKBfQ1/QZoEFfzj5bkSbs
         XQ0o10bvMJrzhO06MYN5BepT8ZfUs+fnwRFK8PByazC0cf0Gaql0S6zf1o5bltR9cg13
         XXMtv9MGMWFcyxnMQTAH0BwMxSSTR/mwXp8AzY6jOSlC41jQhoy+MwH7y/O1ZZijiUyt
         5kIIa8VFJZRQB9uRypuf24Tvy3wQBbCKy1h+/hcycGR4dplSSPWiGVrNpsvEVpJ1dxqm
         46H955JINi5u6asBBR8Sj2dW1S/PrrZ46b0UELFhyIXrRF+TOkbRIrpZN08S3TKs8C0j
         UILQ==
X-Forwarded-Encrypted: i=1; AKwUvBx15I+lyxhLlzkEHqwyM5NjGqtzk31Uc+fPNeA0cPrOu3I+sePqqdm++xsR1iQCAzeE2JOYKBKpRys1c1e+xg==@vger.kernel.org
X-Gm-Message-State: AFuF++m8Z5nwPk8MMY+XpeutozZBXnPQCLQosu1J/ZZpDIyPJF1fNI8f
	rk1fJe2jl6cI8T5RYX89FoQRraMW1USbSMEgqXGPcNVv9sPLWWpg/axwrvJoUgdTnAPRPB94ChC
	iqU2b8rLv6Ca4W4upAb/XHjBY+fqNifk=
X-Gm-Gg: AYBFou0qjSJ7PQo0tznY9AD70gAmqcJ9z3Jij2BAKS3E/Y1uky5F5MrkA5xULw/toTn
	WZWLhdVQlkU0KmD9BG+dtFo2+uRdleIz/uE9J2+jV50QYuzuF7l8TF6AUjCqysUgfwVIwQSMcKu
	LAU+GlrpLUj+fuBGP8CipIdiTQIo6Rm/UfYehAItxFKem0Z7Lsdw/rbhxKXYbtaK60MXB+lRqTv
	61F0bWnUyS1X33RhFkJN0sUlxW7bcEReKU/slYZMHXItlVvkcZ0nNaX/Z+1fmiHr32ZxgYanXXU
	/j4fF+d+fGkeyAhQmrq3eFJ3BwGkQ8+5kbwCm+x7M23h/bcPcQDNOBAPQ5DEBwxqmL1NllJ3p7P
	bFSb2G8IE60dnxJ1JWcAwkW4radxoRW7PDHdzY38+ILymsyIYs8wjiKVzWq+mz0EVUZWXAmsEb0
	5ekvK0OnH0
X-Received: by 2002:a05:600c:1385:b0:499:a5c8:c6f3 with SMTP id
 5b1f17b1804b1-49e61878ab9mr68367055e9.3.1789128736767; Fri, 11 Sep 2026
 05:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260911112713.355FA1F00893@smtp.kernel.org>
In-Reply-To: <20260911112713.355FA1F00893@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 11 Sep 2026 13:11:50 +0100
X-Gm-Features: AcwNN1XOUOwZDNjKd0fMCAdW1pC8fPronyNs541sSWVf7U32M71-UP3UfDUWtnw
Message-ID: <CA+V-a8vH1yC_7V2F9HGMaP2QhuyU+qSXd_J2BAvn5aT-0CH61A@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] watchdog: rzv2h: Use pm_runtime_put_sync()
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, linux-watchdog@vger.kernel.org, 
	wsa+renesas@sang-engineering.com, robh@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sashiko,

On Fri, Sep 11, 2026 at 12:27=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Incomplete fix: rzv2h_wdt_stop() still uses asynchronous pm_runt=
ime_put() during driver unbind, risking a race with pm_runtime_disable().
> - [High] Kernel panic from division by zero when the optional 'oscclk' is=
 missing from the device tree.
> - [High] Missing NULL check for of_device_get_match_data() return value l=
eads to a NULL pointer dereference.
> --
>
> commit a446e675679ece36ef9554b71239f1b2c12cce73
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> watchdog: rzv2h: Use pm_runtime_put_sync()
>
> pm_runtime_put() may trigger the idle check after pm_runtime_disable()
> is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
> runtime PM active.
>
> Use pm_runtime_put_sync() to ensure the idle check runs synchronously.
>
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index cbf414e0c9a3c..4a5a856060e91 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
> > @@ -270,7 +270,7 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_de=
vice *pdev,
> >
> >       ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> >
> > -     pm_runtime_put(&pdev->dev);
> > +     pm_runtime_put_sync(&pdev->dev);
> >
> >       return ret;
> >  }
>
> [Severity: High]
> This isn't a bug introduced by this patch, but it seems there is another
> instance of this same issue in rzv2h_wdt_stop(). During module unbind, th=
e
> devres cleanup triggers watchdog_unregister_device(), which calls
> rzv2h_wdt_stop(). This function issues an asynchronous pm_runtime_put():
>
> drivers/watchdog/rzv2h_wdt.c:rzv2h_wdt_stop() {
>         ...
>         if (priv->of_data->wdtdcr) {
>                 ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
>                 if (ret) {
>                         reset_control_deassert(priv->rstc);
>                         return ret;
>                 }
>         }
>
>         pm_runtime_put(wdev->parent);
>         ...
> }
>
> Should this also use pm_runtime_put_sync() to ensure the idle check compl=
etes
> before the devres cleanup calls pm_runtime_disable()?
>
Agreed, I will update rzv2h_wdt_stop() to use pm_runtime_put_sync() call.

> [Severity: High]
> This is a pre-existing issue, but I noticed a potential NULL pointer
> dereference in rzv2h_wdt_probe(). The return value of
> of_device_get_match_data() is not checked:
>
> drivers/watchdog/rzv2h_wdt.c:rzv2h_wdt_probe() {
>         ...
>         priv->of_data =3D of_device_get_match_data(dev);
>         ...
>         switch (priv->of_data->count_source) {
>         ...
> }
>
> If the driver is bound via sysfs without device tree match data, could
> priv->of_data be NULL here and cause a crash?
>
> [Severity: High]
> This is a pre-existing issue, but could the clock rate calculation result=
 in a
> division by zero?
>
> drivers/watchdog/rzv2h_wdt.c:rzv2h_wdt_probe() {
>         ...
>         priv->oscclk =3D devm_clk_get_optional_enabled(dev, "oscclk");
>         ...
>         switch (priv->of_data->count_source) {
>         case COUNT_SOURCE_LOCO:
>                 count_clk =3D priv->oscclk;
>                 break;
>         ...
>         priv->wdev.max_hw_heartbeat_ms =3D (MILLI * priv->of_data->timeou=
t_cycles *
>                                           priv->of_data->cks_div) / clk_g=
et_rate(count_clk);
>         ...
> }
>
> If the optional 'oscclk' is omitted in the device tree, priv->oscclk will=
 be
> NULL. When count_clk is assigned this NULL clock, clk_get_rate(count_clk)
> safely returns 0. Will this cause a kernel panic due to division by zero?
>
As replied in the previous patch, I will add a new patch to check the
clock rate to avoid division by zero.

Cheers,
Prabhakar
