Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FA44AB88
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126271; cv=pass; b=lFfla4Lsnb+cWuBGZUhiMZMc9GcobbvMGZ/65faudq6F1TzWmHRui7njLwwmvmlPT0qsxvY4nHU4Nq/rTd/oiCb8V9AIsDbsHJ7BEcPuuwNdTRH1QZxvY0XrmGxUGnlLb4c9/tGscdixl1/gEmj0xlXCuGjqwKiUxWqkUX0KL7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126271; c=relaxed/simple;
	bh=8oBNrn73qh+O/Q5uT6gV+BncjX+bawSkeldQVubHZBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5Wvlmifuu0MZfrs1PEaSWHkbqELRLfa/O9XT925qiDHF9TgHYHuNv5BGjuFNzzY2QruhRtKcdfSpBVpUg5JOH/55VFgWLBASXo53QVWObEFJC/el7ZsOcNL4auGTKXxa/MXNp1chUhPrSrz4hEFcG/d/08PcAXt+Nr5bZXGpd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE9E7auj; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE9E7auj"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so537103f8f.1
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 04:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789126250; cv=none;
        d=google.com; s=arc-20260327;
        b=bH61eTEGNh7N/j6Wb8wQkIbdUVv32+1gdbGotaPBZLXJzDX8KRlpQGYrJa5xoYHWoB
         Nnq7kCLK+jIypMhYtWpN4+0Mvy3hhia25Lpxyoy+25ifaYfhWuUHu7gBla9/SGt7Zn1b
         XCjzRmlSonXwqZYwq4mgjbmEkXrFswwhfqucJTb7qzKn9QFsHSZYbfgBOa4uG7Ic5sal
         CMThJMid/5K3MYvold/bgnLcy2BgKyCAq8aic68DTw+XPrDdcphEEIapjcgMN7PKx8aU
         l5tNNCafy9zbDk7zW+P8opD8P2KHCjkm0TmNWMdHXRBjxWY1VApaFHU8eDH4EIGjzbQv
         K05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EeNgemAb7lsaMF3mg8j+vPdtgIOxXFzORulJF8ZPymc=;
        fh=aypRllL/t69+VoGx5zrt5fodxRlakcMyWY3dIqe6+dY=;
        b=ESrae+Y38TK2Qg7CT+HQD4SLLXqMeizek+lStkkEdmCaYoBKbWQf4mSOV+Rh/uR4ph
         LIhxP5ZSPlxsHvLEimYpGqMMd9yGDgpW0bB4wpLwbab8Jpoev3I/Zly55Iyc2XkUkqrI
         9lgwWf07MW4XZ8qW63aKHfHRgkPqJlYVxMAHuDRxbxht9j168OuQvWv2GnztK8ndpHKn
         cJ1foC97aKrIvlieclyD0VlUCJxLyUwajhUj5D8PpXYMVDNR5c3PuQBRoKYvs4E9zhml
         l428yCSfjOXQ/m2eLSXDoTjeVKffzB5+qrh/3GCqV+ebogDshJ1XufTVSTbczKtrmXs2
         XzHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789126250; x=1789731050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EeNgemAb7lsaMF3mg8j+vPdtgIOxXFzORulJF8ZPymc=;
        b=WE9E7aujDX9wgvf2lKhxdC/OqsF0xAz/i4dlFOfi6kfoOelL8kcK7kOl6nXmJUKfsa
         scWbnvam0Py3pPCUVzooFmLEUpeQBHR4lIuYmday3tnOZqRcVBwNwO1Lp0VJ91wQEpLP
         e9Y2c9/boyZgnLYgxk+JyGdj4M3Q9ELn6rHFVJZxQuKtkqfSG3MPsGjf5rNRPo2pBErA
         iSAK0i4NgB5FARkvKPBemWtfCehRuie8NTTNvD82Z+WMirZg1OVl/5cDHBTShp29xvbo
         EPOpMSlqSPlSLiSAHmujdYhUsiWT6SRchM/CbLRhyLg2+Vd2kahSQ+BIDyv2NtKfSMjc
         h+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789126250; x=1789731050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EeNgemAb7lsaMF3mg8j+vPdtgIOxXFzORulJF8ZPymc=;
        b=KYW/CFgP6YgxDpNiSK4Tx7VepHFBhPJwbihYEreDNvoFaQKKCGgBSq3hHMLqEixIpZ
         TtwnEUmQr06B9LcaRCajuDDURIAO79F/kCt8wtebkhQ2PEGCep4E40S+aRXdwn8+ojxr
         dP/NlCtEgAsd1GnvUS8UziJfcBgsJP35k5UoqpnMvrn4yLtKaHCN1820hqEejcn+Xtk0
         QOMa3YPFNdD/F43vIvFbe5FdnIGCQds9fKiLqVsweFEld7terJZh7aF6zwvOa+Xe2eZo
         lXFwkBKDzrne/cYDstgXHhLAqfTIYKs6c9uLaFgvKfevkKby4JMQvwpm3xmc2XBE2AO/
         HzPg==
