Return-Path: <SRS0=PbrJ=CU=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA729C433E2
	for <linux-watchdog@archiver.kernel.org>; Fri, 11 Sep 2020 03:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F24B221E5
	for <linux-watchdog@archiver.kernel.org>; Fri, 11 Sep 2020 03:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T8vrlsUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgIKD0e (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKD0b (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 10 Sep 2020 23:26:31 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FDDC061573
        for <linux-watchdog@vger.kernel.org>; Thu, 10 Sep 2020 20:26:30 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id u48so2684425uau.0
        for <linux-watchdog@vger.kernel.org>; Thu, 10 Sep 2020 20:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvQeieKv5rbJ5/s4eJT2O+IOF1Saic+Crp4J5iKZQf4=;
        b=T8vrlsUAjemV8EhbZG0kArfreNIjgn3IeAZ9umv25OXXKgdAG3mJcTUQXK+AvrXY13
         BAI+4GjON0vIeGj0QPlOIe/Qlb74NnKfR2ocY5plpnUUgw7BwrDWNJRggjmMvQbn3T8Q
         aXC3dFk102DstFA3OZdzhxqeyaAstAE0NfHaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvQeieKv5rbJ5/s4eJT2O+IOF1Saic+Crp4J5iKZQf4=;
        b=Qf7ax2c1ERpn5zriULpT3/KbsXObG8HeIaG8Wa/bVy+hJLOpgaSKJNwWTWnVeQ7vEw
         VmmEh3dBD4B6GqQCrc9HVNIT1N5+Fgp9jMI6KxxFwe5/VCj0aXiqP5fAQoo9DwrWbCSy
         0KgxACOIVjQ/lYyWbfWxIcF3nvatbR/Qyz7zFEnrTejeXYDMdeqWeVAyZacUlOe8f/DD
         OgAOE9Yy3OcRUvo/yJZuNuYPfa7PDYdYeM5lRW55Zskb9smRhWOwXTbljqcCZsljVaRY
         ET5+W1sJ5mq7mBzY4rqkEEfgTxt0mJf85TFJmgVkF28xykwnq5cXulX/ZUZpizKRvnca
         NpLA==
X-Gm-Message-State: AOAM5308Gc9k6cXlIvBGXdch2dAOtCGrTus5KzVObLg+zL6gvZ8s47Wj
        9ExEdnN0jg3n8ATWPxF5ReXmNEVAzUUSwSovywHtVw==
X-Google-Smtp-Source: ABdhPJwxVrNhrniN5woxKGWcan1oHwHrjdiscQz8zYmgZM3N/r1SrH7wmqgMzlo7PmXudZk/YFVEzcQkn29JMBnylaw=
X-Received: by 2002:ab0:1450:: with SMTP id c16mr523uae.27.1599794789775; Thu,
 10 Sep 2020 20:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200803071501.30634-1-crystal.guo@mediatek.com>
In-Reply-To: <20200803071501.30634-1-crystal.guo@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 11 Sep 2020 11:26:20 +0800
Message-ID: <CANMq1KA=t8srKfC4XUqk2V2N6Jm0=-P4rQSh9Mqbo2tFFKgTEA@mail.gmail.com>
Subject: Re: [v4,0/5] watchdog: mt8192: add wdt support
To:     Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, seiya.wang@mediatek.com,
        Crystal Guo <crystal.guo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Matthias, Guenter,

These patches have all been reviewed (apart from fairly trivial 2/5),
which maintainer should be picking those up?

Thanks!

On Mon, Aug 3, 2020 at 3:15 PM Crystal Guo <crystal.guo@mediatek.com> wrote:
>
> v4 changes:
> revise commit messages.
>
> v3 changes:
> https://patchwork.kernel.org/patch/11692731/
> https://patchwork.kernel.org/patch/11692767/
> https://patchwork.kernel.org/patch/11692729/
> https://patchwork.kernel.org/patch/11692771/
> https://patchwork.kernel.org/patch/11692733/
>
> Crystal Guo (5):
>   dt-binding: mediatek: watchdog: fix the description of compatible
>   arm64: dts: mt8183: update watchdog device node
>   dt-binding: mediatek: mt8192: update mtk-wdt document
>   dt-binding: mt8192: add toprgu reset-controller head file
>   watchdog: mt8192: add wdt support
>
>  .../devicetree/bindings/watchdog/mtk-wdt.txt  |  5 ++--
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  3 +-
>  drivers/watchdog/mtk_wdt.c                    |  6 ++++
>  .../reset-controller/mt8192-resets.h          | 30 +++++++++++++++++++
>  4 files changed, 40 insertions(+), 4 deletions(-)
>  create mode 100644 include/dt-bindings/reset-controller/mt8192-resets.h
>
>
