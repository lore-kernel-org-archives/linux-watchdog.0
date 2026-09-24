Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA72F7445
	for <linux-watchdog@vger.kernel.org>; Thu, 24 Sep 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254811; cv=pass; b=aZYIXj1zoaMDN0B13GL2/EK5QZ53MUNxdLEBNjbxb7Njk4e4JCRXjDAA/0EMBacRvO3F073kYez4hawYrsi9xKFhgQ4wJY92hxmn/BTxQ1kfE1bdeq5Q61vZWhJlYkN/N+47W9DvUgKFbXXOSkZaJrBoEQzoQ4LLbGbEl8M+foA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254811; c=relaxed/simple;
	bh=Fft85CxVPSnz/lnplUZXgtIisv+sBJwICxGw7T+3TE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdx8AObQYyeBqdajPReZC0Kfi65+tTVB5cOGgy+MgnYz4jR/GfdND6SCNtJdp1QT2CbDktzV7K8nX++4l5mxOEwrCzxiiufkA/JE9M2b4jj7PiXodbDYlj+AmAILlE+9Cd6DDS5wwNExvoI6WDCL5UJA4+uu/GcV9D5WJRZwgC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UswVJq7k; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UswVJq7k"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so11672825e9.1
        for <linux-watchdog@vger.kernel.org>; Thu, 24 Sep 2026 06:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790254807; cv=none;
        d=google.com; s=arc-20260327;
        b=kyG5s5fj8JGvGD/lCF780MaR+yDJRShgmxEuvV+9ZNULmYSlV5tytBFS7T06Kz+VDb
         qdjFrZUMAJNbiz+8ZZYja9aSRc3NUdDvbthJUyra1KERF4Yf/dm0QKVpVgBHHaYy4cn1
         jR/F8zIT8uBzfxpJxpLI6kZaiafAyKrmZ6Pe7tlrR6jkk622Tm+86fPWSJ6FBihgB+Rj
         waW3ObYpYNxRUGhPzZnR4W7ZvsBWXMUjZaDkApATXz8DRq2UsbQ7R1UnJr/MPgqcUAaS
         Lg6YvuLgCmIQp2BnHuntVVWgUnFdRQ8bIfAQo0xdh9hmStVM/LZPysqjdtl209FKjfTG
         2+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7OSLVS9HvHJYI6SUB/JDf6BpBvGujsk4TT0HCcRv1qs=;
        fh=tq6qvFdkdrmd3FlL63GjWUB39lpBVUOb5av3JHvdK3Y=;
        b=oO40eFiaLZq+PPlioWyoTLFrHQc64l/5H5MCFOTQjXZZG8Zu6an91OBeUS+cFAcGaE
         xhlQ9NyuBIaiiLzz1IkQTstV3xozsOBmK03fbB7A3dZsJxQlF07/GM6jOrTKI8er2Clt
         Jq5/HB/08DcZi4Y55xyQm+qCVG6LiJzEAXrIxTw/3DEuNh1V7tw7yLQLP/RO8FXpPpHr
         NXzlaFf3fgGSkyCLLj3KRLflVYZ9pECAhRSPQBE8BQ1e6XEdUsoVgZIigmQvBKne6yak
         fsSzaUS7u+s5R4q4ixRx59DvurSRZWLGSRD4u1CFukKMtUY+Kw65Y/MnI3axdeh7U5aP
         QDvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790254807; x=1790859607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7OSLVS9HvHJYI6SUB/JDf6BpBvGujsk4TT0HCcRv1qs=;
        b=UswVJq7k8Rbd+kkGvAhOqweNCFxxyPDN06Tg5crj4CeRvm9VsyB7BRjrWXBHKMqAeP
         kz60tJhBLB5EkWrGjzOPbtD0XUT83zo5znxaTFc1K+GxMBBdmUhGcU5pxkmCyOtaCIcY
         DhGlcI03U0VLXuBSQ3/9vxHen/1jEqDuwusZ9DGJxUuygUcL7aTOD6rOl7ZS7YtPU7GT
         kW9VAPAyLNLYwdKV4DuzZPWVtiPKeP5DMz7MRG2qSSAMgSGvSEY44MSQYAnuhiAUArm7
         wFLALjasmTin8VFB/h+oDFRsbP5kPPLLt7zEOaUZSDqIt++95HH5i9zEcNfG1gqcfGfL
         O3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790254807; x=1790859607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OSLVS9HvHJYI6SUB/JDf6BpBvGujsk4TT0HCcRv1qs=;
        b=dmtoakiOucPUCsG9cOo2nqvWYA+blrSWpwrA3obUttSepEwjaR1/ZaiSMRAK2jT+Ru
         P4CV4kTmkc0ZL7uC4lBj64X0SwKT4wZkUWZCFncdtAWQeiChCF8kqZZ7xhZXDB1WrL34
         jxnaGrbCiYNeR+fFvVN4bWgwEf14ojxfiNHRr9/BN4o3HghnDDU5+iyE/3ZqqLsKYWS7
         ckwM2Bdr5VDXzc52k+K1UCvfilXsyxV+r09L5JtWCPabUwXl0TwoRjKN4EBj+dG1wXrz
         uKXSj/d7MilPgGgyRx3yAzugPB7GoLxRB+AtuRpcTCo/j09iqI2Ifddk9QybyGHY8OAO
         tajw==
