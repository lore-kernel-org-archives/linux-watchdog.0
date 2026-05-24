Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7F3FF1
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779589203; cv=pass; b=fjo6ktbS4gp858C7NKThkXMuSz85h86uTmECWFGHqhhj+zJUQUBL0mqqXC3Zl7iWEC+Kr3i3/9mWLP1yHwCqs/33CcVVStUoTbzQBb8IbTmPhnKgVpEBYGPo9iuof1YqDqM2C5gJUiPL9VykUnS3yOg9MYvohV3xN2rds7jgJZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779589203; c=relaxed/simple;
	bh=r2LLTQ7fhBUTq1v8XPvfzGWyEwPDCTkP8vI2sshuvKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqDxNpvN9LyfGx4eXtlPgA192tDt9sJ4JPCamctSuHX20jwL7Bh6saCLpr295erxYEMJSnWDboUQ/IwdOasRtbIB5FnmtOLLp2C9S56u2HTnoH6Dj6D4ft/EnbeRV9QwzuvErhu/NH/axqlCOMZdft9C0n/oeqfNX2Fu2K8EjBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdlAnGtS; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdlAnGtS"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67bb5ad91bfso17229304a12.0
        for <linux-watchdog@vger.kernel.org>; Sat, 23 May 2026 19:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779589200; cv=none;
        d=google.com; s=arc-20240605;
        b=E+IBcOzCfzEUbLgSVbXUTtfKC5Do/sACZmVNJRim5b767hInRPEcrhv9oN81mCp4vu
         ycOEEhboyBcnsCfAPBbgwTQvfezfyL0IXr8rkRk84xqgKp1Hy6ar5H494qqy8bmng3hl
         miwYv4kIUp84mh1chGNomovpA9HB9+TKZEiQpIUF7wpAHerdQDxCEQ9kPAU17hj9lS+w
         P3rKzEoG52Pt6HC/tLaxXQ5MrRjRsTw1Z6XVZDibLo3pCVOF2uFdtHPyIldZdMgp0JXU
         jgLmsyzhmBvkW+ISDtWPz2b66HuimrDyctwQySmcxSlvImgV0alnrb6BHlaI0iCX+ZKY
         PufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aHQ3iAVdgRbGDQ5MY/Sudz6ovqWFvWub/1D9p3tFQO4=;
        fh=zt2hjtFWVrBSbexOnXx/digRN2O0tNSOK4/ceCsrIlE=;
        b=GfTgeUezb8A+WUO2a65h5LJiw7CsCyNVMF0pZTbpxxx2rQzNzLglV1Vac40XbrUVbY
         zq8ICBu7+z/p/77NbwwZ+h7qvfRSJ1BHruwkwFypv7H0nFAddhvoiY0zbNJBIkshO7M1
         Z9qZdlarExSZwg95W7uOkCcAHDzQnYhfdwcp9FJ9SG2MWN1xPi6jDahspOX/myhtIVW/
         7fyxdMXvpXsebf1Jl47VNPh7dOMhzAz+1jErOJuKnnAQbVjf/OuOLUUQqYIqe1gS/FC5
         pSkzOG/Hs9hbANhJFQinK4kBa6EiInbTwZFY2v10D6vvRnRrFbpkIz0WSxm01BlJnMbD
         LqMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779589200; x=1780194000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHQ3iAVdgRbGDQ5MY/Sudz6ovqWFvWub/1D9p3tFQO4=;
        b=gdlAnGtSRaGHS0hxSMEWZNkbu5mI8MZigf2b5sV86nIS1KVyjDUC/IxCcQHj/Tnohp
         wdEb/dXelZbHCe0S1cF2w0pDy+5Vz3u5eYpKYsOhf5wt3PEBBq/KsupIG5GrndniLE3s
         0aUyZYoiqycLiEn/pkc/QeCwgmgdrP9ewFGo7pcHcGQgfCRgzehORHhR/UiNhlkG9bwV
         QPCwFUcbqvIdSksT/FMweVW/4omOeLmy6eTreprDlcblmcI/3riM7v2f4UxXhZGBwVFT
         tlCiElNoZYm3wuojviHOfzi7y/Ba9IFIm+rODHDj5g2m7gjRmV2ItX+rGUWBtn3nYZRy
         3DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779589200; x=1780194000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHQ3iAVdgRbGDQ5MY/Sudz6ovqWFvWub/1D9p3tFQO4=;
        b=bnP0RYTAHll+TpFZVDJZqu/xn40ahNljOPXaKomnSow925O6OURgQFjOiyCUTqCpsc
         jT1RsLa0qJk66dui9CfBHBsKr/z0kFdY7tikma9Pv+nHC3SBY29kY6274Dp2d6/OoRdB
         hU1Z9uebSmgk99fX+d9iJjIeo7ec+emqxvPAqt083DCZfDVRlvB1SxRPAxsMsVUOrYFP
         tHfSoT60SjXZnCuNjpT/aBnmTRzkGsikWTDObtbjQS0l/WSh9Gyn8peOthSDT0NGD+JY
         8e0+a/taXlMw2J7x2WZ/esplAY+ghcNrJcnQd2n1z4KOFF+zx3gnPoBrSYsnd665fTv0
         vKsw==
