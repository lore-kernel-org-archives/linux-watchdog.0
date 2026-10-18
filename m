Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509F407CEF
	for <linux-watchdog@vger.kernel.org>; Sun, 18 Oct 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792356269; cv=pass; b=YyZhF2hvO8TMMn2sTF1+IsnpoqAsYIPy5zHJ9HN9QJ1AJDPf0vIwQ74CYJDCAwD5CQLsMOuuWolUN7mnUM8bE5OGFh04wlBdQMfkMYdhZOfC51vudkub1KDJYjZzNktwYcMzG+7Da5uNRUxp02RFScF3dlEBRyt+qeZJFeHWuw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792356269; c=relaxed/simple;
	bh=g/M7nl8CAMWTDaPZrkIyMM2srI0yx3TbivxMXYTz5I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDXEQx6QWqI4yutT2ozYZIf+u76tbEI46/YTmbUDUg6YB1LSGETVs38k3Tc7JEPdikAGXqOwlF/o0TILE/Ouy1hbFZaqwEvIp/ru59FLRM/wj19h7VPiLMTy1aBf5xxUAYbys7pjYK7jTCBaAfJszj+h4xhjqPjL11hOELnTNXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkIX/iv+; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkIX/iv+"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4086e892a4so171446766b.2
        for <linux-watchdog@vger.kernel.org>; Sun, 18 Oct 2026 13:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792356266; cv=none;
        d=google.com; s=arc-20260327;
        b=IFCgBocQr/qLVgrUqQqpv6aY/tC9uP7s7PCAhRaX6rzO7ci2XDzfDrNspPT+Gthdjm
         X+PXAodowYEdbH6n6RsIuAG7rEasAT3b5ISnMBEHzTlqET4SQisNplEk+MA7fuC/nFKW
         gRdELH82yrAkTR9DqBVD/XH1A8mVm6qm9+oVVaYD5Dk68ODYFmVQieAdXFeQk5aifYbc
         JpgnO7vwtWxhdPdsB4aaDV4tFQPrO2F2wEUFjlmSH3aFmnbmOaUihyt+w2vTEVjeh2GK
         i7whfYeZtQ2ZkH/IjllM6frqIFHTyoR6uTZ/ZW3BIAacNb88nx5mr+ep00TS7IU//HdW
         HCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6+3d8Jw9619cDYgKWR0sQxv7zRJyClsX6yDbXUYOrpg=;
        fh=PqoXufU0OAlYZtti7E54tK4iW8qSLvNJPO7ILXCTBFo=;
        b=aA4KcfxawA4AGyN7TBYljAq2recNuT/vUMqLvVjlFjRuey3YtYkKUu8Pic1dU9B5ai
         2yOqnrhLYKoxltdI0bR+hkxJljbd0XifAb7UddRrBIGTj4bJrLBSjwBk1gZqnlwMaBkB
         vjnjgcm0Z/SxkUexrsmXRqTelbVRgQeZzkfhLjNQWe9FK1UUK6mm/q3s1vDHlJa7Dq8B
         lTSiPo2qiKV6GZJUFfja2t01LZGCbbApRnC7jpZwvwFEqKsSyPfaxrUHylA0GpF+obR4
         pnIQy5h4Kpm/YGbeNLgGB30+JxOzvHO7RNTKTbA3rn/gIj5Cser5I0U9bSgnbSfsW/N5
         yQMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792356266; x=1792961066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6+3d8Jw9619cDYgKWR0sQxv7zRJyClsX6yDbXUYOrpg=;
        b=ZkIX/iv+M5/D5yFFEj4YlZqpvdMPOnIP7LxI4kX0MHkVXHUTrZjUssaWS7QfMP3Ahj
         SJZf9d30friV9jy+z6n0SDOkXcceSReOcnCS+N2ssL49mzRVjamZqGkgJKbgflNeZmrX
         E21w6A4PgRhgLETAxAhbr49KgEJPliP/fmK5OLgeo6FqhLea3AQHof+UP8O8pXp2N3y3
         25XGEBja6XHlGIvktNLgsqYu4/DBVAsxadcCCmguHM8Bb4GahwWERWE8EumPRFEIZAXd
         lqovZ9Vpcng0BDcBJxpbErtOKtakiQyP0eyUMpzjmDP7VUrpRMAejay/HP2S6l9TIgIL
         Wz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792356266; x=1792961066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+3d8Jw9619cDYgKWR0sQxv7zRJyClsX6yDbXUYOrpg=;
        b=1slYbygk5L4YvDhVDHl9ujN3AZqgaqvwi0Ww4PTDfoaOs+9F7K79tpM/pCRn7g1XFW
         wIXdBHVR5/SovOobrONf5oFQ5W49z5KuVa2vJpBfbJqCp9guE8wWUo72ODCdfwpQA+kl
         XkIKqDDpydfSFYIz4yuzqQ3orn5Nx2dvilFyMa5iWEPNPJZ63uW7sZllhlrGsIOtF2ub
         oH9qIhA1ipHtOnl7U6hUEzmN9YJaTqPQchJCJtViSLCGx3sFSpG2LyKZgCUIfaQI5Gfy
         vPPYYYUANNPCiKhbX1c8y0JVsvAhssaDDESuAG1lUhyk3ZFW23+0Eay5LpMZJaEpvGI8
         xHGA==
