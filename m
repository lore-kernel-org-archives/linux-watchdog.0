Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AC3E49D5
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126621; cv=pass; b=C4nxzVWMeDAGD+Ig/wUXVbTtYpWhOL2zmG0iIb4Jmx1Nh3S3DqjQaQfdaunpn5VjrVQaIDiez6jSK7qFqI0DcafDgTEq0+bgWTOXCpINxszx0IJJ6q1AMS5GSkz8KshIs7J3i1B6XwhPisKgQboX0h8qk/PIPL94uZ+zZsXP0js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126621; c=relaxed/simple;
	bh=VP4BlcnfUZVr3/+zomIB7ojpIUneSSNJHRIVnHGfdr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LorhbA1LpqkfDZr5QbVJnxLZtc4K/rrQMNBu0/bN1NJJohNJNHFRDCAydwz3nwSodt0jwClSB01D/E2Os5Ak+I4pSPl/V61fy/8RNlMxt0Adi6QYiP/cEFDEFxWPsP9bwQddjeloDHCSvR8Zq7w4R/Ky3uic5H2Whf0lXshUwx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeR2pStX; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeR2pStX"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-485888b3c3dso743920f8f.2
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 04:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789126616; cv=none;
        d=google.com; s=arc-20260327;
        b=iuQDfh4iJGB3MYS2FiI7DHOgIYbqUP80LfnRHQ66aVuFii01/ZkxSYpKcWZQ6EUY1T
         PDq5XCCVHg6UFWoeNxv5wMp9aN5ko3VsAR7VBDnTBFQUhil4FDE6pxq+legW5tO0xEuN
         pJGDEc6/6+Y9BSkxgzdSHwEepwu10VXfKCmFNQskrFT8KfRcSzemJm9mQog96NL2XklR
         IAKY0BeFzxSD598wxxe1FGpGXWFLjrr+RmwPgEMHzEqTm3QXQ1YpK34Pj6En9No4Nbam
         Dkeef2MnV3ziDfWxy6uGjoylULHSGLbRgE+etClC8jvSU3030CB3iqXJ/wzAouMWuvKx
         aGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LIgt75iQmZv2IR1V0VMxqaMEjC44FA+M0gjq3T1j3yE=;
        fh=13L9lns6+9DWzS/kdkWn/v6gGpgaXxlhOFZ5Z8k63ls=;
        b=sarCZK3mAl5WN1tzWwSvxoCt6Di4U80rs5uz7ZXM+XG4lepvAi8zAk9oS0KJq/Ke4D
         h9OePNOzpI9N859r0vxGDgUb3FW1gaukkAQjZUOkmucPqAr4vyqfW1ny5jQlKgFwXlnY
         40BEcjnmS2hC1w3eZQ605EkC/gP3fbbk3QI8pKrLs+uCxHF0N7j+vtMTOmYMIYH2I2gX
         GRHoM4/rRuYS9YsXNAGhFepdYUFaO8Thl510dnxXwvE0b/iNvWqzG7Mru/4Fzem7qdPA
         mkXNsEM09axBc/qRGWQ4p4RmKcjf67vL3FLZ+tcSK88zj6dMje7+ooviQf8hZSpKapoK
         ruGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789126616; x=1789731416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LIgt75iQmZv2IR1V0VMxqaMEjC44FA+M0gjq3T1j3yE=;
        b=HeR2pStXmqottZaQS4HHHd7cIOZMQQ2qsO84RCoJZscAB74ww0boi7Oc2iSRtQQtVj
         tO2Y6CTUQg19O5Vufdurc/R+G7DF2YFJDwfT5mniWw6CvDdH/+zE6yWynYGZYrFFrnWd
         nZ1bJNge2hD4z95o9Gtb2a9SuwsFkS9XCXs5YmPBMY3CPZ818OlbalrQi48k2qxqzcC2
         IebsxWm88P/sabWLTU4uLLsfs/IjcC66xB34DRA6E87jGNQX6yoxLtytJJjs6y6QS6Dp
         cldGCw/ez6o/9lABv/3GCxV68sn1J7t7M4yPoPSh7WSjy6+9OF3ECwgM5ncpm+LycPlp
         BB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789126616; x=1789731416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LIgt75iQmZv2IR1V0VMxqaMEjC44FA+M0gjq3T1j3yE=;
        b=Ibm9v8JGolZozGLPhhrOHtYLkFl6psRZFtwxJLonJOpU6PDR02B0U3wKT+IFSFagK9
         HNCkxJmZFOSRFQWNculcookGba0anYDtNDzsfErcqisztDaIfqm1w/UQqIUu3YC3uMVk
         yiWk/xgj2XK+qYqpnDQdURusspbQ0Cf3bNcJaNxxjJuMa/IXkbayglwsVqJCLkbqBLsr
         k9WTzl5morHH7IVaJ6epailrzv0WOkvXzpHtXMt6AWOR1bbClFnGG51A7geE66+itIh7
         jniNp/N7tNMTaOML/MjbfyNQbsBTDRMjjgdeP42mTnsclcg1mOV4hetSiLVg+pvbwqQE
         28vg==
