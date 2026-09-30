Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B973B83F9
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757392; cv=pass; b=HcRJuvRAdGx4Nc8vTZB5GHUH1V1SLzZkoDSOovipNjWUJmxJK5PlR0QB2b3Q7MUp9ujB69wnGA5mOnn4wQGeSbmjruqAeTQBA4U8v1H/NCgy/3HFlH9MCwRxT1MPSkwQBeCZ2uEqQRr+4fY9ShBC2fsTxP4rEuEEG74qfutLzMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757392; c=relaxed/simple;
	bh=HjdOFxmrol1vUnD9FKIi4UFta8BjlFpXjkromc99kSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUvAbstVsNr94oTw5gbNM6132ebvIqJBSiSBExU1Gy8dm1mJv4KtOT2e1kHyaTapjlVlUyuMSUD8Su3PGMdUnvzZRvECEtgVoTwzinVdNS91pNAb4dAJnYPzuFCeEQxlMNhOb/vbsCfZlEh3aikIqjTizF38AN+Yg0KSqE3zVzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPP9lv96; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPP9lv96"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4887d3c59ecso735503f8f.1
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 01:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790757387; cv=none;
        d=google.com; s=arc-20260327;
        b=JE5LGc267W4CNFvzRE6eaPTJ9VkpIkO+yC/GVGXOredgWLF71IsbpjxYlWEGul6SUx
         htVqEOZEFtoKJAljU2IEJ8vp/CKoXO11t1zaPeVxSpU1q3PXtzEq8Zsa9hDAvS6M8sCL
         1E3cZ/x/O0la9Vtm2UsnQEVNdDxGv0CfxnBMGB0KYsWXP9bihmV4N9RoPxMFUbNaOzLj
         Bd3nJkK6TsUzKfu7TsShdjW9nZv+b4QfKtr2qNK4SYgsVJtIVwL6wTrkccTQJyV+ycQ/
         RJmxNs0Lbj8KoYugWyOTRk0xa5FJbZJYW+FcQQz0vZyJra/E0BRMTaJ06DNsN+nk6kNt
         Jr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lZaIHzaOhcnhKP+I2Nw6s6CnueUSh0ItyVCxd7z2kOw=;
        fh=gB45m5q4yPBpgPCP5jUdNk6hi/06qMfh4YrG8GrLVJQ=;
        b=e1aaT2G3JUyvwf6krINP1wPkrpJfRGOt4Tv5fK4w70H1/6iG+amp+5tAmSl65JFOqL
         nYbm02/jJ3xF2ttj/AQNomE9W8D6mTLjmW70KCLYPeolMwHeyUEETbTlX6gpohiiiDQ3
         oV3oAtM7jTRXJdiZut2TQLU3CDEj7YHN7u5FKOGFq/gm1y2HwG/OYpAjoPPHi1gQ2gE3
         RjO6MWYoDP2H5Sp3wxZbyQwSyO4Moyd4+oFiOt1jZNUSah5KYQymZzJQk+Vcqbs6WQ4X
         U+/mlMsqXk8swZ6Ya3ElMk5eZugBEc0MvWFAgmes7HByA8jJNfM5ZOqlAaw+EfcoiTu7
         otsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790757387; x=1791362187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lZaIHzaOhcnhKP+I2Nw6s6CnueUSh0ItyVCxd7z2kOw=;
        b=fPP9lv96gucxheuD/UTtuwMLtRAubDXO6WGg74NbhRj4tuAn4KBKQ+RWXrNeSi8GPI
         mfCZqPOC4R3qYvxuSRl8a0qTaw6LpWt6Foq0S+81hAq5LsAf2W6PjsJZGfiSZl/4nSr9
         GcwVDBW3HAa3HSoKBFbNd1v2cC6sgXo97nXeWmbDHwq6zOpW+ywSnscCG8VNMh86gfuM
         q4QWhSJdmrkdfIww3F9Cgr9D/RneVfoD5dZNXEItcwosil4qsfSpZX8iUhKSQ1a2zgWF
         cQO+Z6UJeYPAZnfg2nJPSsMhJ93/Wlc/sNjA/7JKIJo3KiN512Ar3cU8zlXufdC0pW1e
         zlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757387; x=1791362187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZaIHzaOhcnhKP+I2Nw6s6CnueUSh0ItyVCxd7z2kOw=;
        b=urch4r9nMuotfNYOs7Z+tRUJOC9pg4xTJLCGDg4yMVVLJSbpUwOI2j5G8rufd3AOf0
         OVfGASdl4sNMv0oYTqgdIcLHxOw7mK6Czk2H8UUk+3sblEyYzqoR5BR5zCESuX/9SfDd
         pQI6Jx2tBCdcwTvycRu6/RxPvCcfVzvV47FtDWE4dvLfAk47t9edRdsPS3VVNZ3I0Yr4
         0nZ4KvhEQkTeWBlssGdYtkb5ZEDHg7lRimOFI29wHZX6f9cFsrexyRElD0fr9JOdaPmh
         oXzKZwwSkbaW86H2jN0isdGHy0l/F4bAzyzqmW6ERWBPKEVBLxEiT/MPPmaluRgLHNCI
         45yA==