X-Gm-Message-State: AFq9FYI0kT81Xgv1nkYSZmm7FbMj2H2MY3rfeyk8NSrI3ubvsh6sZlBl
	m16FDKYc8CRebZx2NzqoZTqNbUinc4lnk2ZsgnCuL/OH21onfgMtNkKEAxC/4jQorRZzuynY+ad
	GDpHncBOX/WG4KbvW4DCgBr3ShsVnVAA=
X-Gm-Gg: AYBFou0QSUeFoKPlAK/rKk5o/PlePb3TUuONOK/NyN1ptjF0o9ZRX0jgnHpybNSbpZg
	F+JuUPmHvLrf5qis9zEJvrAKHZ+xNAElJzowgl5LkLJuxN9QugxrI4oOgYAJRTjfyjgupNu9HVL
	Jp+qXDWvRvsw4Tz8i87pUFrCkofqerQpiQF6J7jUGfd0ET437qkx65wGFDI9mHOS1b/O/t1NUIF
	hGlTFgxAmps4HughUTX+cLwHl6aLtASaHf2KhaZNNaWNCsYDL8wWY3Q8jmDMq9Ay48qur2z49NY
	kFBR+XU1UNg41rWeFj8L/1fpEZA0h+oeekDR3vAcl5lik/KfBiC4pXPldEIsdH/DvVTc3nCats6
	3E9OZYX2FFetne6/Tn44GY2JLcAmehkTmPpOkws8eg2YwK5aFRWWAkTUi/jtH5mzj56GWAghtJq
	ifsjs=
X-Received: by 2002:a17:907:5c1:b0:c3f:8c92:3b4a with SMTP id
 a640c23a62f3a-c419df3e37emr375365066b.8.1792356266116; Sun, 18 Oct 2026
 13:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004213755.554191-1-voytikd@gmail.com> <e7c99dc5-dfa4-4ce7-b7da-a3a70a2710a8@roeck-us.net>
 <CAAX90H0qGF-H8BYcmT_vbUGoqN9RbfeGxMdTTRyQPK_h8MzFhA@mail.gmail.com>
 <053269a6-41ab-41eb-8756-b6a04eea2e5a@roeck-us.net> <CAAX90H1-tzrH6hwHHrvfQi2e-TXQKmgNy0Lj2TXG7yDbKYy3Og@mail.gmail.com>
 <170e005b-c6e5-4b48-bc01-9b07ff918252@roeck-us.net>
