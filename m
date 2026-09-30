Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6041A92A
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810281; cv=none; b=XydFl2MQ5Tzkzht0imv4ye2JyVXXPknzAhssVgoz3unornSxe6dFL06VcLVQbNsN8KM0EMvf2DIEP6gPqEOtk65IJiPFu0Whj0FiNHLApSpqnStWbFTwypMa7WiwdntZMun+/vwHhhlxGU6eSq4hFbtMk1kWNOSz0Aokqb10EXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810281; c=relaxed/simple;
	bh=MQVYYLbltUu3gM+x2chnL6/HZHcYyjfddY/XCJbMqzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFnsf6CshOVO0x5NeY45ugLKqf2m/9V/brxkpvWLcilo9dCTtBiYpWyU+mWsiDiXPRz/9nJKlBmvcHTYbKYZcsDGGZSaxwKRDbYICBe4OanbDbQFSltmvOHR2aWnND19AAgm5GXMpUzaFEhEM/Ux++ERz4x1hOJFf26PMLnLZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bbNm1bcZ; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bbNm1bcZ"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba379d8804so1944704e87.3
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 16:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790810271; x=1791415071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MQVYYLbltUu3gM+x2chnL6/HZHcYyjfddY/XCJbMqzk=;
        b=bbNm1bcZLW/4PhXvUVqT3GSWJEzzmfBnklS2Ag0bpisyIN2//R5Q2chIxjpvtWln8g
         4A+V+lSUxtB3af2JmF77n3u3ahNxVDFrF2+kgZCiwCULPokQCRnrjFeoTbYtyZQAMnXG
         fYp67UhIEqERjDu2jW2iFgaRn/2sO52cjoisA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790810271; x=1791415071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQVYYLbltUu3gM+x2chnL6/HZHcYyjfddY/XCJbMqzk=;
        b=hl8JJtiW1i65h9LyfHIjiKCZmbgsb23Cc03qQsDhBBHgyFmI5LSVGkDNglBdZqo8Yn
         pIVzV5+pKGaFPZhW9LtAYc1zNFSw71jnGvKm+fXm6c/Q7jJZ2rOUyRiMH3cZw2BgDk2M
         uQoIMu8/7GnGmfX0gjE0jfvRdTd91YH7SVR0snon8X5HlhzGe8qbI9Utwbx9bdDqxl/L
         ZsZcf4+etp+Bdys/EBfKZrj0TzbBPY0TWF/gMz5QfvQtlV+IUACcm/jKB9mV8cc/+NKI
         ANCVnfn6VHEc+COWK0tSTVRZ9LFFacCPsBAgqmtahN4yQMusrSN/qmkWXeFlE5Rz6RdC
         TI1w==
X-Forwarded-Encrypted: i=1; AKwUvBwyTPLodhLaGKElZ03EQScFfBuE7FNLydPbFQyVDyV8lYOGuSTk6XFamrPcwjxeE8gn8DsvoqLbpvOTV1hBlQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLLHF2492oWmJwvfub73XwaV/IiA18FBQuifPl/3ko67ID3BMfx
	uJxBPtEDYi9piqXNrB778nCxPMp8rtVtO+h3wuopJ5GH+N8SY3YC7lFoYZdsr5QEy/VZCiO4r/i
	mb6S42A==
X-Gm-Gg: AYBFou0ds8JGgbcj+VTVmxbHfr7IvFxLPUSJL0VHZbPfo8NpZkl+2rBVIWMBNYfSy0H
	RzQ+9gqyL0tqFTJneZLZjWkPQl6ibzxqmc8hiQuLZ1tc3D7P78/J3o2BKLN/N6eoaqJzLbUsmEk
	cu2Ayv8qYzG6oNmiCONAVNKe2hotfrw8fNA//E7ybzquP2YNQxWUbBS060dhxXdYQH4ecCX02hS
	h1Tv0Bfny1Sgj+dSB/1sKYXGD7wCouEPqd7jCXG+9Oor8NbeQEPNkHOoDaB1LOqGvQTwuBR+1h4
	0qfvtZBoJ5VIFuYmlvKR2c+jlUjswoPrilpvoKcWH+DNROkLzCjsyucNcTrDwFO13zWfSnPNwjL
	Z4D46sGMgOLYButJ2/x99gECQPf8Bx65HnbTHR7b6JYyBT12EOgplaiswNoxCIHsMrdNuog+z0B
	4rMn350lXnzqe/eb1mmxBHzIezd49+X84NwmjoR5KSQibxhKZn/vX10qhHpXyRh9KsaGRLu8MWh
	vUSZYMa01Yh7LdHa4Cdb6wVkeMsB708PjHBCbQ=