X-Forwarded-Encrypted: i=1; AKwUvByFU1PIYQ3iA90tLOr/UvetFMVkaZ54uEOFEzhrUvQqb1CkCaCal+l37GrYVQpsyH+CIqAxEeeGgUFm4lHMvA==@vger.kernel.org
X-Gm-Message-State: AFuF++kC63qgVrCsnFRDuAmajydyR1psDRLTZtY3cadOtsyLdh/Qvn3D
	PKJ7VlZyX+ex8Gar8qa73p1fGdFi7AcnIvvfJwQQbceS0LM89sfEYX4IMzzA986aRsqEUBkwKhR
	fBCqhMNPYRYUh4oHBV1afSREaUK5O4Zo=
X-Gm-Gg: AYBFou2sr7u0SRRsu1akc/O3q1e1IZ6MXvZZtS88B4cHGD9GNsTqUI9GceQ3zeUGG58
	IZG75v2Vs3BJgtcLN2qe4SQNNIFEhkNstjljERsEVff2BN6ncYhLTzitR2Zrar5RhKBf5vaM/ac
	7eSaqu6UCxGYQjrbXqCDH51KaWVLDasty8DQkHovrsENkoCki+Fd8HcO1xYmN1ql0vVwLrrBNer
	4w+tIRpgIfHXfby9IDBChh45tDrp2DNjmCJp+KL0FzHiJ4qFN5V9MtYeslcInJS3J6UeQKVhhZe
	U39MTHlZ32cJvGZ0b6ju3d4RtoUFwbhiYBknLSaA6LKFCzvGSZUlthL6F+ieY80Wz0lkvAe3/gB
	AMKR2EptswIkkc39RNoO3kdZzvZwrTzNZ7fel3xQoNb96I5og0IDtAG+srRX5+ActKqGpKlSHLA
	==
X-Received: by 2002:a5d:494e:0:b0:486:e73f:586a with SMTP id
 ffacd0b85a97d-486eb3046cemr2794052f8f.37.1789126249695; Fri, 11 Sep 2026
 04:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260911112607.3239E1F00893@smtp.kernel.org>
In-Reply-To: <20260911112607.3239E1F00893@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 11 Sep 2026 12:30:22 +0100
X-Gm-Features: AcwNN1WtZyh7B-ne7h4Obd9ZeApvbyPgvZ7Ss5X-8P5TGBqm7FWkrnhW56vuKck
Message-ID: <CA+V-a8vt0Y_9Qi7-KY2_206Be_H9GwG1g57aHwnVgx++A7_bEQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] watchdog: rzv2h: Propagate WDTDCR access errors
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sashiko,

On Fri, Sep 11, 2026 at 12:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The error path in rzv2h_wdt_stop() leaves the watchdog unconfigu=
red and missing a required delay after reset deassertion.
> --
>
> commit 3f7bad2568920b818b4bdb62349364febc443827
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> watchdog: rzv2h: Propagate WDTDCR access errors
>
> The WDTDCR helpers currently access the register directly, but this will
> change to use regmap, which can fail. This commit propagates errors from
> rzt2h_wdt_wdtdcr_count_start() and rzt2h_wdt_wdtdcr_count_stop() and unwi=
nds
> the resources if an error occurs.
>
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index 7c6a4855bd8ad..cbf414e0c9a3c 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
> [ ... ]
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
> > +                     return ret;
> > +             }
> > +     }
> >
> >       pm_runtime_put(wdev->parent);
>
> [Severity: High]
> Does this error path leave the hardware in an uninitialized state?
>
> When rzt2h_wdt_wdtdcr_count_stop() fails in rzv2h_wdt_stop(), the code ca=
lls
> reset_control_deassert() to bring the hardware out of reset. However, it
> does not include the mandatory udelay(3) wait for clock stabilization or
> restore the watchdog register configuration via rzv2h_wdt_setup().
>
The udelay(3)is not required as we are not reprogramming the WDT in
the rzv2h_wdt_stop().

> This leaves the hardware out of reset but unconfigured, which might trigg=
er an
> immediate spurious reboot if default timeouts are active, or fail to rebo=
ot
> the system during a hang if the watchdog remains dormant.
>
> Could this error handling be updated to fully restore the previous watchd=
og
> state?
>
Yes it does, if the rzt2h_wdt_wdtdcr_count_stop() fails in
rzv2h_wdt_stop() we revert back things so that further pings from the
WDT core continue without any issues.

Cheers,
Prabhakar
