Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045C3A1A3F
	for <linux-watchdog@vger.kernel.org>; Sat, 17 Oct 2026 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252815; cv=pass; b=YO8Y0N1RjQGIf6W4wO22XFkHvujH8Ge+We/HbXMyGIEoo56DBl4lmebmzkkCLfkii+AjVE7jxD29GJS7+ZwIO5lzDFsxgeSiSkeUuhxhBemyVdf77eT6MoU2FlBDHIW+H+hEw0eWhfTdLHYt/yatBVBdu4wimMkshjb3dPuxwW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252815; c=relaxed/simple;
	bh=wiy+NLzkwFoKdfeR9uWNcg9YIp8IfEjhimuqcA3+buE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gK43SL0TbvQnbe/eP3Ro38TMoI4AG4xRj7pLsyRX0twN3SbYFRf4BSiHpFfWxuf00+js7x7LGlvef4bvDWbOuHv3NmR9gLaqKB6Im/C39g6rujYhLLymeAAExu2MmPVc1RtAHDmt9HQ95WmTE1Vsaj7hVO6JHbcmI9pd43s79Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLm/4uV0; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLm/4uV0"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4086e892a4so99479266b.2
        for <linux-watchdog@vger.kernel.org>; Sat, 17 Oct 2026 09:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792252812; cv=none;
        d=google.com; s=arc-20260327;
        b=csiIQK3yFwAnCHRLWxV2FNdk9VDqIaDITW0hBL1OZG92+LB8Oh3mWYikQbPdAq0bTK
         MUwrjd2hte2MFY/9KRfXybwfRRG6Kd4+qSaxEIyXowZX2oCQ7J2YkSodUEoT00kKfmzI
         hkpsOm0VHH2EEcGZ/m6EZW9/J2YNxwB+esmw/ItXjDDin1vLS/n4ySBHhZa+dfeK8sDO
         DDt67Z6EqPzgzvor+fWWJBGZ/MJQ+14NDMja5f0pXGWbxcEDhvyTdeL2gN1FLdGPRAOo
         R4F8T0IQLrieAruOnpY0vwginDSa3N+uRqBdmd5/pwvG+7HUNrK8bAd2AwAr6Pp82tDY
         97cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=heuAmACvgemhYqOlhZaeKhFmZFnxaUC/Oh++mSifMjA=;
        fh=jMwOAv3a1KBPjrTlHAQu+AGCA9shpRi3w7luLoZyiB4=;
        b=EwfXFneTAWg3ETX9ZyAtHZbGFpEtrNtATFWPB9ChEwtXCKJBci0XO/PmkUsCFYRavQ
         IiBDHGLnDF8sRod79pMaQA6X7BkFVuOCqj84rW2YgxMHIRDVeGH57KJvILV83bAfyP1g
         FOmQon++oZAJT1AmesnF/+1FMVB+SKRKZj/4xODGGgKLcQ3ZcsNBboIPvzYkNUKKeoa/
         5Kopi+2NvmfqHMWBBuCukU6plc1mNhxEnddAdqWZNQWUowwLyHZdGu+STiI7hFMmd/0w
         PcJ8x1VjsCEfdohl6cvGf8d88CJgvqh5Nyox7BN4p45Q+j+ulRMdMLrx7KxcwsVxX8k+
         Us3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792252812; x=1792857612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=heuAmACvgemhYqOlhZaeKhFmZFnxaUC/Oh++mSifMjA=;
        b=KLm/4uV0RMxKs37GrWWtsedpsHFWNLX7wH5iybXVlKt22bhKEdLuP/uYc3zNUITSVn
         6WB8bzy7gzOj00T0oe4yDzol7SajekpKRLTvf92Peq5ywK2Vn/F50k0jzjz/myt/BxiP
         Tvks4umgbWG34Kt8GGFgNzuqS3hx+/WP3wSF/JxGGkxkVfm1jfQnCMJqPnpjNHHURwWm
         1ttPv1+wrHS0y+Joy7E+ImNw9K28k3trVCL8/R+ZOapOmleZ9nsRgEiaU46mnNwzGfEj
         oQTzfpbdoiK/Gx7LKXlho3M2gNQlBqmITPOdunP/1EbA6OI8GRd0NRYu0jfzDpFMVBEA
         dqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792252812; x=1792857612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heuAmACvgemhYqOlhZaeKhFmZFnxaUC/Oh++mSifMjA=;
        b=qJfNRvqwoDHZpGq9mm1SdQsm/HJXwDYB6Scuz1uZhhZvZ0Lgc9D5XXZvuhysmFjkYI
         rzWGxv8TWHs1SH+ypYFsCAcp8wYR7xVb54U369Txgw435UzsSCYMjyf6oPLJJnFuUmlS
         5Xutd/DZnDMpOVXyIdpp44XSUgDLRPn7Y8rIggJ1McOZtvuMvEx8AvHfsMzUyXvRi0sg
         8t+sEJS1WB12T2vrnGbrclWnA+w1nqjJ2ayyLytcOJeyO92v3HgDmEqr9wgOpNc7mumJ
         XL4SCSmfINqNe5z0umCb6SjHRp0eTA55EtAR4iDQ26mQdMDO64TsHlYIoRBKXy8CzUCY
         OziQ==