X-Forwarded-Encrypted: i=1; AKwUvBxU9l67wqujrnoR7a165IoSGxRpn2lyoGLe8Pdyo8GmPbaZ7Zdv0VZ/1B9aIPqblg6wuyMw6WfF5KsoeSC4Kw==@vger.kernel.org
X-Gm-Message-State: AFuF++ln/vKs5QYSmouti14AysWl5A6BoqTtXl+E/hX6ZiN5rnqsIMpB
	7x0dlpM+7W9sKdqYUAnhsweonO6ZF3bzqx6lFnFpQ7KeAe/X66ZURYchplm5V5Ms3gP4u4Mm1t2
	VKMPEMHJTuhEHf9OQ66zSj+JFUc9MNhQ=
X-Gm-Gg: AYBFou0Fi3ZeXI3EY43L1LdicqQR4GVOColX99TQ0mYSR6cKbWizlTkut6mgUTa1bGq
	vmDte4x5uyfWZ5v6d9LRs9WDK8ripZevMdNpH6nt6k/ef+escH1rkZpGmIrEZjkPDuVMZRtlq3c
	MEyxchTohOOcVt4N07y9QgteLGkOUA0BGZLs6qs72jMbqHsWqWzwrUFY/mjiZddQ5WR278nrHS1
	sukORUsmW/1Q06RJEf1F7qjyEY0jAtTzbcUXhsbTc0CjTNAz5KSGRfqNNcYx9JxgJmV+x4NEzoZ
	S4+KKaf+eTt5U2yCfsbZk0xoKngSG74kjp8wvl5VDkBqOmZ49W++cj1f6xsPuKqsTltZMzbN8/l
	vpYWWZhC3XKMiwxLIrRdFql+SS0U2TBOzt0I0EfDMbaqfAvoB2Yh9UU6/XT8vnsQxSN3GwlB1wa
	EQ5hLboRZD
X-Received: by 2002:a05:600d:486:20b0:49f:e8bf:221a with SMTP id
 5b1f17b1804b1-49fe8bf24fbmr20880375e9.22.1790254807252; Thu, 24 Sep 2026
 06:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <fb5f25b4-33e4-4cb1-b790-3fd078c61e5d@roeck-us.net>
In-Reply-To: <fb5f25b4-33e4-4cb1-b790-3fd078c61e5d@roeck-us.net>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 24 Sep 2026 13:59:40 +0100
X-Gm-Features: AclHuK_mJiW_h0plHxsrZUqtTl9fiP-i-QY5tzFIt3qEf9WQXBFyizNrQLINkmc
Message-ID: <CA+V-a8vXd2pzw+e7GAoLTXPtSqTnij8mrT40D5zB09ToXvsqig@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] watchdog: rzv2h: Propagate WDTDCR access errors
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thank you for the review.

On Wed, Sep 23, 2026 at 10:17=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On Wed, Sep 23, 2026 at 11:40:50AM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The WDTDCR helpers access the register directly using readl()/writel() =
and
> > therefore cannot report failures to their callers. WDTDCR is located in=
 a
