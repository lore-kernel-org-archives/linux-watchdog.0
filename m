Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E18330328
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883780; cv=pass; b=S6GO5C+TsYD9e2JPT8EAr/JDpwOd+a3FlJnK4e5j8b6XYZ2DjNrupVzVHvTKbdLUDJOpxT+wXrvyKnQOt0YlyVJCxqnuSR9/hYHLNg7MbrCfpEGe0mJuE2IPl/5u4GWDvey+4Z4rfYQN+w34zcFyumUqrSJap/g2QXFcLiqSGrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883780; c=relaxed/simple;
	bh=WztWhHVc0H7CPyJLwxnwx6YXYXsrq7l98ZyMQp+1Ck4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFKJ6rOb5GqXk8JCNFuDhXLo3UraSHixJCjy8Eb9cCTjK3fxIx+9EYOikkrPzcD9+srMBji0ZMroX2+pv8xBZyVLh3oS2wcS42R0CVsmPywoOQVTE45Cm+OEqYnTTO09Jbnihb1IjNuxRhsZo+bW+wd530VpGvHCLMqjt1sg62A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9e2//Gt; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9e2//Gt"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482dd6ee390so5505333f8f.3
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 09:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883776; cv=none;
        d=google.com; s=arc-20260327;
        b=cxKD5B6o1YM38uAF3/vVHMltGzmL8fFSW64zBqPP2iuuMjrZDmksXJHM5vvc8xHpRN
         khfXFmquy2y9UdfOfVQaKuFCtjcGHi9Td82/MbFmwwqUhpmJ1xkb9FR6u6angvIsTu3q
         qv6e9E0JeI+QugLCaLk7kfxzByR81PgwR7ITXWd5AEh/cFTGih3KyRSbWlUmixzOamNk
         8Yi/tYFz5zp6zV9v9huSNaLhlAHejsbPP8B9KeWIJzj/oGIQwsu5wfE4ggVPzZxTkvHS
         5iBbRnaG6u00b496rxpa3CX0U3fTx9j0ChYnMyhL3StXQR9hY8iwthNFyorDEy4aBXhA
         nZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XTcRxNE+0QKPGmkvcXmGoBSJ3Svx4jopmL9a4dde9Bo=;
        fh=i8K+g4n1qA/yXifweSq9emWZ2BzoC5yB85rbP5ILbUk=;
        b=W1D8A0FrmK3KcBRQS3Pi9i/4WXdY/G8gS2uM3SwiWziZI29X+suRbyyHg20pS0kHI1
         l/QwsmXpUY6a66YJHxUrqC/MVeQAjO+w2UZQZEw779BER6YoVH5up0j2tX1Ju0aSaWd1
         ESuHtoWq23EbZVP53mvQRkxNMKfjY3SaREOE6myCG/S6WyNcLHxnsuLbjsNNz2wO5fdV
         pZByRxyUcNe5pI5F3C8JUrkEIt/2/YpobrnPdxm/9gTGmA8m7gZuSei1cNp0XsvlpnLo
         viHYpuUSfqcW0i76Vjjc3lrPaUFkUhpnnNGEAOQir3iTE3ERxG827NDnHMk1uqm/s4Ja
         cYaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883776; x=1789488576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTcRxNE+0QKPGmkvcXmGoBSJ3Svx4jopmL9a4dde9Bo=;
        b=b9e2//GtmQdMVnjEuGHQaG9PZNCDxB8iLi0mZFdoKStT1QsRRP4qbhlzYJcJlRhad3
         VhV5dAOGi2KGhhY//Cl/lCnpbQRgsITF5UcxpVpnPzaBUAtKoHoKXbx/gfP9pKJ+P9Ls
         FUNJHihh6smNM8qrx2bYNW6eg6zWEfJaQtoIbjmCC9n7Z5066vZBWEc2Ybbm1KXyNG4u
         dN9BHpDuKomD/zdN8XBdn9mVvyZmRO8mezRKMqfv7VH+maXSfDhuPlfsT9oG3zvkvEo7
         b11/ZybbjNJ3xW16TBSmYJzaNX15Ye+ESCNOfFqLvbANRO21Q+GqbGxSZohMxL3X3UNJ
         iOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883776; x=1789488576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTcRxNE+0QKPGmkvcXmGoBSJ3Svx4jopmL9a4dde9Bo=;
        b=RTJiI++v5WZk5liwXwf5mC/RzZgycyVCkB0HXBWzYmFQMNd8SbV56jsiKHL2w2qycM
         9fxDRhRGh034TKPeGXjC0b2zz/GYGfU05D3JTYZaZPfUJV5+xCVwrxrrjfXB31y5cNCc
         GqfMneKwvE0KsQIfxeqgFjwqa1p5d9pvVGJVD6fYLO+rdHV/c3tgu3iEYW3Aj7kQOn3o
         4JMZII0vaPka3keuhkYAR+0q2hGxzottHJK/cA3GmgDxWVH7u/dWNriQ3q1bp7s7RNzm
         nZY+87QzYpf1vCu3Nck2EQq6nUGlH6wJYsK9/T2JMLs2y0ngq8X4pZrWK68n4+wpF54F
         Xh/A==
