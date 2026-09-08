Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881332F3621
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870201; cv=pass; b=Wnt9jviWvDl92L11Nesb9hDApRIPEnzKZARxVRPGdGvXHrbTSgH6BQNiLZ7dzWg/HCea46RMGnrHlsaV0+DqcLPOpwLMmYUHPUcyosAvZ9UqJB0eXYHWDXlgxWf17C5gX3ssWfAH/mTEQepWW4Sg6mVgp1bamzxR54gohi92umQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870201; c=relaxed/simple;
	bh=7B//ywSPA31oLbLkiJWEnOV8UhYI9nR5ExoskFX6af8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/a/Z5Vob8unrsZPYgB+JpAKVoCjPMdqjHUKZxERIggvRtVPHXRHaptNBlOZIphrBAL/M6yaHBUmbcisYpnawadiFOTHfRcC//r7XFYjolCUyZ6M9bW1RDb+qC0EvL1oVyPzWg+BxWtlatu349FQ1vN6Q+sTdMR9GVdZY+HoLpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogDTH1SL; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogDTH1SL"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso6099421a12.0
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 05:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788870198; cv=none;
        d=google.com; s=arc-20260327;
        b=tBURAWYw+t2CTocG+Qa3izHZq3eXN0qC8uii56bTvY4zXZdwg0pXlOkUVBjyxtqkod
         3R6KE2oKGLQ6spRnFG0EEK4qBG1wnzRppOLtKZ6FT/6Q+qGxH9kfap/4fyI4J+7prdc/
         0WfL1Ob9Bui944dbKepQQx+HCzEYnkzq3iL4aSxhZx1DRGsqfWK154Z9PuVLSKkjzpva
         Bb0TR1uvgCQ92i1FThEEOjoyzwfFjYWvEH0t8c8W3DFuhH/DM5zZjUUcMuFVanCLvkOa
         HyePllyF8aDaeJNLckbSKf3sDPqsS+OsQuaZkpfjhxlppi3qmbK0bu59QjrEXvC6N5Uw
         qX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kMTwhNu5pCcwPamJHqUSc+QqQ3bw/cfakmLflS8d1lI=;
        fh=CDkpK01tEPZ5PdBcCgDRPjqaCTOKtqReiC00aRVoPM8=;
        b=mHymK8qTlA4+X1ZIHcl5Ou2K4BgnclYiTyg9nA59LL3LPwwf24I7bd+z9yXTHGL7LA
         EKZvp6hPV1emJZhrX0QeFzlzA4ox2WnfJw7GxAMgMP4M/YdRD4Ie2GTogwwYf++VhaoA
         dccT9Fg2uokyMoay7LFasYOXUNJSbSlp9GMlZ+M17oYlCIsTmXFIqeJo7FvOlxMphKFc
         l1fJJ7Lme1+cGopq6odkFhl5QmZaoQMNsA3mrtodXdeDxgFmspQ/XMYSvc7kQIsg9G6B
         MvSSnq/OnjykPoJcAODqnVU8zrOTFHVSfDnNxEXMQAqDhY5XEJVm43qYmz1bjwd4W8z6
         5tEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788870198; x=1789474998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kMTwhNu5pCcwPamJHqUSc+QqQ3bw/cfakmLflS8d1lI=;
        b=ogDTH1SL6iVEEOIo4qftnZzx4EQi2xxugvnXaQgSUZdsg7hmOV9wiEJp4LYfEt/imJ
         tUGnVQXQszfH0uV7Ir1SpExPFcD46LOVLyhubRGso172+06R4EerD2rHELgTXwLwayhX
         xeAuCAAT6J3VW1EAIVOBXe3tUjEroH4fAHyEbSGuptSmNa4dDHnJXV3ReM+6LzJrWibx
         1ltdpW9BPhHZRqOH7gIBbPwAdFwk139SOf2PQGG5kttkGl3DjzpC3LcswvuQW8V0uTLZ
         ZF94UfqEaUVpwF7bmV344HPxZLR1gj+zG9avQm2h0qNSPKvyKN07tCpdES74tSPnwlUz
         1mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788870198; x=1789474998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMTwhNu5pCcwPamJHqUSc+QqQ3bw/cfakmLflS8d1lI=;
        b=PO+iAuA3H3fHpWyb7oXgjzh3JpYGbxFKTdyB9wJLVGpIlNd9Su8/xUFUS5wVHNZLss
         xXQZbrksSRqSgek//s+ZCjH2PfnGXbeieMFQBBcFdlhzzFgBlzRzvQ3Vk01NLrK2zOQ0
         Di2Wwanqstot9x1u47f+pUDp3jDzx/GbM8sOGwl+zn9wV+ugiiuVtzY7sh/eWjx1G1Y1
         CajajDXuC987sOY+pYKWZ4RbBnvPNxJgr38g1egW7xG45o8zRJcy28y3cGvbfE53sDLN
         QPgfoshUipPB4IV2C2GM/PFZSNUooJpBxyJx0s1RD5o3ZwjY5Kns5m8fzKWbCuLDQrxN
         JESg==
