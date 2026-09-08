Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5159572685
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883380; cv=pass; b=RBdLYSzCskvS+xR2JXfkvFZU94IlFq1LpjqZwyiEFvQvwO2NNzXHnytuTmXg6GJVgfGTgZ0XF0nEuJFo5vPBwcaTXX8xa4TcYIqBkQ7g89SOWfnrjx00uOTVUnxesD/VixscVAFtoFeX6gpKc6YxjIQmuuDy6VPCvI1sQacHaj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883380; c=relaxed/simple;
	bh=ap4bULKqOLybulZlaa1OaNXmtfc2Emsxz2j9sR4KHns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTCscVM/9kxfOfge5LlTqZBMzVa1brmdocNJXZPXTommWQ5j+1H0ldPBwpMMKPkDHYfMlY8pY1LF7uBymWjFikWr//zuTol+J4v5FTxu/F8QetD0y2872C84PLXBW7Ltwi9M41+cHJQvVAQBqD/mFz/Cq+oyWDioT/60dP++uZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZDInJ+g; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZDInJ+g"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso26795625e9.3
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 09:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883376; cv=none;
        d=google.com; s=arc-20260327;
        b=Tb5F67tq7MXfgQrLRPEzrMIRGlN+phr+QxVEl7yjgUb4Goa4+98jFqexb6FTrmN3Tq
         ap8VyZ7m77Fbx1Lj0CnvS0GQX9+sLc5uFrXDrQovnIE+160lvPqhAGDO+L2Gka2qu39m
         vvKh2xySPJ6wsXGiKA5SdoRULqjncr59CZc38PCB9hTZnwD6ZwZu1ePNOjx5i5Y8TQ/v
         mo65eKkA0PMvjP1MEx9mb9VAXZHnMPM7VpsNIPgyZG8CikH8acJk3UVggHBPQW1YyC1O
         b/LYf5Oq3NKIHt3abT7RNtb1W7BbzFdAd5IafIBkDDXecmwTddh4jz26icjXgNDIAssU
         ERRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YkIvvMRRAEqhmpV2P1NY9LfV1YUNX9a9VJmrcWZyRkQ=;
        fh=9TBLTvX/J2EAiQPyC+umMCUB8iO+rrfwgEXOrVCKN7s=;
        b=Nm5QVbR0pl8yW7gJp/RZg8mqLTvKDBwNgyK7RHKoQfU7foLBIFYY1ZpnebllDRMovB
         YrYMrwDBRVs72QUJbK5sp4z9Bmv2YsjItNdAz/wFLaWoZ4k/MTDMq26wjg/aY62sEvOR
         USNz38F5fAd8ksvvKc8V/1qbthYI7Al4v8GNuQipGUEewCcPo1Ou9kV81JYa92PtF7Nn
         0bQiVHzQEtfg5yix0LdPNJBogP2l061u4GSdq5PTyF8QmAYyCic/WWlpJwNM60fAtNDS
         F0T5KH0WkLr4XnUhR57GoJ0O1m1J4wf1KzpstPWHmwN+KATKUTV1FjW7eVPXWmzEFnJZ
         eJnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883376; x=1789488176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YkIvvMRRAEqhmpV2P1NY9LfV1YUNX9a9VJmrcWZyRkQ=;
        b=nZDInJ+gjsoTIM0b01dhxbGEdbNpzaGRa8cZLqGb64VmyvfkhRKWkJKxTsmAs54MlC
         5ikxK7rxDg2Coe4PnkgqpwVf6UYT6YmBtnaW4cCdmFJ/zrnuVvp3Aa6IZhGQrqOE3WY4
         vt6BEQvvPPxgw/tY33OuZSr6CRO+oxAegKc2lmE1IcJAC/w1mdjeUOGYLi4c4+Whe8D6
         rqveanr+pSzUbn5/cFy1hr3ixKXYZATWBk17xtrndnQ5JIKHpa7Xl0RumpW2fxLAEAkh
         M69IkMoh80CgTx05HeDFl8EDSXDQc8IdeEda1ic3odCsmqqc2lDW6XJei12dAUBib9jw
         Figw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883376; x=1789488176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkIvvMRRAEqhmpV2P1NY9LfV1YUNX9a9VJmrcWZyRkQ=;
        b=LP6T3d/wDoaiQpUVfjg6BigOm9BPUu35QZDQbsCrtFbarrYVRazK+jbTcJwAOGQYjJ
         D60dsiEhYU9MeEQju6s53dG+v0OdPYblLC2iBSIGKtVgCPSjgcX/uvGSWUsF6AGiKSYF
         pm9L68ID2bE/voHzcQvu2QBaKlFVUhNjdfxd4rpWhM59p9+BgtgVITn2zyJ4rLKuhbv9
         gU/Y2yNariLUx6txa+Y2OKfVZ6FpCGPukcdGphuEiyihX4w4oakqev0/YI+EmZgD1NMI
         hpdQ2+CJGwR/Sqw2i9LzdH82Wy2B71O+91Owfr5U69oE1bFwavBuBmB4puvsvr7KsPAV
         30qQ==