X-Forwarded-Encrypted: i=1; AKwUvBx+g93jXXDIKHnROcN+TkarR9qJOo72ZonFh6j0gzspQFXSbtgw9u67CqYPW4yhJ+F8QYNk2DgtfSKhl5silA==@vger.kernel.org
X-Gm-Message-State: AFuF++lZhNEhJjD8sgVEBpIFearMJSMUcFQZc7xmuTiZ6pyB8W6sJqjE
	oNukrhy1Hgygnk6NxEbYPKvO/rrm6QSUHvwscsAn6Sn+5O274D+no0pYa8xBlUNR1f26+9OzuLo
	M5SkmPqWAvbphNBJJ54IAr+SGuK1F778=
X-Gm-Gg: AYBFou1e/rrIdizsweVpMXFLoRptkBEn4E6ak4F+4fOn30cO1DHk5YvSFheYieojle1
	e1cWDLKjFGL6wW807WD2CzQDTy+CRS56Xv3c1ve3F2sHRcZhbhRKEovkeNHUKkYq/EiBtweR81B
	e+liz+iCve0BPiZltRtecZGN0AbiqF2UJ0OL4rwo7zUqiOFiVBou/u0vj0CPq0GEJaJUb8cXked
	t2rqapRhlyYqEeH0fXuJ5LboNaIP3Ph1UCFkX3Z1SANDHWOxtsM85q8aBL7DTDklDTBekD25kEn
	wlbgMY1HjuChgK1IwFDP8M/U7tNiDLTvtR6enqFJzTkDO9xCog1NP9vjoe0MvX2jvNsW0MP2SpY
	DazawIFsRQWZIMWHfIl6PxSZj9+aWjw==
X-Received: by 2002:a05:6000:4694:b0:47f:9266:9bde with SMTP id
 ffacd0b85a97d-4858703f92dmr25465606f8f.4.1788883775867; Tue, 08 Sep 2026
 09:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260814191415.2110732-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260814192623.2A9251F000E9@smtp.kernel.org> <CA+V-a8sFKaoYe-5ETcoktTibaHZeJDQN+BGzsD2xFnVZRXxm0A@mail.gmail.com>
In-Reply-To: <CA+V-a8sFKaoYe-5ETcoktTibaHZeJDQN+BGzsD2xFnVZRXxm0A@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 8 Sep 2026 17:09:09 +0100
X-Gm-Features: AcwNN1UPrT-OBd75FMnOYw6-VBnoCdw_d03tw_YLhHOMh0wIOw46Gu0F0_TY1sM
Message-ID: <CA+V-a8uDW1M6z2R_KBhKLn4Njp+3mVSTPDWYrjs+Xy2TPuoaCA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] watchdog: rzv2h: Convert WDTDCR handling to regmap
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, sashiko-reviews@lists.linux.dev, 
	linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Tue, Sep 8, 2026 at 5:02=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi sashiko,
