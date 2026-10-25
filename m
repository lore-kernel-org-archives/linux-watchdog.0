Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792938982;
	b=MHFR1ESrzaxSwgJbco2KztiQezJtELqTRyfj6UHEyygmNVQtJRB5mnj0gmulDhUeobww
	 91uG1tgx+iKo9niAnOZuu+tVKE6JQVJ4sD8gTWh3DIBxq3ce28wpJJP/+rpFuexyP18n3
	 QNZh84HgGHqNH/kgwqJVYW/L4VOT/GlG1wJxp8Sec2mihbUY6MzyMj+zzamLyr9h8/5Ec
	 qeFxTRo4sgXaLLrWjt4oHuL/G4vno0HzHWLQ+2TwT/P/LNEU6QnYCFKfwJXhAVrbSn4lO
	 UpaY4yGheFTpyzeDZrchlQ35AL1Kjk4b8zvrUtpaL5WBYNtA7WlDGagvXQrLal75BxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792938982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Po2NCbgcvrmtddNbEBL1t3twpXIAbb1P85qqX5tTEyk=;
	b=QIIxIGWxGoQ25nvtlI6Obel3UcgHzoha8rLG8v+6xETNIJT8HXYGd5pB2SI6GejEMn1E
	 uFkKeppz3b4G5Lr7MMmnXCdU3r8anxdKLs2JncFU2QXil34j9yrHdJ6xYJArPV+0WybR0
	 dYTehKwqOAPbPd1ffX4I3AyIJgHMm1iA+o8cr7ugQZkSWhIWHsLo58AhwTzle+f4je1Je
	 XkZ6tRlIVYbzBGRDp5y3edS9xN5KLyMnEoqQnU3xwio9oRrrv4XyjRLkPFE05XTx4jAPC
	 fvdXCBh1/+kM3s0IE6wj+Vj32gNQBulY4UOZpYTqXaIO8WcexpGRRGWedgwxhY6yVpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n2fIMKE8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AA606A31B
	for <linux-watchdog@vger.kernel.org>; Sun, 25 Oct 2026 14:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 058AA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n2fIMKE8
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so3108494a12.1
        for <linux-watchdog@vger.kernel.org>; Sun, 25 Oct 2026 07:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792938980; cv=none;
        d=google.com; s=arc-20260327;
        b=gNQhnUeAIlG2Hl3axYeEGdqGu9+YiS/q0QIk+TQO+8Lw6Z752gb6Et52Mhz9ixEYrd
         wQkHiNymVfOABLbZ6AbUsJdvFW2YPYqCaful+HIs4KtrfRJvUA1zKH5SI311Hi8kpgZZ
         YhROxEPC5BF5w19eLlPHt4k3oGjh+AnYJUYu1MK5ujpSllC3Dv7+vGstHjzVElUYbx/E
         vmz/111oTbvd1oMP+Bo8x37J2F3EwuYJ+utTB7XbPX4AtxQaLZutmB55mv5qUpFgmUs+
         sU5ok9XCY3VZzd4u2pUu6dPwcyh+XYnXiM2EDp/l65BWM3FXRAfeWGANcYfhsAIRPaYF
         76yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Po2NCbgcvrmtddNbEBL1t3twpXIAbb1P85qqX5tTEyk=;
        fh=TJTEb84YfgpdX/en0C/jgWqDPspbCyJnPO/i+mx54bs=;
        b=QHtyhW/wts/zgJd6LnKQE1j7/ZOnmwTMAEDVRx4QAZnHrpR2d75yY7oUku7HCdk2iy
         zTxoX6Ig5Hjp/fmd/CZH9OyXBlEP1Xj8kKcRU3+yMLaqHfH9jamjMLASHQfzqg9CVOHX
         gyH3jL4Ob/sxLrLRS/XnQJau6EeNnI4u7CIScTHvk4J7CkP90oLH+rfML3pomHQ2EfQO
         T27gBkALQFPefPfLNt2JhMFRyAsHpw/A4+NgXm875mETWOwzk+3BIeyk5Rtv3ETnIHRG
         HV6sEnnSQezCoUV8ZKyHYqtWYxFOTdQY+EZw0JwsfgKY+ICg8sLnDuKADmGTgIRhqxFq
         X+rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792938980; x=1793543780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Po2NCbgcvrmtddNbEBL1t3twpXIAbb1P85qqX5tTEyk=;
        b=n2fIMKE8bhvhzUF3n73ULQhb1N+A/1GLW0UOgdEcpGWlJ6+IaJ7KBsNlsWqFtfC4v2
         Ae2GaG9SACGgD2rLglbw1s9w0T4Mb5RVgMVcYGSDQ1Z51YSFtbkLEyNcIVojtY/AVwlD
         xhzWbxtMBxE2f8qHhgmgSVwCf5AI/vw9BJZrWQI44624v3fNZIw5PKsBMCsjnAI0eRCR
         C+OR89H+cBnVH3/o5KTdgCIBi8vJPlucvjuMDX6e6wJob5U19VosB4JCAum5xpkEs6CN
         h0R6ARTJTyExr6bGxPzLRaYmnSQ/xp3MdHRMm+pUT3ze+ub0b6dbBVifyvq4dy4sCctP
         5Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792938980; x=1793543780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Po2NCbgcvrmtddNbEBL1t3twpXIAbb1P85qqX5tTEyk=;
        b=wmr+2pP7Gi08dQ7/sQQwIOJYwZYom0ACjFmGsA7qo9ncIuerwsjoBl5WzKfQfBlkGY
         0kJoLGjH3huXjBC2QbBF4J3XA83j9mLSzYNuFDT62/SLDR+4Oe/D3xkgUYoWHmiJHpCd
         8m9FHyoXRzYWqwVkHau6aoYCk5vtZECuHxyLY+17n+dEPF+vWP9DLtstSPJZKXtMDfOR
         GNpkWXswSNhL6qcUY4TzxOCFFtP96Ry1u10g9xRSvceH3PAsNqDQEMua+krhc/4qxrS0
         KI4LWbDPvLsKLLvXmvziOIR2f+BD+wl6zK4p4t4Po5q9DqXWkSUdVUdFaBesVM1g0ASf
         Cd+A==