X-Forwarded-Encrypted: i=1; AKwUvBwAqrLLcqnZW6JRaNK9eDS3F5lrwgIxMhkH8wbTncLw3pnqkdlgIX+asi/+UN9Ds7fhgNDzZ/QBoKmFqOzddw==@vger.kernel.org
X-Gm-Message-State: AFuF++mz3wJvz54pFILnvcuLfRdwFybpTLoIP1qnIDWJhnCDiqbDV/tZ
	ByHZkoOJKcbLcBrev8aDnXHaqPowFatRXrjS+N9eFczXrxe/3fOPdwHgtDjSw5cwvGvexQ4B80V
	wGA753GKS+MbF4tyYTYL/WxTHUzU+KtPdfXoOQe8=
X-Gm-Gg: AYBFou30KUGYqbU4xdftyzEP1YXRoWc53vsFwUUmgYBT2ySDLF85xBtOmbAvb9qn+X3
	ByPMwnnGor+uPr4DOfebjVx1lbV8owt4mJ0BXsQfrnqcOeGJf7EQx6XTFl/2xNL4OL0z8d7D2nk
	APs0BSE98vMdE+qL2GjFkwT6sU+4zbF9TDidwfEiCHTxMFDjr3K3kLYE8rDq07m79640v7MR7m7
	tXR6bUJOr+v+qoBhN2NUBwp7tJ4MogT6JgHO0cH8Uw2OW0s6GnUCitkCEt/mjH6H69Fp95ozMWB
	DSTKJdTX082CbuxcUoInbbRwqTruRIdu07LBjQy5CFS6TaM+XiHBc1o9bnuHTQXoamhjxlZXHku
	0jGWKpsb0f09VcW0INIK8G8lPNF1e+Q==
X-Received: by 2002:a05:6402:3814:b0:6a3:87b7:b516 with SMTP id
 4fb4d7f45d1cf-6a7e8d67669mr9906512a12.6.1788870197348; Tue, 08 Sep 2026
 05:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260814191415.2110732-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260814192638.EA99A1F000E9@smtp.kernel.org>
In-Reply-To: <20260814192638.EA99A1F000E9@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 8 Sep 2026 13:22:48 +0100
X-Gm-Features: AcwNN1Wx4etsK429Q3Q8c3-LvEEz0E7ckOfxtJenny8EdfSwTa4Tjef1JG7X6dI
Message-ID: <CA+V-a8u4_gziwgevLUWwPkhkm2TbQXJhwFMa9ug8MAss+aZcug@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] watchdog: rzv2h_wdt: Propagate WDTDCR access errors
To: sashiko-reviews@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>
Cc: wsa+renesas@sang-engineering.com, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sashiko,