X-Gm-Message-State: AFq9FYIwwv16ePx67Vt8aSv4thnIc4GWbc5HWLWX0xZNS1SY56ScEHM1
	xAYvxtz4prnpe+p8kp7rzk6K1SRvjPGSNBpFRRSzq5+yUIUBc6VvRgGphdndkhU2sg1hwuGmKps
	xtTSNkME/8txVH08Z8e/HIawY8cXx6Z0=
X-Gm-Gg: AYBFou3+2E2c/CTCbsPePoXk0Ga32y59/oL9XeLF2v5iC5MI1rpUMcwNMJALfijHrOp
	i9BqojhTJ1URcgcE9lkodPdism4mcqT+oqFaaHk8vOmWVod/KVNeygeuRsw4GAxd8OOVN8pUZF1
	hbRoGWRaviFw7ofEVDq6ODnLuvm3Xw/8pRfq+ZzBWbhOnp9vcU+VL9Ud4o3Vc6pPhpAnG87XTxe
	5pg8ryTYwFF2mcOXl/f2xbiCXVjaq9a8HxnR6UjIw1FXVi12k+klC5KmkYK4d0Fx0H7/gwA0/mV
	/p16+w9wQpiD9WW5Kj0uySeTehRSzbMGUkqFn+e2ZOBHGcz1tV5hbTuMPrVhtrNqrqZo1YCH2oM
	2bEtCGM2MVY+eQ3Y3g+uVE0UDuPRyKHW8dlMxcqb1uujiBSuIJCqKLRetguQcwGBaj58f
X-Received: by 2002:a17:907:d08d:b0:c41:8736:8c38 with SMTP id
 a640c23a62f3a-c419f703a50mr183625266b.30.1792252811604; Sat, 17 Oct 2026
 09:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004213755.554191-1-voytikd@gmail.com> <e7c99dc5-dfa4-4ce7-b7da-a3a70a2710a8@roeck-us.net>
In-Reply-To: <e7c99dc5-dfa4-4ce7-b7da-a3a70a2710a8@roeck-us.net>
From: Dmitry Voytik <voytikd@gmail.com>
Date: Sat, 17 Oct 2026 17:59:46 +0200
X-Gm-Features: AclHuK9eyUQ-EeMBBG5As37PnBuim74fPBHiC1Q9YRECSk0aLgHjvs0lsct5Mig
Message-ID: <CAAX90H0qGF-H8BYcmT_vbUGoqN9RbfeGxMdTTRyQPK_h8MzFhA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: allow WATCHDOG_PRETIMEOUT_GOV_SEL=y
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thanks for reviewing the patch!

On Fri, Oct 16, 2026 at 8:21=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 10/4/26 14:37, Dmitry Voytik wrote:
> > Fix the issue when WATCHDOG_PRETIMEOUT_GOV_SEL can't be set to =3Dy,
> > and always is =3Dm.
> >
> > The issues can be reproduced with the following steps:
> >       make mrproper
> >       make defconfig
> >       ./scripts/config \
> >         -e WATCHDOG_CORE \
> >         -e WATCHDOG_PRETIMEOUT_GOV \
> >         -e WATCHDOG_PRETIMEOUT_GOV_SEL \
> >         --refresh
> >       make olddefconfig
> >       make mod2yesconfig
> >
> >       grep '=3Dm$' .config
> > returns only CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL as module:
> >       CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=3Dm
> >
> > "make menuconfig" doesn't let it to be switched from =3Dm to =3Dy eithe=
r.
> >
>
> This does not explain what the problem actually is that is supposed
> to be solved with this patch. Since this is just a selector used to
> enable other configurations, and the configuration option does not
> result in any packages built, "WATCHDOG_PRETIMEOUT_GOV_SEL can't be
> set to =3Dy" on its own is not a problem.

The issue is that
  make mod2yesconfig
doesn't work as expected. Help says "Change answers from mod to yes if
possible".
I might have misunderstood it, but I thought all configs should be =3Dy
for this make target.

Maybe a dumb question, but why does only this config have " default m"
and others use
"default WATCHDOG_CORE"? Does it have some special meaning with "default m"=
?

I want to have no modules and still not disable the module load
ability, and it annoys me
that some configs don't allow "=3Dy" :-) otherwise when I do
 grep '=3Dm$' .config
I need to remember that CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL is a special cas=
e.

FYI, for Arch Linux based config, only
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL pops up with =3Dm.
A fix for the same issue with CONFIG_TDX_HOST_SERVICES seems to be accepted=
:
https://lore.kernel.org/lkml/as04AoNxjzlvh-K8@thinkstation/

Thanks again!

> Guenter

Best Regards,
Dmitry Voytik.
