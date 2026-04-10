Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACA13AA4E1
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815175; cv=pass; b=Lj/VSi2N64F4gn1+ivJRWKRR5ABBIwBVKq9+w5gwuo31aR0Y/KreTsCTnsozK2r6Bq0zEI0MN3MYuHKOe/g3SwBrdBSOl1rjybfJ42NsXRQ0mSSkxJyJgKLvHq45IhZRBCOWnjSM7z8tNFVrawyumvxs2P9nPro/UPek8CrQIC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815175; c=relaxed/simple;
	bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+Xnu9SBFwS5xUJ4smqvjGKWUfHUCGisUg9tK4cl6iCPfPjsqseEVEmsg0+7P3mBm5oNull7p2ugO3can+5Mg4k2d3inq0o4ulh8AYrV3C9T7l+2yO+dNAahAAfdZ0vZFlVUf0a/DSWlf3ObMlgH6OWy0maRfsOyTPDFNcpBElY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rErJRG4Z; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rErJRG4Z"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ab5fd969aso20382077b3.0
        for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 02:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775815173; cv=none;
        d=google.com; s=arc-20240605;
        b=W5T0raoyVh8hIW9Y/NKXBSLAXFDiWrTh3JhCNpxuJdIbKCsLma5iN8yL7MhMDc+DMd
         M3h0rqK21jrvpTeubkMlL9pE07xn1BXr9PWgpoJjYpirhGfRzaf+tR8LaOBpxrPYGzVw
         GzeicH6VAF+qCoDUlaVXXm+Aa/bIl+6DAogdUe7QOTDZcMElKgC3GLK1N+LT+j5TDsWE
         3M1ji+oQcRqGsoHnK6cT/zhFzAojfexJUXQgMdV+zkR3aH/hKNHby1p3ipnhmrwrdN4R
         GfHQ3sNFGWuH5Qft2beorQb3BuKj7fTN80zBIqTNWtEZHCzyvsIshBmcZ4cpXJbIcgML
         hC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
        fh=RRGTVL3MtV0Yn/mY8punaLzvvBftV7XRypLPNGvxBHM=;
        b=Rk4r/1TgPhkCtLgfKzohqHMsfDFh5iCdiZCLx6pbVIOOXzzKxEeJGu9kwft30bjTzN
         3PTh383xFHbrB9b5fczXu0ibCZX8w1K6u8Fcq7U66TkReQMjRVLoaC/8UkZnOu2F22O9
         6lg8vU9AmbMgDPrAiyzSYoCpXHJKOA7Fn+U+U0bmZcl7LVD+0BqHnl7vqxqsdSvEBgMT
         n6syNDNV4I2tlIjntEaC3lG6FGwD2xK0RlaEiltGHwx0Fylydvr7duYRxcaqt8tfEmmi
         nTG+r1T6pF2Tmc8Swuq7prlJ+w7KwZFFbmLiUF+Z9rUzQcVZ155mqU2rDZ2giVVbQWHG
         0H2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815173; x=1776419973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
        b=rErJRG4ZXVbUQMFbRFnmhepxOtcXBpodg5RLaOgBH+BoRSymMMJ7ImR40QJedCzbyW
         tMf1Kw0G48yG1WZj+bNeo4MywgSjIiHC6+mdUiWs/1trlCFn5wz1/AAEssiw7iJpV45I
         HfNU8cXmReN8Nsez829lTb/TBvUrr77OsqHawEgFSQ6vY1oOAVLWJ0U/Z4+fMTe/VFCg
         IR23/Yp54EUoq9dhxidWHZuyoQIaTlIzdzfge5/sD4+zoIksk5Yd0vqptdZ4fGSwlDMf
         y/S/uZCe8K9ouwDdws1zrrxjoze6PKxwMOQ8PgDitKmFK8vgUphQisVdc+pg/trHdpwt
         wTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815173; x=1776419973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
        b=N87nve5oAG0f0kd2Ve5ipp13fuZhtBGKX1rDbStpEZeIA/e6U/edJ7wyMLLjuwRWDN
         sS4Jm0uuTDkp0vQPKB8xeqW6Y3wJ5unY0VCpHu7sAISiob/AWKPdCAqQmD02hrpHuJMg
         66cuQcHDAP94nrIGYnV5Wdb2U8umHT7DXWRS56DpmUw24v8ceC6KXVplu9hc1iPcfLnX
         PcDx3JoGC+ofctNzc1+QxzlUXeoedfTSAahoh3Doj5qnugSiyHkDVwiOLCupOxmpXkVp
         ooJtleBQ1eoA12lTCbam9Sr59z75zWx0eGhHpnqWwnuqiTuNJHEDGK53vnZvInhwD8KV
         XPmA==
