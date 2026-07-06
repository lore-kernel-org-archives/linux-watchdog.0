Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A17385D77
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349278; cv=pass; b=U7SBbq/fQm0SMg9qw8DWlv86U2lBHMt/L0dLxz8U/EsNUdih+ekFhnPjvMbcpffPZVXpOymuKkAx92xEU2+iqERNXb7UbIQkyXinOya4E0tOsFpDfBocYkEDLG2dTF1vz7J+tK5UFR+K6Mh70voFLEbfa5WcrhZ7VATnfmkS/xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349278; c=relaxed/simple;
	bh=z1WMhYROfcnlWkez5XhXfycvYHmg/c2mKR5LYrEvaX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKgolqJdiELh4KuLsf51NbU0lch3l09ydiDGY3WsfihfylU0QAxX8B6LbUJ+gUBTWmGePPMzKGKLqLlOZo0BrIkcRwZkY+2pIqiXSe3nRTvlW40OMNWfgeAZdnPoWMZTusgwuNucXEuCN6m/wKwlmF006tp9rDz5f37/ACahOw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgUMNXJb; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgUMNXJb"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664dd23829eso2700803d50.3
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 07:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783349276; cv=none;
        d=google.com; s=arc-20260327;
        b=OSICKeDd/u9o8KryzbrF2Hujvqpla1GHxLGYbytMppx3Uv5lP6JUk94yHaOjnedeVY
         QHi3jCejYh1UQDXUCagRZat++P0gnaDR6zbZtLSHy7q7JLy7UdSsyjLST6mNwFrJJYnc
         HU6eHVJd05oY5a896O2HwuyNknrISplYQhtV6UDSHWTyx0C/vMi4q/SGyhlgIr6ZgQA1
         LtsEwyK4BJXpxgQq7GdXzmOmupKJRLBXCS9M9xn+JTRczMsa9TSmzTbxs4OZdB7dpbtV
         QE1QDKNUviXETBIJXjgv2XcKyVZQ2RQy6kKzx6FRKINsct3SvvceGTnJEZcBjNsGvwar
         vi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p5nnj/UGt/6jwYg2fLgCm/eVqC9qp6a8hp/dGZkv014=;
        fh=TNN5xbVSf7lLwj4ApKcyE7G3kf5VsFVYn/o/d1sc3ME=;
        b=ExKzLSgKJ/8BITwrld8XQEQHn1gkza+jEM8JjoaOjTXSFetwZkhawlrUctF/WdOkty
         DebWUT9OHkeiCUQ/Yaup+xj+XlJsTEo1UuZNBwR2zXBgmvPApRlz0lfVBGTbDiezov0I
         uxfMIiYM+UZIRW8yRbgB9gkQvO+jrKTqOpb4p5hPIB8+/nzsBcF+mHeJQavzVarv/Cb3
         HB5IvZ1BA0q/JU/IZZYy59vh7rtkFXROtC7FD5bcc9erP8aWhOVCfCtgEKApGMbG6jIo
         2al1RSYpmoPLvjgRqtJO+47vwk9af4uojtZGLlv/0IKu6jKmmmVsUFsuuTV7okDEf5au
         fPJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783349276; x=1783954076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p5nnj/UGt/6jwYg2fLgCm/eVqC9qp6a8hp/dGZkv014=;
        b=rgUMNXJbtlXwBKBtJTWUmMtPbUQoz0hOEcQ5d2QfKC5PE5X8vL4fxqTJf5tnsIes78
         OXkoJhWgbCWczLJhcAJnEH0AhQ5WEEUEIgZYIIPH8vRWG9/OJEig3rjVDB1lHgnJ2eo3
         jMwQ6kp8AWFu0r/8tYLmFjYb3Hm+L4IL7+0kBok23MoVXgJLqB5wTcQtWV3OsGcDLfQH
         cip1IQTeIBga7ShNWIqeV+rtAKd6q/vL9kFhMt3W3k9FmutB69PLA5O0g2fV9HsauYel
         J8J98JWLdu/24E81mcbVCs/WXPvlGKnolBMmqVTR82+AHaqyNboSgjk+snbabdvGTJap
         hqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349276; x=1783954076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p5nnj/UGt/6jwYg2fLgCm/eVqC9qp6a8hp/dGZkv014=;
        b=hpBjYN00nZ3y5L9O0PMZH99Gr2zjTcG6IQRBPb0P1wdsX5FLCkFmHtg0jmi9fX4jMK
         Fgr1EqRLz+P17cGf3p3WA/oI7DmQ8HCWwSVzNPZ3q6+gE3oPSnE8hTfagQL+AYk7JZqS
         9+yHrD4NkAoO0GSaueHm0zop9ft/Ki7R4SmQaHZM7vxqFUf8+aFDVAhiF5XicYQ+cywo
         1gWHeGOCjutQ4d0tCKAYdmtRG/aCSlYL1BLXlj7KwoZ+8jf92MgKB8LmzAFqBLVUYvUv
         d+XchvtIBgcjt0Bp0L0PV+pUktODJXhBRV+UWKauBdlPF94M769GthwkwwUD2uWv93LN
         QjSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrU3URgw4BuPdlNcgV5EIdb1+tMt3qNc9QeMivOZHmfFS3D1+oqV8IEDsrrRQMoIC7RaIcxc6BCKcATnJsscw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Zc2PU9pK8O8NVEZGvS4pxnM7Z0wSvabxRUs/xu30PAnG3PM2
	JOKtwP1dHi6nYkkzPgpaUoineOpMiegDpE/SPmZGsk8+9p24A20ckHAhRcNsfvppLiNirlzGjwM
	2mv0/mj0G7odjXiVgzhuhOm5LqMjyyfc=