X-Received: by 2002:a05:6512:1390:b0:5ba:3888:7055 with SMTP id 2adb3069b0e04-5ba406119ccmr1279362e87.48.1790810271413;
        Wed, 30 Sep 2026 16:17:51 -0700 (PDT)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com. [74.125.225.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42faa60esm280572e87.15.2026.09.30.16.17.48
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 16:17:50 -0700 (PDT)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so55054475e9.0
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 16:17:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwe4446UBYy8FTgCCGtByp9A315fMkKIKJgF6pCUKbpFIjyE49irSDyh3czlsDjW8fH+tQSK/6+LsBF5fGMyQ==@vger.kernel.org
X-Received: by 2002:a05:6000:2885:b0:487:9a8:9f31 with SMTP id
 ffacd0b85a97d-48b025295ebmr5666042f8f.41.1790810266894; Wed, 30 Sep 2026
 16:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
 <87fqzp8jex.ffs@fw13> <87wlt13zj1.wl-maz@kernel.org> <87v78l6oha.ffs@fw13>
 <CAD=FV=Wdqn7UiuRy1VY-qH+JYChLTEQgmj2q6Q=FBjCZ+5eo1A@mail.gmail.com>
 <CAD=FV=WE-Wn60zTn=nsq4qLis_zjncrS37fND6ehtpuvxYp+DA@mail.gmail.com> <87o6deh0pm.ffs@fw13>
In-Reply-To: <87o6deh0pm.ffs@fw13>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Sep 2026 16:17:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VuSEzHw8JJsTXuGEEe-w_T=_w6ycsqpzpNWDHxMqyJdQ@mail.gmail.com>
X-Gm-Features: AclHuK_lONYIi2Rjd5xeZvJ8IkAtljr3_IbRPhmnlL1GcuMTyl7rym8vZ20aZcw
Message-ID: <CAD=FV=VuSEzHw8JJsTXuGEEe-w_T=_w6ycsqpzpNWDHxMqyJdQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] genirq: Synchronize in-flight handlers during NMI teardown
To: Thomas Gleixner <tglx@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Mayank Rungta <mrungta@google.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 30, 2026 at 2:46=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> On Mon, Sep 28 2026 at 09:14, Doug Anderson wrote:
> > On Fri, Sep 4, 2026 at 8:26=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
> >> On Fri, Sep 4, 2026 at 8:11=E2=80=AFAM Thomas Gleixner <tglx@kernel.or=
g> wrote:
> >> > Of course this is a regular global interrupt otherwise it couldn't b=
e
> >> > requested normally. So this sets IRQF_PERCPU (it has to otherwise
> >> > request_nmi() would fail), but that looks like a hack to me.
> >>
> >> At least on GIC, promoting a regular global interrupt to NMI (or
> >> pseudo-NMI) level is possible, and Mayank's use case here seems
> >> legitimate. Any suggestions you have for making this look less like a
> >> hack are appreciated! :-)
> >
> > Throwing an extra plea out here to see if we can make forward
> > progress. IMO being able to make watchdog driver "bark" interrupts run
> > at NMI (or pseudo-NMI) level is an important thing to do for
> > debuggability of the kernel. It sounds as if there are no general
> > objections to the idea. I guess the next step is to make this look
> > less hacky. Is that something we could send patches for? Any hints for
> > what you'd like this to look like would be greatly appreciated.
>
> I think the objections have been layed out in course of the discussion, n=
o?

I guess I'm still unclear on one key question: if we post up clean
patches that allow promoting global interrupts to NMI (or pseudo-NMI)
level, would you be willing to review and eventually land? I got a bit
of a vibe that you just didn't like the idea in general, but maybe I
misunderstood. I just want to make sure Mayank doesn't spend a bunch
of time trying to solve this problem if it has zero chance of actually
landing.


> > I'll also be in Prague next week for both Plumbers and ELCE, so I'd be
> > happy to discuss this in person if that helps.
>
> I'm going to be there, but I don't know about Marc.

Great, I'll make sure to look for you.

-Doug