In-Reply-To: <170e005b-c6e5-4b48-bc01-9b07ff918252@roeck-us.net>
From: Dmitry Voytik <voytikd@gmail.com>
Date: Sun, 18 Oct 2026 22:44:03 +0200
X-Gm-Features: AclHuK-b7gXo_-aEK7081eT4PczvypQ9XyQklJwYCDAyJl8ejlUOVi5e2L1RXsI
Message-ID: <CAAX90H052BKT1d6NZSt4AvnHVc5A6xC2ntkybKmPj=LqhGA18g@mail.gmail.com>
Subject: Re: [PATCH] watchdog: allow WATCHDOG_PRETIMEOUT_GOV_SEL=y
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 6:48=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 10/17/26 15:27, Dmitry Voytik wrote:
> > On Sat, Oct 17, 2026 at 11:42=E2=80=AFPM Guenter Roeck <linux@roeck-us.=
net> wrote:
> >>
> >> On 10/17/26 08:59, Dmitry Voytik wrote:
> >>> Hi Guenter,
> >>>
> >>> Thanks for reviewing the patch!
> >>>
> >>> On Fri, Oct 16, 2026 at 8:21=E2=80=AFPM Guenter Roeck <linux@roeck-us=
.net> wrote:
> >>>>
> >>>> On 10/4/26 14:37, Dmitry Voytik wrote:
> >>>>> Fix the issue when WATCHDOG_PRETIMEOUT_GOV_SEL can't be set to =3Dy=
,
> >>>>> and always is =3Dm.
> >>>>>
> >>>>> The issues can be reproduced with the following steps:
> >>>>>         make mrproper
> >>>>>         make defconfig
> >>>>>         ./scripts/config \
> >>>>>           -e WATCHDOG_CORE \
> >>>>>           -e WATCHDOG_PRETIMEOUT_GOV \
> >>>>>           -e WATCHDOG_PRETIMEOUT_GOV_SEL \
> >>>>>           --refresh
> >>>>>         make olddefconfig
> >>>>>         make mod2yesconfig
> >>>>>
> >>>>>         grep '=3Dm$' .config
> >>>>> returns only CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL as module:
> >>>>>         CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=3Dm
> >>>>>
> >>>>> "make menuconfig" doesn't let it to be switched from =3Dm to =3Dy e=
ither.
> >>>>>
> >>>>
> >>>> This does not explain what the problem actually is that is supposed
> >>>> to be solved with this patch. Since this is just a selector used to
> >>>> enable other configurations, and the configuration option does not
> >>>> result in any packages built, "WATCHDOG_PRETIMEOUT_GOV_SEL can't be
> >>>> set to =3Dy" on its own is not a problem.
> >>>
> >>> The issue is that
> >>>     make mod2yesconfig
> >>> doesn't work as expected. Help says "Change answers from mod to yes i=
f
> >>> possible".
> >>
> >> This does say "If possible".
> >>
> >>> I might have misunderstood it, but I thought all configs should be =
=3Dy
> >>> for this make target.
> >>>
> >>
> >> $ make allmodconfig
> >> $ make mod2yesconfig
> >> $ grep =3Dm .config | wc -l
> >> 51
> >>
> >> Not really.
> >>
> >>> Maybe a dumb question, but why does only this config have " default m=
"
> >>> and others use
> >>> "default WATCHDOG_CORE"? Does it have some special meaning with "defa=
ult m"?
> >>>
> >>
> >> Again, this configuration option is only used to set the (default) val=
ue
> >> for the watchdog pretimeout governor, and the "=3Dm" states that the d=
efault
> >> should be WATCHDOG_PRETIMEOUT_GOV_PANIC=3Dm, not =3DWATCHDOG_CORE.
> >
> > This doesn't explain why it's =3Dm by default.
> >
> >>> I want to have no modules and still not disable the module load
> >>> ability, and it annoys me
> >>> that some configs don't allow "=3Dy" :-) otherwise when I do
> >>>    grep '=3Dm$' .config
> >>> I need to remember that CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL is a speci=
al case.
> >>>
> >>> FYI, for Arch Linux based config, only
> >>> CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL pops up with =3Dm.
> >>> A fix for the same issue with CONFIG_TDX_HOST_SERVICES seems to be ac=
cepted:
> >>> https://lore.kernel.org/lkml/as04AoNxjzlvh-K8@thinkstation/
> >> You are comparing apples with oranges. That commit states:
> >>
> >>     Fix the issue when the driver always gets compiled as a module.
> >>
> >> There is no module that can or will be compiled based on
> >> WATCHDOG_PRETIMEOUT_GOV_SEL.
> >
> > Sure, I understand that. What is the semantic meaning of making it by
> > default =3Dm? And why can't I make it =3Dy?
> > I understand the build artifacts are the same, but I'm curious why =3Dm=
?
> > Why WATCHDOG_PRETIMEOUT_GOV_PANIC is not =3Dm by default?
> > Thanks for the explanation in advance!
> >
>
> The idea is to build WATCHDOG_PRETIMEOUT_GOV_PANIC as module
> by default.

Doesn't this contradict to:

config WATCHDOG_PRETIMEOUT_GOV_PANIC
    default WATCHDOG_CORE

I double checked with "make menuconfig" - when I select "WatchDog
Timer Driver Core"
and then "Enable watchdog pretimeout governors", it sets by default
"Panic watchdog pretimeout governor" as =3Dy, not =3Dm.

Anyway, I'll stop arguing. I may be misunderstanding something here.
I'll just remember
that CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL can't be set =3Dy for whatever reas=
on.

Thanks for looking into it.

> There is no "why" to answer. Why build anything as module
> by default ? Are you going to question all those 478 default=3Dm
> configurations in the kernel ?
>
> You still do not explain what actual problem you are trying to fix,
> except that WATCHDOG_PRETIMEOUT_GOV_SEL can't be set to =3Dy, which is
> not a problem. The only problem I can see is that you don't like it,
> which is not a reason for making any changes.

> Guenter
>

Best regards,
Dmitry Voytik.