X-Gm-Message-State: AOJu0Yy3CLHK78zdM0MF82EFyZMJxfk3zvPqu/lbjeWImbChdTD6YgUy
	OLaOQaMIDOh35Un1FhX8I8qv4P8785ftZWXbt0jAUnx2fgfHFEYp0MBPNm7lL9zybcnzsKAlRA3
	NNzQiZDSzeZb51M6WD1xACp2Pm5rLQh1Z5A==
X-Gm-Gg: Acq92OHhHx5tiOt7aEYE0cKLYYULlMzzNX4pmdsUCFb6+E9PvA2rROQ8LjFTJBlEsOa
	P4fF0j6Yy941M5fQTgqENN6g2igUn3ZMa7Cp9IYDeIFPjGtQr3KxfPD/KAoJB2HPzjw8FLVnk0r
	5EQebAayVCxRtEpdfGfWVeDqNM+zU8DRCJ6UOyN++n90shOFailbHwaBnDf53GG+VJT55HIjwYH
	jpIL6JraDrzlOxzzUwrnWZ48TQKDmiN1mvtKqVIYSg2k0aEAow72sd8WFr6fTBIa1UxiDbOVfF6
	M3XpM26cKpqGV7dyPtWcfn9ab1Cpm4dFThe5hdOA4EVFqwQSjKd+A2rks/y1m5vrzaWLTn7o2Th
	TlSDHifE+Uu4snhmMq+2tXtDDwv6rIUNGK8QqQtNnwiaSDNOycsu+X7T7Yg==
X-Received: by 2002:a05:6402:458f:b0:687:261a:3388 with SMTP id
 4fb4d7f45d1cf-6889cc44682mr4923972a12.22.1779589199598; Sat, 23 May 2026
 19:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524015042.175271-2-rosenp@gmail.com> <20260524021121.7236F1F000E9@smtp.kernel.org>
In-Reply-To: <20260524021121.7236F1F000E9@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 23 May 2026 19:19:47 -0700
X-Gm-Features: AVHnY4Jxyl9vhzPHY1eM34oXn0Rk0ghXT-N_a1E7K7GW2FgWuQiMpkfBXewQW1k
Message-ID: <CAKxU2N_jsxv0Zre0FJUGFc=YRyB3Ww8bWxvgwYp0RFaM+Hn3mg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] watchdog: ath79_wdt: select OF and COMPILE_TEST
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 7:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The global pointer `wdt_base` is assigned during probe but is ne=
ver cleared on error paths or during driver removal, breaking deferred prob=
ing and driver rebinding.
> - [High] The driver fails to prevent concurrent access from open miscdevi=
ce file descriptors after the device is unbound, leading to a use-after-fre=
e or page fault.
> - [High] The watchdog hardware is not disabled during driver removal befo=
re its clock is disabled, potentially leading to uncontrolled system resets=
 or hardware locks.