> > shared syscon region and will be accessed through regmap in a subsequen=
t
> > change, where register accesses can fail.
> >
> > Make rzt2h_wdt_wdtdcr_count_start() and rzt2h_wdt_wdtdcr_count_stop()
> > return an error so their callers can propagate failures.
> >
> > Handle these errors in the watchdog start and stop paths and unwind the
> > resources acquired before the WDTDCR access, restoring the reset state.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v5->v6:
> > - No change
> >
> > v4->v5:
> > - Dropped checking rzt2h_wdt_wdtdcr_count_start() return value in
> >   restart path.
> >
> > v2->v3:
> > - New patch, split from v2 patch #1 to make thing easier to review.
> > ---
> >  drivers/watchdog/rzv2h_wdt.c | 35 ++++++++++++++++++++++++++---------
> >  1 file changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index 9774fe8e441e..a65e5d6c48ad 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
> > @@ -87,18 +87,22 @@ static int rzv2h_wdt_ping(struct watchdog_device *w=
dev)
> >       return 0;
> >  }
> >
> > -static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
> > +static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
> >  {
> >       u32 reg =3D readl(priv->wdtdcr + WDTDCR);
> >
> >       writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> > +
> > +     return 0;
> >  }
> >
> > -static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
> > +static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
> >  {
> >       u32 reg =3D readl(priv->wdtdcr + WDTDCR);
> >
> >       writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> > +
> > +     return 0;
> >  }
> >
> >  static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
> > @@ -148,8 +152,14 @@ static int rzv2h_wdt_start(struct watchdog_device =
*wdev)
> >       rzv2h_wdt_setup(wdev, of_data->cks_max | WDTCR_RPSS_100 |
> >                       WDTCR_RPES_0 | of_data->tops);
> >
> > -     if (priv->of_data->wdtdcr)
> > -             rzt2h_wdt_wdtdcr_count_start(priv);
> > +     if (priv->of_data->wdtdcr) {
> > +             ret =3D rzt2h_wdt_wdtdcr_count_start(priv);
> > +             if (ret) {
> > +                     reset_control_assert(priv->rstc);
>
> It seems to me this does way more than handling the error:
> it puts the module into reset and calls pm_runtime_put()
> on the parent. This is a substantial functional change
> that is not explained.
>
The intention was only to unwind what rzv2h_wdt_start() had already
done before the WDTDCR access (the runtime PM get and the reset
deassert), so that a failure would leave the module in the same state
as before the call. I agree this should have been explained, and that
it adds more churn than the change is worth.

> > +                     pm_runtime_put(wdev->parent);
> > +                     return ret;
> > +             }
> > +     }
> >
> >       /*
> >        * Down counting starts after writing the sequence 00h -> FFh to =
the
> > @@ -169,8 +179,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *=
wdev)
> >       if (ret)
> >               return ret;
> >
> > -     if (priv->of_data->wdtdcr)
> > -             rzt2h_wdt_wdtdcr_count_stop(priv);
> > +     if (priv->of_data->wdtdcr) {
> > +             ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> > +             if (ret) {
> > +                     reset_control_deassert(priv->rstc);
>
> Same here, and the logic behind taking the module out of reset
> in the stop function and putting it into reset in the start function
> isn't obvious to me.
>
Same reasoning as above.

> Frankly, I think it would be much better and risk fewer problems
> to just ignore the theoretic errors from the regmap functions.
>
Agreed. For the MMIO-backed regmap these accesses cannot fail in
practice, so in the next version I'll keep
rzt2h_wdt_wdtdcr_count_start() and rzt2h_wdt_wdtdcr_count_stop()
returning void, drop the error unwinding from the start/stop paths,
and ignore the return values of the regmap calls.

Cheers,
Prabhakar

> > +                     return ret;
> > +             }
> > +     }
> >
> >       pm_runtime_put_sync(wdev->parent);
> >
> > @@ -219,8 +234,10 @@ static int rzv2h_wdt_restart(struct watchdog_devic=
e *wdev,
> >       rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
> >                       WDTCR_RPES_75 | WDTCR_TOPS_1024);
> >
> > -     if (priv->of_data->wdtdcr)
> > +     if (priv->of_data->wdtdcr) {
> > +             /* best effort, ignore ret */
> >               rzt2h_wdt_wdtdcr_count_start(priv);
> > +     }
> >
> >       rzv2h_wdt_ping(wdev);
> >
> > @@ -251,11 +268,11 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_=
device *pdev,
> >       if (ret)
> >               return ret;
> >
> > -     rzt2h_wdt_wdtdcr_count_stop(priv);
> > +     ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> >
> >       pm_runtime_put_sync(&pdev->dev);
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int rzv2h_wdt_probe(struct platform_device *pdev)
> > --
> > 2.55.0
> >
