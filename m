Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930F39B4A5
	for <linux-watchdog@vger.kernel.org>; Sat, 17 Oct 2026 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792276080; cv=pass; b=gxTv0aoHKX0EbJlKnnnvrd56oL7FXNnlyyw5KqqdiSsXbkP0SOXaM4hq9M1XdByZTh/btFVLc3p9M2GaBNRBDwWZUT+GoSoJG6S0FcIn17ncrqD+c3RlIdZWXzXf10S36MRGoFkv8++S3vyGxFYo85t7nIrFJ1H+YF6v1MmDzlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792276080; c=relaxed/simple;
	bh=8GjnVBLgBaYv1z0rdaECWqGcaPppZMfW2GOTX765nuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFENuR4jpED5jueWiV2KJn9asYOWS9igOKvgfZkQmkecWLUoR89CQ6BsOPahevHYNKl6+Yp+e+Du5U6KT71R61gUJE1EBjIG2IVZHiVr3nwaFxWbknJ1V1fPn+2nOmuNkY7plzC+exL2z/8ZmZUgyvbm83YWaj7FCPNX2XlM/Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8XCX/4P; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8XCX/4P"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c315869241fso100557266b.0
        for <linux-watchdog@vger.kernel.org>; Sat, 17 Oct 2026 15:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792276077; cv=none;
        d=google.com; s=arc-20260327;
        b=JfSoTTs8qo5OTWv7Vo5etgGac6AJHq2jsef1RkEBx/J4GqFs9uUMvnS0p0tNnpXeLx
         9m8GthRo6BunBkVIeg3r6b+tMEOgOWmGK8uBcamjLXX8RObA8pj4JFOEljIdQCMCLhEP
         C0/VrwAE8ABjBRAlhIS20nUGcHW/vQoKJkVlSt1RgcVLWhbrAe5yXEzKvc1bbsykM3dk
         piPltx2oUICUqApcHnmqvFmEcxOnkbSkbMgW7zmWzTrcpUMGP0FQl2J9A9Ke9Mn83VBe
         vcgUWI7/YQIe/vNYxR9thTDByOCGY8Pj4wMcwLUwoZEw1qZZ+e5wbU6fHiDS8bh2bXdE
         eCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5DtMVKHLYZFrVZWABcgGlrAwjSrKQ0wsgdgM1oLN6EY=;
        fh=PqoXufU0OAlYZtti7E54tK4iW8qSLvNJPO7ILXCTBFo=;
        b=H1Zvd6rqOBLx/ZCQh6+QwUpzpVW6nyW9zriVsckGns9Y+kp979su5qY+Cfe1u2hmVp
         NNK4KiAvZxZWauR9EM2yHb96dm48d+QGotyutot4qcUkymUYCf1blaKqo+Ns67bAojAD
         D0XATA/ZSdMnDzfv56cpCTmujnmDiQE+hgiqPRV2vkWKsCAORgX6YpIatRu+vfBYZS5t
         tFz65p1PXIK6YsoNDMiNF+VQLAG4d1LBqEpsIMdi0TdpDdN0dvB5ssyShSlmFn2K/+M8
         iPEi/yI45oHpJFgBp9Puq4xnAMeMAywPKI7eAZ8YDVLCSE9Ubg8PrhoeYazYE3pWJUAr
         HEtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792276077; x=1792880877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5DtMVKHLYZFrVZWABcgGlrAwjSrKQ0wsgdgM1oLN6EY=;
        b=P8XCX/4PZjMIyzdqZh2YzZJRqEsAY0Z4H889gtivGJ6Kg0Y0jAeGDAKHq2oOk1NiYA
         kehdeC5YQtTmJwffJF6rfjrXDEO01QKISuP/PpAyJa5xm6RUljH7PO58PDDG7K50NVkt
         vgcBhxxZt9IGts8U6sXdvXrV2qqnlz5wCsdiNkA2zH+KxLcevH6UdPVxHqingospVdE4
         T9+bOC8bhyoCibSFCswaDCPbJJnyU1VGbvaNNRehAv9wQSttwthVBBOpiFPMgki52qla
         To32JxcS8/8IPeOJookuRx6GmZm+za74AIjVh4TFyBDW5n6eOk9u93/U+RbghBsFZEes
         2QCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792276077; x=1792880877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DtMVKHLYZFrVZWABcgGlrAwjSrKQ0wsgdgM1oLN6EY=;
        b=HdACyHLXNt73CdFlEkn3hoVpIzqk/R260YRdf/CXWMpF6SFCF/GTLOq4oBlGMCPMhp
         nETiGHlIkNarylQNK4YMyCBuyHSwiL4M2Rj1q8Jgc5Fmcm4cjC1vBqwLAZ0ybeTyCEYQ
         yt0vNnM5uRtEWS03nlco7qcrdyQxixitf7ZmE5n/bUQh+swg2CkF4icp7kma8daDHtQq
         OCHEWivrHr1787J5Xtb1hMvpZMb1TDGkNb1DDM2tCR6x1JcWWBALMaMCYI/IGsyPS08K
         2ejC5tKY/7naaG04SW2k8QoPa8NNboZ5gE+FVp2nzG3lzvz7qTtk3q882tQ4DNB+Mjo+
         A9cg==