I am getting fed up with this garbage.
> --
>
> commit 71b88482365f22ded9cd7ae662eb7b028ce262ea
> Author: Rosen Penev <rosenp@gmail.com>
>
> watchdog: ath79_wdt: select OF and COMPILE_TEST
>
> This commit makes the driver depend on OF in Kconfig, as it is inherently
> an OF driver. It also adds COMPILE_TEST support for all platforms instead
> of just ARM.
>
> > diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.=
c
> > index 7df703e9852a6..409a40b149015 100644
> > --- a/drivers/watchdog/ath79_wdt.c
> > +++ b/drivers/watchdog/ath79_wdt.c
>
> [ ... ]
>
> > @@ -295,13 +295,11 @@ static void ath79_wdt_shutdown(struct platform_de=
vice *pdev)
> >       ath79_wdt_disable();
> >  }
> >
> > -#ifdef CONFIG_OF
> >  static const struct of_device_id ath79_wdt_match[] =3D {
> >       { .compatible =3D "qca,ar7130-wdt" },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, ath79_wdt_match);
> > -#endif
>
> [Severity: High]
> This is a pre-existing issue, but does the driver properly clear the glob=
al
> wdt_base pointer on error paths and during removal?
>
> The wdt_base pointer is assigned during probe, but if a subsequent
> step like devm_clk_get_enabled() or misc_register() fails, wdt_base is
> never cleared.
>
> When the driver core later retries the probe, the initial check evaluates
> to true, causing the probe to indefinitely return -EBUSY:
>
> drivers/watchdog/ath79_wdt.c:ath79_wdt_probe() {
>     ...
>         if (wdt_base)
>                 return -EBUSY;
>
>         wdt_base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(wdt_base))
>                 return PTR_ERR(wdt_base);
>     ...
> }
>
> Similarly, ath79_wdt_remove() does not clear wdt_base when the device is
> unbound. Because devres automatically unmaps the memory, wdt_base is left
> as a dangling pointer, preventing future unbind/rebind operations.
>
> Should wdt_base be cleared on error paths and in the remove function?
>
> [Severity: High]
> This is a pre-existing issue, but does ath79_wdt_remove() prevent concurr=
ent
> access from open miscdevice file descriptors after the device is unbound?
>
> The driver uses devm_platform_ioremap_resource(), which automatically unm=
aps
> wdt_base when the device is removed. However, misc_deregister() does not
> revoke existing open file descriptors.
>
> If a user space application keeps /dev/watchdog open and calls write,
> ioctl, or close after the driver is unbound, functions like
> ath79_wdt_release() or ath79_wdt_write() will dereference the unmapped
> wdt_base pointer.
>
> [Severity: High]
> This is a pre-existing issue, but is the watchdog hardware safely disable=
d
> during removal?
>
> The watchdog hardware is not explicitly disabled before its clock is
> disabled. Because wdt_clk is acquired using devm_clk_get_enabled(), the
> device manager will automatically disable the clock immediately after the
> remove function completes.
>
> Disabling the clock while the watchdog timer is still running leaves the
> hardware in an active but unclocked state.
>
> drivers/watchdog/ath79_wdt.c:ath79_wdt_remove() {
>         misc_deregister(&ath79_wdt_miscdev);
> }
>
> Should the timer be stopped explicitly before the clock is disabled?
>
> > @@ -309,7 +307,7 @@ static struct platform_driver ath79_wdt_driver =3D =
{
> >       .shutdown       =3D ath79_wdt_shutdown,
> >       .driver         =3D {
> >               .name   =3D DRIVER_NAME,
> > -             .of_match_table =3D of_match_ptr(ath79_wdt_match),
> > +             .of_match_table =3D ath79_wdt_match,
> >       },
> >  };
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524015042.17=
5271-2-rosenp@gmail.com?part=3D1