X-Gm-Message-State: AFuF++kxpkpWloiROmyc+1IK7i9ct+RO3JayelT+EJMhqElsikaOD/oi
	WhZrPVl7gLPrRlJ+zB5iFDw6Yaw5N4hpgSHXqlw4dC3kym6VXqvYiL+1XsjTuROU0xeuEXboSeX
	Nrux6OSHrz0TLzqckYgrF0ymmcFgSUhqmpP1YsiY=
X-Gm-Gg: AYBFou0ifivt8zPvyMjnwUDRQhNNjmzwIFlnLDcpwD5OP8jyLOl5QznvgJ9vv+Wppx0
	mdR6NSG1pc3Eg5ewu68RxOs9eYLorJvlLYnhakv7GL1lENQ/UVByZkVYEXMdBToYzZsUE0rxrfl
	bqDvOee4yrPLeg1vOfrFduds1lQUjKAgld5/u0ej3RLsR9zHYkhBfquH7veEUIEc1ufnUcAELvW
	QYTJOHOHsZTAsJTfg6quHFc/pPRNV3x/7pNwzbQX7gM/kqgleBoOsYXyWx9JWi0XCaUdV5x9jmG
	BCBh/E/AoIC1GIAG5UEK7nA0vUtBXqKYXElrsVKdQ5nfyS66QJVgvIJgP5xM/d5oQYqK62xzpRn
	y9czPkR4AqnnOC7k1vlna6wpNYQs+cg==
X-Received: by 2002:a05:600d:849c:20b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49cfe467228mr197748585e9.20.1788883376090; Tue, 08 Sep 2026
 09:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260814191415.2110732-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260814192623.2A9251F000E9@smtp.kernel.org>
In-Reply-To: <20260814192623.2A9251F000E9@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 8 Sep 2026 17:02:29 +0100
X-Gm-Features: AcwNN1Wybw_Hnz5sBjzjFzK5_9pPy2Nv2GttNQzw-6PpM9StOTkX91FsrNlolkQ
Message-ID: <CA+V-a8sFKaoYe-5ETcoktTibaHZeJDQN+BGzsD2xFnVZRXxm0A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] watchdog: rzv2h: Convert WDTDCR handling to regmap
To: sashiko-reviews@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sashiko,

On Fri, Aug 14, 2026 at 8:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Using a regmap configured with `use_raw_spinlock =3D true` in th=
e watchdog restart handler introduces a deadlock if a panic occurs while an=
other CPU holds the regmap lock.
> - [High] The watchdog restart handler inappropriately aborts on regmap er=
rors, silently preventing system reboot.
>
> Pre-existing issues:
> - [High] Calling `clk_enable()` from `rzv2h_wdt_restart()` can cause dead=
locks if another CPU holds the corresponding framework spinlocks during a p=
anic.
> --
>
> --- Patch [2]: [PATCH v3 2/3] watchdog: rzv2h: Convert WDTDCR handling to=
 regmap ---
