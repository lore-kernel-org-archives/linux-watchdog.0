Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD783932C0
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126818; cv=pass; b=fVsu2BHubrUZcWQSIq4yhGWzbBVlXFgVbUgrPI/5WWaHpR1WtbNrswgliAvww0Vfv1fsvvEyrb/i+8R+dJzAe+2O7I9JZetRY8Iko6Avplw3mJ5gNU7G9E+2eGfr3QpZV7ZvWml/JnDBfy0qfDWePfaPguGm/mE553Cwyjz5vMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126818; c=relaxed/simple;
	bh=jXGJ1+Cv6nGnyJj2lXAv0ULWiPCyAn1DaGrDuuzFGiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgNn4p7B8a2o1B5cEHBXYHzHAVyb2nyFRlkmvebSFjjxVGVKOpmbPMft/qtpUvP1BKVnMZvLgoUu5G9sM2FjU7N9jDaRXefJRDT6IqeeU4I1NN3WuGgjA0sqD2wND8RmwZn0+ehYxX4ZaPsnrUSJDAWhg1BOIeh7TmchxoiHM5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZbMltyq; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZbMltyq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so480914f8f.0
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 04:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789126814; cv=none;
        d=google.com; s=arc-20260327;
        b=GpAOtKGjflI6vZ/LzWxlxho3hzfY39UHnsoiu8QnyQ9CrqI1qCQ69lYf2Xxw5Sw6OX
         eR3W709BJBDESZ9EaoYwQ6dFkzTXsrWP7TNir3PnxbxTc/IgR4PsJ3y1Rf0MFgs4i/Nn
         OYBgSmv5X0+CVtB4gnDIHSG04DckuPeaenCcG7LddnUqM9NXCPqRTe8H8v3SPQycZDf/
         uQn185VfODxD2h4cXtaGE5qRxCEDNofMPWwTuYwys48jyEuFcKKxHUguVXOVdBwOR2wL
         C5XS9i7eNavq7kbh0eoAmxu9qkBsnqzqBNp+K3pe61LEL0UwhuVfyZ8b/y95xOHdY9x2
         n2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VG+qeXnRBa8SMBywMNzx/mbp44ozs4FNe3yNR5x/cvA=;
        fh=K1NJekQzYeztA5I5ggJDCswpKc91gut6u8ai2utVlZQ=;
        b=g53NFmqdqFIWqk60NrISwtLmO+72lgnbEdf48jAf4TwHt/zBeVc8mQCrkaxTBsQpjV
         sX9fYxcNVlOnfsS95t9YtqZluhkvw1QD2upEsG6EIG7m1V6cnymSep3JLjOXfrffKq18
         IRW086xpXCXB24OfTNfNmMvJ/98WWigQ77I0uVfEcxC80gd6Is+Wr06JCYej3sKxakcT
         2fH7xJoNxmyi8hyxTr7AONnHWCF2OXCSUUlxkTZ7jpEK9p6rtFWeBZ9+qjQ8c9RUQUXW
         eCtWpNZzDZYdTlxDv+aTa5xyBXBljZYaSe+Esq/JcLmoV6VJJoJgLyz3kO9p70I4KivQ
         YTDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789126814; x=1789731614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VG+qeXnRBa8SMBywMNzx/mbp44ozs4FNe3yNR5x/cvA=;
        b=pZbMltyqOoDJE0Rt5RTvlbbNvoX037nNu3WO8yDdb846lmGTRnSwQ0V8J3C8NQgeme
         CB59e993VaDl6G8sxwbUc+3ZmR348edxcM9bQ5+KerdkQhdO7ui8iMbN/AYSSnYpyoJn
         l4Zzyr3IxKy/UHS/B9imMrITUD800I2bKLvnf6HWUFSUERiAeGkVjHY9x9KivebIM5EW
         fKTjGc8UA3GL3ILcQ0aQitEwbSVO4ZC11nn4mEUgIFt41iP7nwJxqkbwVC8KBX/1+NUW
         sMZzDO8jvstySDS4KWUSj0oO0gotgWvkAU6t2/HWYfk5t4QskZDR/KJxVE9azTvDJGUq
         dORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789126814; x=1789731614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VG+qeXnRBa8SMBywMNzx/mbp44ozs4FNe3yNR5x/cvA=;
        b=N2q6pPqwcZ4c+oyPtUjqGqZIyDGT7AwDyvq6VbpOwDco7epunZBgdhLade9JiTxZfB
         PGR81d7zfgLEYt2DwBnvBEqLiLXQdWK1+rzGdy7fRLx4st2uaP4pOTEEGuqUMGqDs3e4
         PH5uY899Td7gI5YgzNGF6UMaj0kf5P5fEhS2q0YjAhs1yeUnjSJnBQfd2E8b/6KXkDI2
         sSgU0ww2oizkQdgg5e4Drg0m6Xgo6NcxX0ZZ4v3ysyzRrZu4ldgh1jxVcax4s9ACTZLX
         3u7/l8s28jaTGEoHdppuaqdMHjjlVS0Pz6EVCQvWkQKzV7BdOBOHoSjYp+58yuoOmdlo
         9DLA==