X-Gm-Message-State: AFuF++nCIs5sSZUcJRURUVBA0LM/6zFjTS7P85RN0nTVNXpnpRgfomTW
	eCNeCrNSNjLj8QRPkmDKC/jXHj/1gPSXkbIkNSs7HWZvFC4NpGU67I31tJqGbRNJvq6a551CcGq
	eMDxFT8udYfdo/Yj+EPKlL1ozRZciJjI=
X-Gm-Gg: AYBFou0v+7m4mPtqyU3iFVrLIuXPWGKSueFKtEG3c1o6i0092mYJYQQTXqJNucOUksF
	EWBc2jEBL6mY69dp5CTZou80eanP7T7EMOnCV1UlFZDnc79GA9lqRybXh+z8XVOZ21WyjSqlPa5
	blzNyD2n6tv4KMPwUj/vn5/kPejGiXlpLK9AnTeqK/byw/tKat3zEINH88iY9vAzUtvMQ3YSuJp
	24MLpXB9oZjCqT3O+WsJCwgJKVfqi5HNPVLOweLS4VfwHGnej/LtxNo/3EXd9JObuzs1Xw/0th4
	FVUsCcbN9hxo6C6E7NokhcISfIkSJY708/IYnsyWgLecyvANsBrvBrK7p5wBrYUgAU2cTBe35hX
	BB1U+OEEiS0AMxchrIWYpN/3qYJ1q/rJCHbRJrxRCOGqeiJXDoyt/roeVjBA7ObsCC7yyNeiXzA
	==
X-Received: by 2002:a05:6000:2311:b0:485:8c16:5ef5 with SMTP id
 ffacd0b85a97d-486eb30a9ffmr4061062f8f.47.1789126616471; Fri, 11 Sep 2026
 04:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260911113217.0178F1F00899@smtp.kernel.org>
In-Reply-To: <20260911113217.0178F1F00899@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 11 Sep 2026 12:36:29 +0100
X-Gm-Features: AcwNN1WsWnutDhTfem_mFFkR3R6OacHy1RxvsrgccYae_oUqrtA6rSmNdVdNO54
Message-ID: <CA+V-a8vCd7n1BBzoxL6XB6iiB8fyakT-bDgu6cX5GjnpoREzbg@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] watchdog: rzv2h: Drop enabling clocks in the
 restart handler
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sashiko,

On Fri, Sep 11, 2026 at 12:32=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Unchecked division by zero during probe if the optional 'oscclk'=
 is missing from the device tree.
> --
>
> commit e61522c3f4f781e0b8cf17bd6e22135a7d714358
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> watchdog: rzv2h: Drop enabling clocks in the restart handler
>
> The watchdog restart handler runs from do_kernel_restart() with
> interrupts disabled and after smp_send_stop() has halted the other CPUs.
> Calling clk_enable() from the !watchdog_active() path takes the clock
> framework's global enable_lock, which can cause a spin if another CPU hol=
ds it.
> This commit keeps pclk and oscclk enabled for the lifetime of the watchdo=
g
> device by using devm_clk_get_enabled() and devm_clk_get_optional_enabled(=
).
>
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index 3b6abb66a1da0..bd86da71b0eb8 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
>
> [ ... ]
>
> > @@ -290,11 +277,11 @@ static int rzv2h_wdt_probe(struct platform_device=
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
> This is a pre-existing issue, but can this optional clock fetch result in=
 a
> divide by zero oops?
>
> If the optional "oscclk" is legitimately omitted from the device tree (or=
 the
> device tree is malformed), priv->oscclk will be successfully returned as =
NULL.
>
> Later in rzv2h_wdt_probe(), if the chip variant uses COUNT_SOURCE_LOCO, t=
his
> NULL pointer is assigned to count_clk and evaluated:
>
>         switch (priv->of_data->count_source) {
>         case COUNT_SOURCE_LOCO:
>                 count_clk =3D priv->oscclk;
>                 break;
>         ...
>
>         priv->wdev.max_hw_heartbeat_ms =3D (MILLI * priv->of_data->timeou=
t_cycles *
>                                           priv->of_data->cks_div) / clk_g=
et_rate(count_clk);
>
> Because clk_get_rate(NULL) safely returns 0, the unchecked division will
> cause a divide error exception during device probe. Should this verify
> count_clk or its rate before the division?
>
oscclk is optional for T2H SoCs and is handled in the DT binding, to
be fully proof, I'll add a check for this case.

Cheers,
Prabhakar
