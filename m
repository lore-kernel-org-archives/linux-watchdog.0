Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6F37BE8B
	for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140336; cv=pass; b=Ml1nT2RRqfmQLPZp83cZ2fpsK5rxi2+2EVsoJ+EViKiv7YB9SU4hriCZRM+xxOyQkDi5b+49h/cNMZW76kjjeZuyHczBuDWhkLYqiz5vcQsrJccPzhjuO4Llplfv7LBMvnFzIVqzPFoxshiQw4FPbG+l/hKtqU4oXhCZWtBclFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140336; c=relaxed/simple;
	bh=pNW/aYejClTHOe/GUM7OBh5zmikOgfplrUaLnAuzvrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCTQ2LYecEicDf1fpOH2B0D83sdphXEM83pHz3QlFZJLwj5cpDrv9s0NujAmUnZo1m5PE01e+UEmK8/mN3SzVcFVzeXvPoir9OGbeZrEgtn6fgE6thoBxTdeWypa1qVdwH5lH4Hn+xYT/LyuWCCPAcoQsKJ9htDblOFDK/knmRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0lP8yRR; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0lP8yRR"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so3206765e87.2
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 14:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779140333; cv=none;
        d=google.com; s=arc-20240605;
        b=EyWj2POYf1UtVRItc7E6uK3zueGts2nTdpFMZDFpZtMNKdNO+Q8nAYToGGh1Q1ivxT
         HL5kuD7jZ4mcihQS42UCqyxVs2rCYayQlOX18RAQauR/tjKddqncpgA8qaSlIhRD0U2A
         NcwG5SmbWsQdfULkbzewiXPlzUeqSIHOybAHjnIz8V7IW3qAk2JRaGcPQrkZWtwVxBL+
         H1KnufPSAW/SbwgPGctKn/qqXVRvYNdMNV7pBpSPUat/Dd6b0BQYX3Lwqb0iQ7YkiJl8
         4p1rLNJuf6Yhhj39HDA5FZYFlXMdjzZRuo7wADBGSUiO2lAW2EYDLeuWI97rbhRqc4jP
         Q93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=euGMTDy6+FwGD5XxUGxxeqRVdpXKKopqQh8ghrZGdtc=;
        fh=zt2hjtFWVrBSbexOnXx/digRN2O0tNSOK4/ceCsrIlE=;
        b=hp6WosDnA0OW0YB2WKMVcQI1aMl/hUm9vO2/f4zV/Wj5K4NuQf+xzKQEFEPxJQXBnp
         9BrM55QW5YDZktoQnsuHzFHC9uZBS6trrGZFW/kVXao8SZH3RmaDkNKFrawZvZiDRzHS
         K8NQ956EasukPaZI7wF7U+DmluKUVrI4S867ZHupVaWMT7TLny7dmgCO3EnUx20qMkRP
         JJWukDXXtIzMXSuJT/5thpI6GbJQsCbhhhTXsdsu7wa3NskqPGXcWuW54+c2YfqlTXhm
         M89nZOB4RAgEJWBCepDy970t9UTcQJTWz0Rs7wZiRtBQsAri/6DkC/JlilDmn//76TdH
         HRDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779140333; x=1779745133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euGMTDy6+FwGD5XxUGxxeqRVdpXKKopqQh8ghrZGdtc=;
        b=r0lP8yRRi3bMCZCzR3M8toGzRjAaHSBORRh1CIyfKQIxyPLK7owzVEvHdBL5JRqqVk
         o9MPM+k4g3jG+yVRbAxq7D+EhZK/j4ByMPFiF5hhA0hsJ4pDZUbcLgjjfCBEpkFRs4Lo
         UU1X77Kzx9RSPbWk1FfNOVkZlQKhdtrdiBROpFceSCHonJc24FZ8hS72Xb4lKRjfChQQ
         lBhM48dr6AWDO2W+EBsQuq659RvLtZktZJrRqB4+KJwqAgcmXKR18H1TWg6OiCPXBWha
         5iLKzATQ1Ww4tdwU4vWxJAV0+hoI1mmEyrf6Fxb5MtG8olchTNA0UWfwCTFfL7C/ntcS
         DbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779140333; x=1779745133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=euGMTDy6+FwGD5XxUGxxeqRVdpXKKopqQh8ghrZGdtc=;
        b=hwr0Eq2+okJQAb2xnQTDoJS4d/l4Dm7G3BfKWLJQNO214L7gDfZ6HiP5H7HYaeicZI
         SZyf1cZ1p6QOO9heWUX771kcvE974TJLi66GzZbEFN152XViUTwFCw9gFOC8bfdEq9Zr
         g0yOewtzoCzaO/ylbiuSJDlVT9BY6xHXWYaO8eBstWGbCZnv1CugKqpitoBWQj68GNth
         2vYmph4QE3mvXKu2lzq2OaIWkvcCb9Ut5mScQyhpa5IwfulSfMjmhX3CjMnzCmMMXuDY
         ap2g6QdPRO50W2YAiYy9DVljCUw2reSzhgXGAqZD8ux1J7C0cZxH538VEbwchsKuhWl2
         QFEQ==