X-Gm-Message-State: AFq9FYKk9Advsq/qJnuFylAGDRGURtPbvMDi8egIZJb8bXNRPA0ylbic
	e/fB1/xoCuEgLuwU9xVuHxkUrwox83GMJ4itL25/BLVG6AP2wqt9M05jkP29qqLqyTP/2/3FIVe
	NMjUrCmdlk3mllZ1nJq8YVPjgVic1H2Ka2dG4bQcraA==
X-Gm-Gg: AYBFou1J8rFR2djIaGtNtpOjaXvyjH2pPyspzjDkiyQ1PhznAjsIKcRZuBtTpuSqhd2
	T38DCygknobz5i4Znu/9Ea6DDV9rqZrESzJNHsl88MetHyovDJRosrwPjUNEv9WpWUiVVWf1vom
	unoo74aFukWnZb6YURDmLdoj/lprL0h6cQpMk4ERgx0MsetpIHbDn1U9Z6H3rJEOHo8JwfP4w9z
	iYrWqfE0L54ttkCUscZXFOhV8VovJf9PQQEfy38w4TO6qarRNpyn/FvoMs1gINS/02VobNTFqti
	h60p1IdKclr8rn0tTJqQTPXwHz1JrfElbh9Lp/M78SCtge3SLRLbDIYkzywdOak3j3trV73uP8t
	cdCh/znsd5n8VS6iHITzs+naLom3/7KIhNiNM/GTl9y27BCQMTGWpoZulaoLFFueqfq46K/RtkV
	0AwXA=
X-Received: by 2002:a17:907:930e:b0:c40:eb1a:4c8b with SMTP id
 a640c23a62f3a-c419fded7ccmr227588666b.29.1792276076901; Sat, 17 Oct 2026
 15:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004213755.554191-1-voytikd@gmail.com> <e7c99dc5-dfa4-4ce7-b7da-a3a70a2710a8@roeck-us.net>
 <CAAX90H0qGF-H8BYcmT_vbUGoqN9RbfeGxMdTTRyQPK_h8MzFhA@mail.gmail.com> <053269a6-41ab-41eb-8756-b6a04eea2e5a@roeck-us.net>