X-Forwarded-Encrypted: i=1; AKwUvBzUSf7ZE3H+UDbTQgdEZqBVIYcAy6TGHVqlBoMxHUoJ13HG3VXxGltBTVhMc4+xVYXNk2Cih1obirkbf8t2nA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4pzq3e6UxBFvfWNq5fCcAu0WaWM5FLVfe8IJU1WEkMDFuDhU8
	c/fySVyFAuHqE8A6+AiE+ypf154+q85dLKEIcNpcRhzV2pgHYH+JmM8ltaTITlGejr9HWbe86jW
	lNWcWPuP2Pqnn5MWZKmpBX0K/SryIRXQ=
X-Gm-Gg: AYBFou1OBRHS66lkgIrArZf6ay/Mr1D96CKNZb5Cyla+zwb7NLnDjQNZPXKf0oDK5Kl
	EsK9DeE3u2fHvNXHRQ2976T/GlW2cowgcXpevaQ5UP7JXYO/TZt4+Viz5NoV6hZ8nHvBpaQrDMc
	M8vzmoRH96lTq/G19zKOK9tOn4FR0POPrpjfHnLyiURQWIOnjAw9iWsFH3J4L08/+8doBdCjhfR
	7cuNXZmc/ITgLPT9TGcq+ADRBP2+imQfV3/opS/+iFhK1AOioZVbBiSQmm0Rw9hSPtfG4rc72jX
	i7F+3L7jH6WQZzIhAfvsxT3EkKM0v5Yf7ZcQUyflDmJ2C+WfmgMS2SksqgODd7F9qXYGuH09tZa
	LNhVl7CylPlz1qbNp5yTAgR3ycRuwwZ1hLjFV0B+I/QRLmn0Wff66y0hZBWYp
X-Received: by 2002:a17:907:86a8:b0:c43:6fd8:922 with SMTP id
 a640c23a62f3a-c46bdaa7a52mr542836666b.1.1792938980213; Sun, 25 Oct 2026
 07:36:20 -0700 (PDT)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024140854.25664-1-a.shimko.dev@gmail.com>
 <20261024140854.25664-3-a.shimko.dev@gmail.com> <20261024-dw-wdt-shimko-v4-resume-imbalance@iav.lv>
In-Reply-To: <20261024-dw-wdt-shimko-v4-resume-imbalance@iav.lv>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Sun, 25 Oct 2026 17:36:09 +0300
X-Gm-Features: AclHuK_290JbiBCCRDiz0hbJon1lNZeyrcj89Tr3YD7jXvELikUFKEPtExqBoIY
Message-ID: <CAOPX747Y1pDm-3TMmnYiXgVpt_jr++cQakGQ=cLt96B-FxWWzQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] watchdog: dw_wdt: manage reset line during system suspend/resume
To: Igor Velkov <iav@iav.lv>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, p.zabel@pengutronix.de, 
	Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com, 
	andi.shyti@kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,


On Sat, Oct 24, 2026 at 9:46=E2=80=AFPM Igor Velkov <iav@iav.lv> wrote:
>
> On Sat, Oct 24, 2026 at 05:08:51PM +0300, Artem Shimko wrote:
> >       err =3D clk_prepare_enable(dw_wdt->pclk);
> > -     if (err) {
> > -             clk_disable_unprepare(dw_wdt->clk);
> > -             return err;
> > -     }
> > +     if (err)
> > +             goto unprepare_clk;
> > +
> > +     err =3D reset_control_deassert(dw_wdt->rst);
> > +     if (err)
> > +             goto unprepare_pclk;
>
> If clk_prepare_enable() fails in dw_wdt_resume(), we return with the rese=
t
> still asserted. The _deasserted devres then asserts it once more at unbin=
d,
> and on a shared control with deassert_count already at 0 that is a WARN_O=
N
> and -EINVAL; the next suspend hits the same. Deasserting before the clock=
s
> are enabled (or on the error paths) keeps every exit balanced.
> Not tested on hardware: I can't make the clock enable fail.

Agreed.

I=E2=80=99ve examined several drivers [1][2], and it is indeed normal for t=
he reset
to be deasserted before the clocks are enabled during the resume.

There is also no requirement that the reset be deasserted after the
clocks for dw_wdt.

I think we can move the reset deassert before the clock enables.

Let's wait a couple of days to get comments from other folks before sending=
 v5.

[1] drivers/usb/dwc3/core.c
[2] drivers/gpu/drm/panfrost/panfrost_device.c

Thank you for testing and review =3D)

--
Best regards,
Artem
