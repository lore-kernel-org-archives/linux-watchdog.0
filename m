Return-Path: <SRS0=XVXx=6T=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B05C47254
	for <linux-watchdog@archiver.kernel.org>; Tue,  5 May 2020 20:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D1E20746
	for <linux-watchdog@archiver.kernel.org>; Tue,  5 May 2020 20:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA6vy10k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgEEUYw (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 5 May 2020 16:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728756AbgEEUYw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 5 May 2020 16:24:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3BC061A0F;
        Tue,  5 May 2020 13:24:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e6so102339pjt.4;
        Tue, 05 May 2020 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0hcvNEpyBwETLQfwOmA11LRFJ1Gf9gAoHtWTSqAFDY=;
        b=SA6vy10ky0hIwXPAunQedL6O6pebTUbSADKJz4tdIqr9r+DDyz+JF57nBnqKwXy7af
         Mu6oUfHhGo9F3plVTvmZf3+ZTizo+JG1A1iYr9Q8sGCdKpYR9FKYs7Ku3h06hmZyKhjy
         ZrXh9RANSqtDC/nmVS3ekUsqpabAtQ2WWFPWxXwTQOAuY+eWRKhu3xpXULMzx89Db0l1
         +9Z/dafL9nKsZ7LS3Ea9IaJBxK9nPlVJZmheCAi0iLLigWwrTjkBk3N0Dgj0A5ZW0mri
         WTkASn+60yLGJkHZjvOkbinTh9hT01ScKYmgyWCDirEoKuQzFK6hrjwDpFkqCsqw2YaJ
         7HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0hcvNEpyBwETLQfwOmA11LRFJ1Gf9gAoHtWTSqAFDY=;
        b=SfpNeW51x117p47tyh20DKKAntCRglAbn9oOKnHYGaWUjxjXOgTTBohcqkwugUbiwD
         tGZa8Bw6joSvQGmrLsz/XyMhV2Xy/ZxNMtG5SFPOiUI+ql+PffclbIMU7nM4McjHh6Lk
         3ppqbNnMBequMOlx+GR6q05uOaTPxo57emYsldYaAToXNHKE3TTWK6I59Vh9/1hBeLQn
         YazLZGqtisTZOFwiusRhEY0UQ7Kg6Fn6TxVI11NIRGYQ+qrnu2Qvjk4B1gbiEhU5T41j
         dZoXJLMBOmk2AlXb28yrf/FJj/q3xj8MNhE28T9jE165+RkUmBO6Q2Mgshk1sglyPQL0
         lw3g==
X-Gm-Message-State: AGi0Pua52v/24mDmhG5Pm4AnaM2+5J3lAQBvmgJIV3a1jGTIDALKmfpU
        ClyUQjgPI1zxVO8wZhV8/xruKZg16273jRhcogMJPHqlTRU=
X-Google-Smtp-Source: APiQypIUObSHpLM1QF1N7ctcLpcIUl+mAAWc7Ozppi3UP7FlQnFzIDTkdhZl6a/Ivam5/+qSu8Ez5PoBg0cT/ep3mlo=
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr4499928plk.255.1588710290266;
 Tue, 05 May 2020 13:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200504141427.17685-1-michaelsh@mellanox.com>
 <ac2c580c-7cc0-8091-f3bc-fce175478e50@roeck-us.net> <CAHp75VdN6PfCCmRB_FssTRCoXms7JTt_af59pMqZNgV4ygz_8w@mail.gmail.com>
 <AM6PR05MB50649F646F8A7870160D1973A2A70@AM6PR05MB5064.eurprd05.prod.outlook.com>
In-Reply-To: <AM6PR05MB50649F646F8A7870160D1973A2A70@AM6PR05MB5064.eurprd05.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 23:24:43 +0300
Message-ID: <CAHp75VdnrUCiK-C9onZOQ0xV=a-ZrPRz-Xmg-euhCRp86tsM2Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] support watchdog with longer timeout period
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Michael Shych <michaelsh@mellanox.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Tue, May 5, 2020 at 9:39 PM Vadim Pasternak <vadimp@mellanox.com> wrote:

> > > Guess the big question is now which branch to use to take this series.
> > > Thoughts, anyone ?
> >
> > count(watchdog) = 8
> > count(platform) = 6
> >
> > Thoughts?
>
> Hi Andy,
>
> We have some more patches we are going to send for platform
> drivers.
> Maybe it's better to take it to platform branch to make further
> merging easier?

It doesn't really matter. Cross subsystem pushes imply immutable branches.


-- 
With Best Regards,
Andy Shevchenko