X-Gm-Gg: AfdE7clLRSt8iWYVxbw3RAMNc9qc7LocNFnboGSc5ikDYRUk1C2/ZFj5WMiyjYlymPq
	eMebsVE/LM7Da/d4+kM830AkokaxRdOI6uYscL7lCI1oABfbUTKEo8w8MV+tsvwsM8f7grX/cNN
	x6m+aaIttZ/0PfnnRqZDgsTCnp9B4LodNls3o2GhBgJsiMiiTSFonhz2I/+cv7dcbgeDZ1eH+p5
	+Vh/u+imUoWs6exCnkwB//8aISM4i7kg430rMuCnKcWw1A093Gk+C9EfHMce/7xmORmeaO+uw==
X-Received: by 2002:a05:690e:14cc:b0:664:d162:6b79 with SMTP id
 956f58d0204a3-6677fd1eed7mr679747d50.77.1783349276001; Mon, 06 Jul 2026
 07:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705140100.1543486-1-tmaimon77@gmail.com> <20260705140100.1543486-4-tmaimon77@gmail.com>
 <20260705141048.75C5D1F000E9@smtp.kernel.org>
In-Reply-To: <20260705141048.75C5D1F000E9@smtp.kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 6 Jul 2026 17:47:45 +0300
X-Gm-Features: AVVi8CdXTk1bIQEOW3h9KTSW1KJWWjzHAZ_jfS41xGm8rGDEHzBzwdiWBU9odgY
Message-ID: <CAP6Zq1i_n7OSPJDBxKfcJnDutFC2B1jmGdFJ0M_F+rv7SOGNrw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] watchdog: npcm: add bootstatus support
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, 
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 5 Jul 2026 at 17:10, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Non-atomic read-modify-write on shared syscon registers corrupts=
 concurrent updates or incorrectly clears W1C bits.
Not needed, only the WD using this register.
> - [High] The driver hijacks standardized watchdog bootstatus flags to rep=
ort unrelated SoC reset reasons.
Approved by the maintainer.
> - [Low] The driver hardcodes physical MMIO base addresses to identify dri=
ver instances.
>
> Pre-existing issues:
> - [High] The driver leaks a clock enable reference on every timeout chang=
e and fails to clean up on probe errors.
> --
>
> commit 3d82c9ef067a4770a83258e13cbb0ed566d4998b
> Author: Tomer Maimon <tmaimon77@gmail.com>
>
> watchdog: npcm: add bootstatus support
>
> The NPCM750 uses RESSR and the NPCM845 uses INTCR2 to latch reset indicat=
ions.
> Read those bits during probe and map them into watchdog bootstatus flags.=
 For