In-Reply-To: <053269a6-41ab-41eb-8756-b6a04eea2e5a@roeck-us.net>
From: Dmitry Voytik <voytikd@gmail.com>
Date: Sun, 18 Oct 2026 00:27:32 +0200
X-Gm-Features: AclHuK8tE_N4UG79q7e2DudOKyQpIuX0mkjOdoteD9hdJcJ3YMDpvAHZdwNlj9g
Message-ID: <CAAX90H1-tzrH6hwHHrvfQi2e-TXQKmgNy0Lj2TXG7yDbKYy3Og@mail.gmail.com>
Subject: Re: [PATCH] watchdog: allow WATCHDOG_PRETIMEOUT_GOV_SEL=y
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 11:42=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 10/17/26 08:59, Dmitry Voytik wrote:
> > Hi Guenter,
> >
> > Thanks for reviewing the patch!
> >
> > On Fri, Oct 16, 2026 at 8:21=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> On 10/4/26 14:37, Dmitry Voytik wrote:
> >>> Fix the issue when WATCHDOG_PRETIMEOUT_GOV_SEL can't be set to =3Dy,
> >>> and always is =3Dm.
> >>>
> >>> The issues can be reproduced with the following steps:
> >>>        make mrproper
> >>>        make defconfig
> >>>        ./scripts/config \
> >>>          -e WATCHDOG_CORE \
> >>>          -e WATCHDOG_PRETIMEOUT_GOV \
> >>>          -e WATCHDOG_PRETIMEOUT_GOV_SEL \
> >>>          --refresh
> >>>        make olddefconfig
> >>>        make mod2yesconfig
> >>>
> >>>        grep '=3Dm$' .config
> >>> returns only CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL as module:
> >>>        CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=3Dm
> >>>
> >>> "make menuconfig" doesn't let it to be switched from =3Dm to =3Dy eit=
her.
> >>>
> >>
> >> This does not explain what the problem actually is that is supposed
> >> to be solved with this patch. Since this is just a selector used to
> >> enable other configurations, and the configuration option does not
> >> result in any packages built, "WATCHDOG_PRETIMEOUT_GOV_SEL can't be
> >> set to =3Dy" on its own is not a problem.
> >
> > The issue is that
> >    make mod2yesconfig
> > doesn't work as expected. Help says "Change answers from mod to yes if
> > possible".
>
> This does say "If possible".
>
> > I might have misunderstood it, but I thought all configs should be =3Dy
> > for this make target.
> >
>
> $ make allmodconfig
> $ make mod2yesconfig
> $ grep =3Dm .config | wc -l
> 51
>
> Not really.
>
> > Maybe a dumb question, but why does only this config have " default m"
> > and others use
> > "default WATCHDOG_CORE"? Does it have some special meaning with "defaul=
t m"?
> >
>
> Again, this configuration option is only used to set the (default) value
> for the watchdog pretimeout governor, and the "=3Dm" states that the defa=
ult
> should be WATCHDOG_PRETIMEOUT_GOV_PANIC=3Dm, not =3DWATCHDOG_CORE.

This doesn't explain why it's =3Dm by default.

> > I want to have no modules and still not disable the module load
> > ability, and it annoys me
> > that some configs don't allow "=3Dy" :-) otherwise when I do
> >   grep '=3Dm$' .config
> > I need to remember that CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL is a special=
 case.
> >
> > FYI, for Arch Linux based config, only
> > CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL pops up with =3Dm.
> > A fix for the same issue with CONFIG_TDX_HOST_SERVICES seems to be acce=
pted:
> > https://lore.kernel.org/lkml/as04AoNxjzlvh-K8@thinkstation/
> You are comparing apples with oranges. That commit states:
>
>    Fix the issue when the driver always gets compiled as a module.
>
> There is no module that can or will be compiled based on
> WATCHDOG_PRETIMEOUT_GOV_SEL.

Sure, I understand that. What is the semantic meaning of making it by
default =3Dm? And why can't I make it =3Dy?
I understand the build artifacts are the same, but I'm curious why =3Dm?
Why WATCHDOG_PRETIMEOUT_GOV_PANIC is not =3Dm by default?
Thanks for the explanation in advance!

> Guenter
>

Best Regards,
Dmitry Voytik.