X-Forwarded-Encrypted: i=1; AJvYcCWLtiOlVEtURvJIM84ifsmgnumQ7NR0hXFRuF0VlaQHkNRk/XVXoaZeSGnwgKpnD3u9baiTU2sN5rl1CgpeiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60OYVSzTVqekY6iiy2j7R3CH9GAcnl4LOj73kHel/XnJD4igw
	gpJv9GFgq6mkXHsRsemN/sAYhiO/wJ19+K2FXGVAe23T+sN9P4US9FzxihIQZLvW3Dg6cgC6NU5
	WQeCYsQXBP2/2BuT/Q8n5nePLz8U+NPs=
X-Gm-Gg: AeBDiesBF44VU9lxJ4M2Nq9fHYX2GRvGEEUfMKOMnUMphwiPt2NiaUgYEv/6IrqDSAy
	19EF3ynX1TatBvFsBVfCdzt00ML6EeC+s9BZtDJZivbCwhsWQDqsg/0mEBgu5YpBp7LiRVpW0mw
	rAdw383E8eP1JUsA6RiX3In6qsElwQF2JQ1BUXRzX3CNgmD++ynZUzc6e+lkrhg49GNsqmowGM/
	1cPc2NlGLhSrjotThRohZxQoFVwP4A/i+6TSZLDNXwt6gTu+tUENz9U7g9JOXcINnV2/4bK046Y
	0Iido5USNtaCpRAJ/QrywP2VvWqwHCfRUstcgbgA1A==
X-Received: by 2002:a05:690c:83:b0:79f:3715:1980 with SMTP id
 00721157ae682-7af6f907f77mr24281587b3.12.1775815173216; Fri, 10 Apr 2026
 02:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408053037.1867092-1-a0282524688@gmail.com>
 <20260408053037.1867092-2-a0282524688@gmail.com> <CAMRc=MeJL_po8HuBa4btVowR-e0i2FyzbDgNVo2u54iPKyuvWw@mail.gmail.com>
In-Reply-To: <CAMRc=MeJL_po8HuBa4btVowR-e0i2FyzbDgNVo2u54iPKyuvWw@mail.gmail.com>
From: Ming Yu <a0282524688@gmail.com>
Date: Fri, 10 Apr 2026 17:59:22 +0800
X-Gm-Features: AQROBzChhaENjKRgm1eiXEkKC5Ek3HBghHXiZXP2Ngye9h9-wWZ61ho7Hz-V2Tw
Message-ID: <CAOoeyxXqUbdd3Y0VorzVVOARVpoEkx033sYrv5Hs4tRfst2tOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mfd: nct6694: Switch to devm_mfd_add_devices() and
 drop IDA
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: tmyu0@nuvoton.com, linusw@kernel.org, linux@roeck-us.net, 
	andi.shyti@kernel.org, lee@kernel.org, mkl@pengutronix.de, mailhol@kernel.org, 
	alexandre.belloni@bootlin.com, wim@linux-watchdog.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bart, all,

Thanks for the review.

Bartosz Golaszewski <brgl@kernel.org> =E6=96=BC 2026=E5=B9=B44=E6=9C=888=E6=
=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Apr 8, 2026 at 7:31=E2=80=AFAM <a0282524688@gmail.com> wrote:
> >
> > From: Ming Yu <a0282524688@gmail.com>
> >
> > Currently, the nct6694 core driver uses mfd_add_hotplug_devices()
> > and an IDA to manage subdevice IDs.
> >
> > Switch the core implementation to use the managed
> > devm_mfd_add_devices() API, which simplifies the error handling and
> > device lifecycle management. Concurrently, drop the custom IDA
> > implementation and transition to using pdev->id.
> >
> > Signed-off-by: Ming Yu <a0282524688@gmail.com>
> > ---
>
> This does result in a nice code shrink but I'd split this commit into
> two: one switching to using MFD_CELL_BASIC() with hard-coded devices
> IDs and one completing the transition to devres.
>


You are right that this change is trying to do too much at once, and
splitting it as you suggested would make the series much cleaner.

After looking more closely at the ID handling and hotplug
implications, I realized that switching to devm_mfd_add_devices() and
dropping the IDA is not a good fit for this driver. The current
mfd_add_hotplug_devices() path uses PLATFORM_DEVID_AUTO, which gives
globally unique device IDs and avoids sysfs name collisions. If we
switch to devm_mfd_add_devices() with fixed IDs, multiple identical
NCT6694 devices can end up registering subdevices with the same
platform device names, which would break hotplug support when more
than one device is present.

So I think it is better not to pursue this direction further.

For the next revision, I will drop this part of the change and keep
the existing MFD core logic, including the IDA usage. The series will
focus on adding the nct6694-hif MFD driver only, and I will add the
IDA initialization there as needed.

Thanks again for the suggestion and review.


Best regards,
Ming