> NPCM845, cache the sampled INTCR2 state in SCRPAD10 after the reset statu=
s
> bits are cleared.
>
> > diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> > index e62ea054bc618..82ff3956dcf21 100644
> > --- a/drivers/watchdog/npcm_wdt.c
> > +++ b/drivers/watchdog/npcm_wdt.c
>
> [ ... ]
>
> > +static const struct npcm_wdt_rst_map npcm750_rst_map[] =3D {
> > +     { 0xf000801c, NPCM_WD0RST },
> > +     { 0xf000901c, NPCM_WD1RST },
> > +     { 0xf000a01c, NPCM_WD2RST },
> > +};
>
> [Severity: Low]
> Does this code hardcode physical MMIO base addresses to identify driver
> instances?
It is hardcoded.
>
> Matching the resource start address against hardcoded values in
> npcm_get_reset_status() can be brittle if the memory map changes in futur=
e
> SoC revisions or alternative device tree mappings. Is there a way to use
> device tree aliases or instance IDs to identify the hardware block instea=
d?
>
> > +
> > +static const struct npcm_wdt_status_map npcm750_status_map[] =3D {
> > +     { NPCM_PORST, WDIOF_OVERHEAT },
> > +     { NPCM_CORST, WDIOF_FANFAULT },
> > +     { NPCM_SWR1RST, WDIOF_EXTERN1 },
> > +     { NPCM_SWR2RST, WDIOF_EXTERN2 },
> > +     { NPCM_SWR3RST, WDIOF_POWERUNDER },
> > +     { NPCM_SWR4RST, WDIOF_POWEROVER },
> > +};
>
> [Severity: High]
> Does this mapping hijack standardized watchdog bootstatus flags to report
> unrelated SoC reset reasons?
>
> Translating NPCM SoC-specific reset reasons into standard UAPI flags migh=
t
> cause issues in userspace. For example, WDIOF_OVERHEAT and WDIOF_FANFAULT
> are strictly defined in the UAPI to indicate thermal overheating and fan
> failures.
>
> Could system monitoring tools misinterpret a normal cold boot (NPCM_CORST=
)
> as a severe hardware failure and trigger unintended alerts or shutdowns?
>
> [ ... ]
>
> > +static void npcm_get_reset_status(struct npcm_wdt *wdt, struct device =
*dev,
> > +                               const struct npcm_wdt_data *data,
> > +                               resource_size_t start)
> > +{
>
> [ ... ]
>
> > +     if (of_device_is_compatible(dev->of_node, "nuvoton,npcm845-wdt"))=
 {
> > +             ret =3D regmap_read(gcr_regmap, NPCM_INTCR2_OFFSET, &rstv=
al);
> > +             if (ret) {
> > +                     dev_warn(dev, "Failed to read INTCR2 reset status=
: %d\n",
> > +                              ret);
> > +                     return;
> > +             }
> > +
> > +             if (rstval & NPCM_RST) {
> > +                     ret =3D regmap_write(gcr_regmap, NPCM_INTCR2_OFFS=
ET,
> > +                                        rstval & ~NPCM_RST);
>
> [Severity: High]
> Can this non-atomic read-modify-write sequence on the shared syscon
> register corrupt concurrent updates?
>
> If INTCR2 (and RESSR below) are standard read-write registers, this
> sequence could silently overwrite modifications made by other drivers
> sharing the syscon.
>
> Alternatively, if these are Write-1-to-Clear (W1C) registers, writing
> rstval & ~NPCM_RST will write 1s to all other active status bits,
> inadvertently clearing them, while writing 0 to the watchdog bits,
> failing to clear the intended reset flags.
>
> Would it be safer to use regmap_update_bits() for atomic updates, or if
> W1C, write only the target bits without a read-modify-write?
>
> [ ... ]
>
> > @@ -220,6 +430,8 @@ static int npcm_wdt_probe(struct platform_device *p=
dev)
> >       /* Ensure timeout is able to be represented by the hardware */
> >       npcm_wdt_set_timeout(&wdt->wdd, wdt->wdd.timeout);
> >
> > +     npcm_get_reset_status(wdt, dev, data, start);
> > +
> >       if (npcm_is_running(&wdt->wdd)) {
> >               /* Restart with the default or device-tree specified time=
out */
> >               npcm_wdt_start(&wdt->wdd);
> >               set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> >       }
> >
> >       ret =3D devm_request_irq(dev, irq, npcm_wdt_interrupt, 0, "watchd=
og",
> >                              wdt);
> >       if (ret)
> >               return ret;
>
> [Severity: High]
> This is a pre-existing issue, but does this code leak a clock enable
> reference?
>
> In npcm_wdt_probe(), if the hardware is running, npcm_wdt_start() is call=
ed:
>
> npcm_wdt_start()
>     clk_prepare_enable(wdt->clk);
>
> If subsequent probe steps fail (e.g., devm_request_irq() returns an error=
),
> probe returns without unwinding the clock enable.
>
> Additionally, npcm_wdt_set_timeout() calls npcm_wdt_start() when the watc=
hdog
> is active. Since there is no matching disable on timeout change, every
> WDIOC_SETTIMEOUT ioctl increments the clock's refcount. This prevents
> the clock from ever being disabled when the watchdog is stopped, leading
> to a resource leak.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705140100.15=
43486-1-tmaimon77@gmail.com?part=3D3

Thanks,

Tomer