>
> On Fri, Aug 14, 2026 at 8:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> >
> > New issues:
> > - [High] Using a regmap configured with `use_raw_spinlock =3D true` in =
the watchdog restart handler introduces a deadlock if a panic occurs while =
another CPU holds the regmap lock.
> > - [High] The watchdog restart handler inappropriately aborts on regmap =
errors, silently preventing system reboot.
> >
> > Pre-existing issues:
> > - [High] Calling `clk_enable()` from `rzv2h_wdt_restart()` can cause de=
adlocks if another CPU holds the corresponding framework spinlocks during a=
 panic.
> > --
> >
> > --- Patch [2]: [PATCH v3 2/3] watchdog: rzv2h: Convert WDTDCR handling =
to regmap ---
> > commit 81d528488e87b317129eaa95c0076e2e770f3265
> > Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: watchdog: rzv2h: Convert WDTDCR handling to regmap
> >
> > This commit converts the WDTDCR register access from raw readl/writel
> > variants over to the regmap framework using devm_regmap_init_mmio(). Th=
is
> > refactoring allows the driver to subsequently support syscon-based syst=
em
> > controllers natively.
> >
> > > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wd=
t.c
> > > index b770226f785ea..cf28caef31e8e 100644
> > > --- a/drivers/watchdog/rzv2h_wdt.c
> > > +++ b/drivers/watchdog/rzv2h_wdt.c
> > [ ... ]
> > > @@ -91,20 +92,12 @@ static int rzv2h_wdt_ping(struct watchdog_device =
*wdev)
> > >
> > >  static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
> > >  {
> > > -     u32 reg =3D readl(priv->wdtdcr + WDTDCR);
> > > -
> > > -     writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> > > -
> > > -     return 0;
> > > +     return regmap_set_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTS=
TOPCTRL);
> > >  }
> > >
> > >  static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
> > >  {
> > > -     u32 reg =3D readl(priv->wdtdcr + WDTDCR);
> > > -
> > > -     writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> > > -
> > > -     return 0;
> > > +     return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WD=
TSTOPCTRL);
> > >  }
> >
> > [Severity: High]
> > Since rzt2h_wdt_wdtdcr_count_start() is called by rzv2h_wdt_restart() d=
uring
> > a system panic, returning regmap_clear_bits() here means the restart ha=
ndler
> > can now fail if the regmap access fails.
> >
> > If rzt2h_wdt_wdtdcr_count_start() returns an error, the restart handler=
 aborts
> > early:
> >
> >     rzv2h_wdt_restart()
> >         if (priv->of_data->wdtdcr) {
> >             ret =3D rzt2h_wdt_wdtdcr_count_start(priv);
> >             if (ret) {
> >                 ...
> >                 return ret;
> >             }
> >         }
> >         rzv2h_wdt_ping(wdev);
> >
> > Does this silently prevent the watchdog ping and hang the system indefi=
nitely
> > during a panic instead of rebooting? Should the restart handler ignore =
the
> > error to ensure the watchdog ping always occurs?
> >
> If the regmap clear/set fails, it means something really bad has
> happened, and we cannot reboot the system. It's better to return an
> error instead, as the reboot won't happen anyway if regmap read/writes
> are failing.
>
> > [Severity: High]
> > This is a pre-existing issue, but I noticed the restart handler calls
> > clk_enable() when the watchdog is not active:
> >
> >     rzv2h_wdt_restart()
> >         if (!active) {
> >             ret =3D clk_enable(priv->pclk);
> >             if (ret)
> >                 return ret;
> >         }
> >
> > Since rzv2h_wdt_restart() is called in an atomic panic context where ot=
her CPUs
> > are halted via smp_send_stop(), can this cause a deadlock? If another C=
PU is
> > halted while holding the clock framework's global enable_lock spinlock,=
 the
> > panicking CPU will spin indefinitely waiting for it.
> >
> There are no APIs available to enable clocks in an atomic panic
> context. The other alternative would be to have the clocks ON all the
> time in the probe.
>
Please let me know if you want me to enable the clocks in the probe so
that we dont have any locking issues.

Cheers,
Prabhakar