On Fri, Aug 14, 2026 at 8:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Error path unwinding in `rzv2h_wdt_stop()` leaves the watchdog h=
ardware unconfigured, causing an unintended immediate system reboot.
> - [High] Aborting the `restart` handler upon register access failure prev=
ents system reboot and hangs the system.
> - [Medium] Using asynchronous `pm_runtime_put()` on the probe error path =
leaves the device permanently powered on.
> --
>
> --- Patch [1]: [PATCH v3 1/3] watchdog: rzv2h_wdt: Propagate WDTDCR acces=
s errors ---
> commit ffabc27a1b8e9074dcd4cdaba7bc802a6d661fcc
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> watchdog: rzv2h_wdt: Propagate WDTDCR access errors
>
> The WDTDCR helpers currently access the register directly using readl()/w=
ritel()
> and therefore cannot report failures to their callers. Make the helpers r=
eturn
> an error so their callers can propagate failures.
>
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index 3b6abb66a1da0..b770226f785ea 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
>
> [ ... ]
>
> > @@ -171,8 +181,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *=
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
> If rzt2h_wdt_wdtdcr_count_stop() fails, this unwinding leaves the hardwar=
e
> out of reset but unconfigured.
>
> If the stop operation returns an error, the watchdog core assumes the
> hardware is still running and immediately issues a fallback ping. Will th=
is
> ping against zeroed, unconfigured registers start a zero-length timeout a=
nd
> cause an unintended immediate system reboot?
>
Agreed, I will drop deasserting the reset and add a pr_warn() message.

> [ ... ]
>
> > @@ -234,8 +250,19 @@ static int rzv2h_wdt_restart(struct watchdog_devic=
e *wdev,
> >       rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
> >                       WDTCR_RPES_75 | WDTCR_TOPS_1024);
> >
> > -     if (priv->of_data->wdtdcr)
> > -             rzt2h_wdt_wdtdcr_count_start(priv);
> > +     if (priv->of_data->wdtdcr) {
> > +             ret =3D rzt2h_wdt_wdtdcr_count_start(priv);
> > +             if (ret) {
> > +                     if (!active) {
> > +                             reset_control_assert(priv->rstc);
> > +                             clk_disable(priv->oscclk);
> > +                             clk_disable(priv->pclk);
> > +                     } else {
> > +                             reset_control_reset(priv->rstc);
> > +                     }
> > +                     return ret;
> > +             }
> > +     }
> >
> >       rzv2h_wdt_ping(wdev);
>
> [Severity: High]
> Does returning an error here prevent the system from resetting?
>
> The watchdog core's restart notifier wrapper translates an error return i=
nto
> NOTIFY_BAD. Since NOTIFY_BAD includes the NOTIFY_STOP_MASK bit, this abor=
ts
> the restart notifier chain entirely, skipping any fallback handlers and
> causing the system to hang indefinitely.
>
> Should this restart handler make a best-effort attempt (perhaps ignoring =
the
> WDTDCR start failure) instead of returning an error?
>
Since the register writes aren't succeeding, it implies a serious
failure with no recovery path, so returning an error makes sense.

> [ ... ]
>
> > @@ -266,11 +293,11 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_=
device *pdev,
> >       if (ret)
> >               return ret;
> >
> > -     rzt2h_wdt_wdtdcr_count_stop(priv);
> > +     ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> >
> >       pm_runtime_put(&pdev->dev);
> >
> > -     return 0;
> > +     return ret;
> >  }
>
> [Severity: Medium]
> When rzt2h_wdt_wdtdcr_count_stop() fails, this returns an error that fail=
s
> the probe function.
>
> Does using the asynchronous pm_runtime_put() here leave the device powere=
d
> on?
>
> Since probe failed, devres immediately calls pm_runtime_disable(), which
> cancels any pending asynchronous power-management work. Should this be
> pm_runtime_put_sync() instead, to ensure the device powers down before th=
e
> disable occurs?
>
I'll create a patch for this.

Cheers,
Prabhakar



> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814191415.21=
10732-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