X-Forwarded-Encrypted: i=1; AKwUvBzm49Ichn/byfA5PxTxxawoBp4eFkD8SlET/KehuAwsVtpOU0jP6CdjYJQoE7QGAc5Z57iacnwwsdk7rAKk3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/OLdk6nCI/f9rZrLSl8CEs6a21zmmJwFEWdfyVA9P5Y9XaETb
	QJehKGwdq4cs/AyB/uo0FVfbYHsHNFKDgH6dCjsJL8QCVtx5Liyu9GO4ftps+MqzbENDovG3dOa
	jsoxcLpz9dzHakzyKvWJRgKQLuGNLCW0=
X-Gm-Gg: AYBFou1zky7TTeBDDGPkCi58HXY7KWX1TRgWGcGOQiq597tbfrBlmdQBTZmpYJLRfiC
	0rGEZ7L6EYpnKay4dqrnT1ImFQMEv97MNE/WIhbx3yjzks9NwtrbYTvpDlcK1JuN1DYvDySbGQV
	5aPaVTogTr4sdP7KhzZntbYGs8YNxtr9V+wCZ3IXbeN3wZJUhPq3GEyLjNfPQSwd4lTl0rdFzdc
	FZHkL6/p3SdibpbJMAgz/w7DPhV6CkA8h5hnwEi3TiiW1tlFyVLmaDRgnj+8LTWLMxyEhdEjUG3
	NXBX7Sz8zXDUXK09F6MF2z7Nfp5gq9YeNWUKwRRnWEhvy7WSvyct4Hl424togLxhuz5Tw/P9hd3
	6HOw0DMMFtkgrT3qdBah4DrjX6JvQzmBIB5oUNnJgYFHzYTzkMC9IBKeo0cakWzSIXhJQW1p+xw
	==
X-Received: by 2002:a5d:588c:0:b0:48a:f11e:6d5e with SMTP id
 ffacd0b85a97d-48b024a6d19mr1630952f8f.11.1790757387095; Wed, 30 Sep 2026
 01:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929105021.542730-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260929110602.D533D1F000FF@smtp.kernel.org>
In-Reply-To: <20260929110602.D533D1F000FF@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 30 Sep 2026 09:36:01 +0100
X-Gm-Features: AclHuK8CCNO96WytW0FDoK4wkycLlbK69yfsHonOrEjdyZiIwv_YOfKHdgyoR20
Message-ID: <CA+V-a8sNsgCP6icoYd8irORb9OGMAFG+RrgMOEtAiMoX9gFFdA@mail.gmail.com>
Subject: Re: [PATCH v7 3/8] watchdog: rzv2h: Drop enabling clocks in the
 restart handler
To: sashiko-reviews@lists.linux.dev
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, linux-clk@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sashiko,

On Tue, Sep 29, 2026 at 12:06=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] watchdog: unintended system reset during suspend due to permanen=
tly enabled clocks
> --
>
> commit 465743d35253a3a281f9ce8cea373ed0c3ae3e5a
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> watchdog: rzv2h: Drop enabling clocks in the restart handler
>
> The commit drops dynamic clock enable/disable operations from the watchdo=
g
> restart handler to avoid deadlocking on the clock framework's global
> enable_lock. Instead, it keeps the peripheral and oscillator clocks enabl=
ed
> for the lifetime of the device using devm_clk_get_enabled() and
> devm_clk_get_optional_enabled().
>
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index f247e42d54f54..55ac11fcfcabd 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
>
> [ ... ]
>
> > @@ -292,11 +279,11 @@ static int rzv2h_wdt_probe(struct platform_device=
 *pdev)
> >       if (IS_ERR(priv->base))
> >               return PTR_ERR(priv->base);
> >
> > -     priv->pclk =3D devm_clk_get_prepared(dev, "pclk");
> > +     priv->pclk =3D devm_clk_get_enabled(dev, "pclk");
> >       if (IS_ERR(priv->pclk))
> >               return dev_err_probe(dev, PTR_ERR(priv->pclk), "Failed to=
 get pclk\n");
> >
> > -     priv->oscclk =3D devm_clk_get_optional_prepared(dev, "oscclk");
> > +     priv->oscclk =3D devm_clk_get_optional_enabled(dev, "oscclk");
>
> [Severity: High]
> Does switching to devm_clk_get_enabled() and devm_clk_get_optional_enable=
d()
> prevent the PM framework from fully gating these clocks during suspend?
>
> By permanently incrementing the CCF enable_count by 1 here in probe, it a=
ppears
> that pm_clk_suspend() will only drop the count from 2 to 1 during system
> suspend, leaving the clocks physically enabled.
>
> If the clocks remain running while the system is suspended and the ping w=
orker
> is frozen, won't the hardware watchdog counter inevitably underflow and t=
rigger
> an unintended system reset?
>
The driver doesn't currently support dev pm ops so I can't test this
scenario. My current intention is to add syscon support so for now
I'll drop this patch and revisit it when adding pm ops.

Cheers,
Prabhakar