X-Forwarded-Encrypted: i=1; AKwUvBwt9SuNwSRi6InpIJbX3mq7+P4CT34X1uQ3hpj+W7bweBXjdVRofUqylpWwjt9nz4JRrgmwUfKcP84AJI7Erg==@vger.kernel.org
X-Gm-Message-State: AFuF++nUInAEvGdw8Qf6MxOoM+N6ScHvmXY41kJef6PslksSZL3plKKw
	xE7rASF+1YbpfVCGhJtEO5K08JFSMKRJPbGMsT/6yBtrexbYi/xaEo+Yie9L70mxdi81m2+pqMt
	+M+wz6wm57qogSSjDiNeWHyB1Uxnw2bo=
X-Gm-Gg: AYBFou2t34xlTuk1rtd18tmYIxCpnioebpE12Dk5mHkPykgQyNsc2yzqHmFATnKnYna
	VvqwCx0pJb/goryocaZRVOl2edw0vDU9N/AsRf7HuJcqH6xQDElONEii5IVBRgHE661JBLyfq7L
	xq3TeQDNB9Pr9jK7dsyLsHx2aeV9r4g82oJpsc4A9pfgsSEEEKSShYwGy0pYcerYRwmJaXsiT/y
	84SAf/TNYWD254Y2na8NlIKb5/KQ+RbV0QnYR0+b2tO9QARlD93UdDF9IUoieLRzDou2ZwkPUwV
	Pi4Ufm8Xf7iu5BK03cGoPImfcRoyjQOW8aTu2IunqtlMmj9KCAYgiWiDUO/LRYGUS8urKPPEftR
	rMEwVPtKAAC+IZDeRD5Kp1PsPgGg2HA0My51UHEdNJ1i0bxmTTDAXXcj4BpI9rCJfer8ix/u4ig
	==
X-Received: by 2002:a5d:630b:0:b0:484:3604:c7bd with SMTP id
 ffacd0b85a97d-486eb31c4d4mr6627074f8f.17.1789126813565; Fri, 11 Sep 2026
 04:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260911112804.39EA91F000FF@smtp.kernel.org>
In-Reply-To: <20260911112804.39EA91F000FF@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 11 Sep 2026 12:39:47 +0100
X-Gm-Features: AcwNN1WJ8okh1HOUuJE3ueC1NR-zA8LxQ9g_9pvoKKyvz8W9CWr4L1YVLC5FhrQ
Message-ID: <CA+V-a8sQZv-NbarMqTHiH4C3TaanEJF-pAb56tpZpN9M-xWBzg@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
To: sashiko-reviews@lists.linux.dev, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
	wsa+renesas@sang-engineering.com, linux-watchdog@vger.kernel.org, 
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sashiko,

On Fri, Sep 11, 2026 at 12:28=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Watchdog restart handler may deadlock during system panic becaus=
e it executes a locked regmap operation on a syscon regmap.
> --
>
> commit a3a7e98fdd4da0cb2994accaf697498b31aba4d4
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> watchdog: rzv2h: Add syscon support for WDTDCR
>
> This commit introduces syscon regmap support for the WDTDCR (WDT Debug Co=
ntrol
> Register) on RZ/T2H and RZ/N2H SoCs. It retrieves the SYSC regmap using t=
he
> "renesas,sysc" property and derives the WDTDCR offset from the watchdog
> instance index, while preserving MMIO compatibility when the property is =
absent.
>
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index 550112446db49..9dee410ab7f31 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
>
> [ ... ]
>
> >  static inline int rzt2h_wdt_wdtdcr_count_start_nolock(struct rzv2h_wdt=
_priv *priv)
> >  {
> > -     return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTS=
TOPCTRL);
> > +     struct rzv2h_sysc_wdtdcr *sysc =3D &priv->sysc;
> > +
> > +     return regmap_clear_bits(sysc->regmap, sysc->offset, WDTDCR_WDTST=
OPCTRL);
> >  }
>
> [Severity: High]
> Does this introduce a deadlock risk during a system panic?
>
> The watchdog restart handler, rzv2h_wdt_restart(), expects an unlocked
> execution path to avoid deadlocks and specifically calls this nolock vari=
ant:
>
>         if (priv->of_data->wdtdcr) {
>                 /*
>                  * Best effort, ignore return value and use the unlocked
>                  * variant of the function to avoid potential deadlocks.
>                  */
>                 rzt2h_wdt_wdtdcr_count_start_nolock(priv);
>         }
>
> Previously, the driver used a dedicated MMIO regmap with
> .disable_locking =3D true. Now that sysc->regmap can be a syscon regmap,
> which is shared and uses internal spinlocks, regmap_clear_bits() will att=
empt
> to acquire the syscon lock.
>
Agreed, I will update the syscon regmap in the CPG to drop the locking
and let consumers handle locking.

@Geert, would this approach of consumers handling the locking be OK?

Cheers,
Prabhakar

> If the system panics while another CPU holds this shared syscon spinlock,
> will attempting to acquire it here cause the panic handler to hang instea=
d of
> resetting the system?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911111731.34=
04308-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D6