> commit 81d528488e87b317129eaa95c0076e2e770f3265
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: watchdog: rzv2h: Convert WDTDCR handling to regmap
>
> This commit converts the WDTDCR register access from raw readl/writel
> variants over to the regmap framework using devm_regmap_init_mmio(). This
> refactoring allows the driver to subsequently support syscon-based system
> controllers natively.
>
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index b770226f785ea..cf28caef31e8e 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
> [ ... ]
> > @@ -91,20 +92,12 @@ static int rzv2h_wdt_ping(struct watchdog_device *w=
dev)
> >
> >  static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
> >  {
> > -     u32 reg =3D readl(priv->wdtdcr + WDTDCR);
> > -
> > -     writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> > -
> > -     return 0;
> > +     return regmap_set_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTO=
PCTRL);
> >  }
> >
> >  static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
> >  {
> > -     u32 reg =3D readl(priv->wdtdcr + WDTDCR);
> > -
> > -     writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> > -
> > -     return 0;
> > +     return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTS=
TOPCTRL);
> >  }
>
> [Severity: High]
> Since rzt2h_wdt_wdtdcr_count_start() is called by rzv2h_wdt_restart() dur=
ing
> a system panic, returning regmap_clear_bits() here means the restart hand=
ler
> can now fail if the regmap access fails.
>
> If rzt2h_wdt_wdtdcr_count_start() returns an error, the restart handler a=
borts
> early:
>
>     rzv2h_wdt_restart()
>         if (priv->of_data->wdtdcr) {
>             ret =3D rzt2h_wdt_wdtdcr_count_start(priv);
>             if (ret) {
>                 ...
>                 return ret;
>             }
>         }
>         rzv2h_wdt_ping(wdev);
>
> Does this silently prevent the watchdog ping and hang the system indefini=
tely
> during a panic instead of rebooting? Should the restart handler ignore th=
e
> error to ensure the watchdog ping always occurs?
>
If the regmap clear/set fails, it means something really bad has
happened, and we cannot reboot the system. It's better to return an
error instead, as the reboot won't happen anyway if regmap read/writes
are failing.

> [Severity: High]
> This is a pre-existing issue, but I noticed the restart handler calls
> clk_enable() when the watchdog is not active:
>
>     rzv2h_wdt_restart()
>         if (!active) {
>             ret =3D clk_enable(priv->pclk);
>             if (ret)
>                 return ret;
>         }
>
> Since rzv2h_wdt_restart() is called in an atomic panic context where othe=
r CPUs
> are halted via smp_send_stop(), can this cause a deadlock? If another CPU=
 is
> halted while holding the clock framework's global enable_lock spinlock, t=
he
> panicking CPU will spin indefinitely waiting for it.
>
There are no APIs available to enable clocks in an atomic panic
context. The other alternative would be to have the clocks ON all the
time in the probe.

> [ ... ]
> > @@ -280,14 +273,30 @@ static const struct watchdog_ops rzv2h_wdt_ops =
=3D {
> >       .restart =3D rzv2h_wdt_restart,
> >  };
> >
> > +static const struct regmap_config rzv2h_wdtdcr_regmap_config =3D {
> > +     .name =3D "wdtdcr",
> > +     .reg_bits =3D 32,
> > +     .val_bits =3D 32,
> > +     .reg_stride =3D 4,
> > +     .max_register =3D WDTDCR,
> > +     .fast_io =3D true,
> > +     .use_raw_spinlock =3D true,
> > +};
>
> [Severity: High]
> Since rzt2h_wdt_wdtdcr_count_start() uses regmap_clear_bits() and is call=
ed
> by the panic restart handler, can this raw spinlock introduce a deadlock?
>
> If a panic occurs while another CPU is executing rzv2h_wdt_start() or
> rzv2h_wdt_stop() and holds this regmap's raw spinlock, the other CPU is
> halted by smp_send_stop(). When the panicking CPU executes rzv2h_wdt_rest=
art(),
> it will attempt to acquire the exact same raw spinlock and hang forever
> instead of rebooting.
>
I will stop using the regmap spinlock and instead use a lock in the
driver itself, disabling the locking in the restart path.

Cheers,
Prabhakar

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814191415.21=
10732-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