X-Gm-Message-State: AOJu0YwCmMQvC7DjM1ieu6cjQg/2Ij6qN+04IXSqGHHRE1Cx88Q9cjq5
	WynnBtZmX9fcYDs6WE5kZlhLTgZhfVTbia505/zLarRyq6mga5WQHokSwk6M/xTaIbZb63LqQUe
	3nz8TMSiiW5iI9UWOoIaT3Y/hyMtt5St9ynlksLs=
X-Gm-Gg: Acq92OFuK23SNUdtzFbh/I9HELhcqRhPuuegebk2QAYIS3dLuyq1pdEqAw8MXk3SRzO
	Ndy+JSagzML3KOsoXCFjt7j/CW2PgQ4NLj3x6uDiLYkEZHUAxM5jzOWaamD/33zK1Sz+wZvOrps
	1Qcz177gzJVgH8E3KMw2x+iCCfIgXWTeluVvgWH6OCafniPxdIAZ/tl+KFNG8gF8TPeOjV2HkHy
	2bqpBBu7ARkG1tMJGMr3pFF0Ty2TuBQnoUaOLYoEzlaJzwBa5nvBf5zjOcTmRfSKOr6tcs5PYIW
	A+KduKOdovp59h06u9/bmQ5CZg5nGjywhB/6++F9NmG/3lJNvQims/TdGCdc7gYtT2Nkq1BtFhH
	N1IidYzidpEg+SWXvOLbuK/i+GQhZP0kLgthYOL65st48Sj7jYe8/1Wb66w==
X-Received: by 2002:a05:6512:159f:b0:5a8:891f:388 with SMTP id
 2adb3069b0e04-5aa0e73e985mr4841694e87.29.1779140332773; Mon, 18 May 2026
 14:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518210957.10545-1-rosenp@gmail.com> <20260518211925.A24FDC2BCB7@smtp.kernel.org>
In-Reply-To: <20260518211925.A24FDC2BCB7@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 18 May 2026 14:38:40 -0700
X-Gm-Features: AVHnY4JxHyvIhyT3-GXyQNQ7qtL3R-Vt6nEkpFJolQTPixllWzj9q7mU0PPN1UU
Message-ID: <CAKxU2N_ErLkFgvpCCexcvaGbzozdSV4y5w3ER+DaEgFLC-hPsw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: ath79_wdt: select OF and COMPILE_TEST
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Permanent failure of deferred probing and device re-binding due =
to uncleared global `wdt_base` pointer on error paths.
> - [Medium] Mismatch between Kconfig changes and commit message regarding =
OF dependency.
> --
>
> commit 279311df3b831cb8a967974beeea1a51baecd0ac
> Author: Rosen Penev <rosenp@gmail.com>
>
> watchdog: ath79_wdt: select OF and COMPILE_TEST
>
> This has always been an OF driver. Select OF in Kconfig.
>
> Add COMPILE_TEST for all platforms, not just ARM.
>
> > watchdog: ath79_wdt: select OF and COMPILE_TEST
> >
> > This has always been an OF driver. Select OF in Kconfig.
>
> There is a discrepancy between the commit message and the implemented cod=
e.
> The commit message states it will "select OF", but the patch implements
> "depends on OF". Could the commit message be updated to match the
> implementation?
Yeah probably.
>
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index dc78729ba2a5d..1590f82941ba8 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1811,7 +1811,8 @@ config M54xx_WATCHDOG
> >
> >  config ATH79_WDT
> >       tristate "Atheros AR71XX/AR724X/AR913X hardware watchdog"
> > -     depends on ATH79 || (ARM && COMPILE_TEST)
> > +     depends on ATH79 || COMPILE_TEST
> > +     depends on OF
>
> [ ... ]
>
> While reviewing this patch, I noticed an existing issue in the probe
> function's error handling. The driver uses a global pointer to enforce a
> singleton instance:
Yes, this is an ancient driver that needs to be migrated to
watchdog_device. This is not relevant to COMPILE_TEST though.
>
> drivers/watchdog/ath79_wdt.c:ath79_wdt_probe() {
>     ...
>         if (wdt_base)
>                 return -EBUSY;
>
>         wdt_base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(wdt_base))
>                 return PTR_ERR(wdt_base);
>
>         wdt_clk =3D devm_clk_get_enabled(&pdev->dev, "wdt");
>         if (IS_ERR(wdt_clk))
>                 return PTR_ERR(wdt_clk);
>     ...
> }
>
> If devm_platform_ioremap_resource() returns an error pointer, or if a
> later step like devm_clk_get_enabled() returns -EPROBE_DEFER, the global
> wdt_base pointer is never cleared.
>
> Does this permanently break deferred probing and device re-binding? On a
> second probe attempt, the uncleared wdt_base pointer would still evaluate
> to true, causing the probe to immediately fail with -EBUSY.
>
> Similarly, since ath79_wdt_remove() does not clear wdt_base, will unloadi=
ng
> and reloading the driver also fail?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518210957.10=
545-1-rosenp@gmail.com?part=3D1
