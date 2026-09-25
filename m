Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9243B3F5
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327385; cv=none; b=Y+bL+p1ytLzPxQY8tYT3SKQYie4m3YgBtRJUiFUHb6I4ilgJQqGqAc6G06S8sdTsHZiHudLKoMKpo2uuTwu9WE3+p+1FJ4nYNUzuj0Idj2YAue0SA4LiQ1LNYyiLE6dfD9hO4hZAZowY/7z+1ufZbwEb3oO1yjX60ZOpur79Tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327385; c=relaxed/simple;
	bh=JSD+TgIxUmEnVVwDb4pGLRv6GJ5iCZmtvwC1TTcFDd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLauGPGzg6m+yA9WRPeJm8hZEE+imAygscsjjDn77QxMjy3/+XkYOBvAw8PthtO/VJywFvjLbdymEzrCeu5LnusZTNm0ka/TCi2sV6jxz6K7kti5Daa/Li7PqZCAhUPhcn8F9KNEG0giwZEs78IDOaMTGTHRplQldYCiZvhgr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a03fe69236so203769137.2
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 02:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327383; x=1790932183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2mULua+FE1sFuKc/3gIaxuYjcdlUYIe/5IDBg6nt8Q=;
        b=o5nkre3sydRcHYUJZ7XZ80Lg/oMXaFr0BHwEojMWKflhn0+rk8oqbWzi4HE/9siXfX
         bkGZE8dCcUzMg4YJTCghDgP1f13spOYfWbwc4CuYlKea7BiARdUsdISeMN/p+Y6Vq2ht
         cxYjBnnKBWMjG1gq0ZyZGm4dPFvfyk9eIKk6nunBibwvh80BLDy0PjZs+Xtvmcgnb20f
         hgU4HCXPeHHpPyLwuLih8V7/Ab6p4tqosf6NSmxU2Vdy/Wlo25iWJRH0JqEJwzcGNRk2
         L6eSXjbuftT7zZpX7vYyC6k9VweUbxB9jExxgdJfLrx72p34ZuZvzCEhkCvfGX5+rasJ
         RlTA==
X-Forwarded-Encrypted: i=1; AKwUvByK8Tobc6FR6t8GbHX1dNpYtFbqVviCa8yklKoN30tvVu4GY8Ph+9RUG8WR5G1MjLVCHyatPO5o4yNrpIzzNA==@vger.kernel.org
X-Gm-Message-State: AFuF++lWcNFVzlEayB5YJtmmIdHbms1Yqzze9D9zM1qDkekBKptL50ZX
	AxKVWeuPQwLflysnX6Pwm9fmSHq4DqBy+9ZisCSkzJ9oLXeF3vRhTCCb7H0pkDF3
X-Gm-Gg: AYBFou1EhAZGCvC1Jv0TWrML1GUZcZm2vAK6ifxDDRaADmjCqEL6b0FaXLv0M23oiCf
	Yo+dvY64Yzsrk/JHwIlZLEsDu/+rxywsWE7pFppcUrSOKwpoSMWLEr8Z69/lxDjJgRBoL8xUgAG
	bJLIgZUKUNLe2+8JZZLyebsbfx8efiBQF5lzv7SWM/8yryUnReNrm2z4jE3coKaNNBgxTw9atn1
	RB/1lb5uZOsCHFa2kb+cmZNLo89eiHmpsxSy7GTA5BA1mIzylK65vLA6dKV/hLHxi1PoBOhe+vB
	1/0mlRLnZ+KDWMsasEvGsv385g/aODHKH1oeffVemL8q+mhzvtHG1VOz70KfHmVSfYtev5vLjGd
	CoYTpXMbvBQhwOfx8JaTmO/qcjPyAbG2kxHsO2N3r5yJkX9D371c70uxj2rXHsv2ljCq6X4DR8u
	t1mJo4oTAZ6V6p8UAeLkzHuOG+BnHlN0sxjsfRslILK098l5ozmIJQPvfBK7dyOrHnJt9GiV8ag
	inORstTKjSY+6ETZ/2CiYJGNqUEF6fnpAmDMw==
X-Received: by 2002:a05:6102:3347:b0:7af:893b:da04 with SMTP id ada2fe7eead31-7b1d56a2fa9mr498813137.25.1790327382667;
        Fri, 25 Sep 2026 02:09:42 -0700 (PDT)
Received: from mail-ua2-f39.google.com (mail-ua2-f39.google.com. [74.125.226.231])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861afb9277sm1861827241.4.2026.09.25.02.09.41
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 02:09:41 -0700 (PDT)
Received: by mail-ua2-f39.google.com with SMTP id a1e0cc1a2514c-982db8d3b1eso200347241.1
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 02:09:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByczkZUC3hj1jdc/IYnQOLw57/1brl6c43ud3aUZpypMAr+rb90vPs+mLojOEHiXdFq52G3wo7VIjcLL1sZZw==@vger.kernel.org
X-Received: by 2002:a05:6102:3972:b0:7b2:508e:3d57 with SMTP id
 ada2fe7eead31-7b2508e43dcmr267969137.4.1790327381172; Fri, 25 Sep 2026
 02:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923105237.7B87D1F00893@smtp.kernel.org> <CA+V-a8uD16uG8cc9m7NHVZXT5bU64TYfu+_1POuXeioRAy6Z+A@mail.gmail.com>
 <4f5aadf0-8f23-4871-918f-430a0c99900d@roeck-us.net> <TY3PR01MB11346CC8B3C7374C293E0F3EB86802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <2d32d7f1-f87b-45b3-9ccd-95e9773ca658@roeck-us.net> <TY3PR01MB113461EFFC2B9B39A53ED1D3386802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CA+V-a8t3HKQ6D8jb_y-XM64BHkWm3vRw6JiTydSp3rqVr9nhdg@mail.gmail.com>
In-Reply-To: <CA+V-a8t3HKQ6D8jb_y-XM64BHkWm3vRw6JiTydSp3rqVr9nhdg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Sep 2026 11:09:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZwnRtp=f0iOiDqoLVjBTGVYNbbLeP9E3qjTn3RUEkUg@mail.gmail.com>
X-Gm-Features: AclHuK-nFf1UvHjbP4pR_ScRMT7oB1x_81A0GYs9PIzd7j0I7JJQ2mhJ3JMjGP4
Message-ID: <CAMuHMdXZwnRtp=f0iOiDqoLVjBTGVYNbbLeP9E3qjTn3RUEkUg@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Guenter Roeck <linux@roeck-us.net>, 
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"wsa+renesas" <wsa+renesas@sang-engineering.com>, "robh@kernel.org" <robh@kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Fri, 25 Sept 2026 at 11:06, Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, Sep 25, 2026 at 6:11=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.=
com> wrote:
> > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > > On Fri, Sep 25, 2026 at 04:13:24AM +0000, Biju Das wrote:
> > > > Just a question,
> > > > For automatic software upgrade, if the reboot using PSCI fails, wha=
t
> > > > is the fallback for reboot, reset the board?
> > >
> > > That seems to be a bit theoretic. The reason for having the ability t=
o register multiple restart handlers
> > > is not to have failure fallbacks, but to have fallbacks if preferred =
restart handlers are not available.
> > > If the PSCI restart handler is present, it is expected to work.
> > > That is why it has higher priority. The idea is to use the highest pr=
iority restart handler, not to try
> > > one after another.
> > >
> > > Sure, the failure fallback works as well, but that doesn't mean that =
fallbacks should be provided just to
> > > provide fallbacks.
> > >
> > > If you claim that the PSCI restart handler does not work on this syst=
em, provide evicence, and we can
> > > discuss this further.
> >
> > I agree normal cases there won't be any failures
> >
> > I never heard about PSCI restart fails. But have seen a case due to a b=
ug in

Oh yes, if PSCI is not really implemented ;-)

> > serial driver that made the PSCI restart to fail as it hangs the system=
s.
> >
> > So, if this is the case, a memory corruption can cause the same.
> >
> > Long back I worked on femto based product(single core), where we have n=
ormal restart
> > and a fallback watchdog restart. But it does not have PSCI system handl=
ers.
> > On some cases, we have seen automatic upgrade failed because of failure=
 in
> > normal restart.
> >
> If you think the PSCI might fail and not restart the machine the other
> alternative would be to export functions to configure WDTDCR using
> readl/writel.

Well, if PSCI resets fails: that's exactly why you have a watchdog
(or two) in the system, right?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
