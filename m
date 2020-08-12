Return-Path: <SRS0=szdd=BW=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E6DC433DF
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 Aug 2020 19:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273D0206DA
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 Aug 2020 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597259830;
	bh=BzmzId5AAb4ksq7DLSeagK9Nqrd2DOKYmQjY4/krZS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=npqoQEhak0ncPcifDoPV1cI5a7KeLmGSttxmgl+r54BqkIs5ywl+7s23cGVGXidCr
	 Tl1L09MdWWjjZexL521vmJkvE1HCJJ8MQTCKCfq3rzTWEkLlaaHJvR4PclyFi2GMJn
	 S9/N4fHyEmxmhVXHVASYEBNZdfxWvGn9E4B++4nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHLTRJ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLTRI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Aug 2020 15:17:08 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F79C061383
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Aug 2020 12:17:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h19so3474949ljg.13
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Aug 2020 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSmnZhkgZc2K2B2dOvBAaXvDwu8XCKi+d6y2dc7rvlw=;
        b=ZItR4oeRihZpKcu5WsHEsPJMHZ65VZAGF8XJSrwDi/q4wF0ssjNFUgAW7rhUj9h03J
         TNGyzlqAs/1MEKevuEjvBi4OiTP1sulXlsSn9Th/B0LY7pvL0YYZfwYNHwhMn1VO9Nn2
         yj6I4btwtXU7yZ7LUsrDgOV+jE4KyBOSpnQWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSmnZhkgZc2K2B2dOvBAaXvDwu8XCKi+d6y2dc7rvlw=;
        b=o/L2pVK1znzJ3r//01CfOse2SByGekrAntOWd+PokDYL5QZpcBDRe9X37zaQJZur8i
         OtqwN1ebeHkbkRU72YrsN4Obq0tQcb6xyO3tyqT4vj+91Glm8cFbQIlfCs2Gifzexpas
         iEgoYXGHv3F1fOSdfnlDqeXnIc1330Np1QE9zSGvzLTsZ3Ew4l7VPsm4QGAtYwjkO0T/
         Th1e2uSBz7bsxRI+Z+vkEknS7dcWrtAHXzOhHsDS/ofOUgqux7ZyLDrJ/xVFIayTlwPb
         uZZXSxFhHuU31mci6Igi9T/8sttDYUD507b3OKtoh+u/OnXmRTx6EbdJKoxQRCtj2GPl
         CcyA==
X-Gm-Message-State: AOAM532aLN9+hfgL4tTSwiAEgPpGq/YOWu1ugdnI5e/23P35j7KK0O+6
        Vpr+C/QyIVRiuOWcz5LVe5u3hboT19E=
X-Google-Smtp-Source: ABdhPJzy5TqEkWuXXGegsisY6J4/fY/oujUiU6fCmoOuglXG9SZytEMzDcX0V8Hc7/yngsHLRs7X5A==
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr315393ljb.283.1597259825368;
        Wed, 12 Aug 2020 12:17:05 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q22sm665119lfc.33.2020.08.12.12.17.03
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 12:17:04 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t23so3521062ljc.3
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Aug 2020 12:17:03 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr309685lji.314.1597259823585;
 Wed, 12 Aug 2020 12:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200812113903.GA14481@www.linux-watchdog.org>
In-Reply-To: <20200812113903.GA14481@www.linux-watchdog.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 12:16:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCnTLcBWO57bedR2uKyGk3YK5rGQf8N70Lx6QTy2J17A@mail.gmail.com>
Message-ID: <CAHk-=wgCnTLcBWO57bedR2uKyGk3YK5rGQf8N70Lx6QTy2J17A@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v5.9 Merge window
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Bumsik Kim <kbumsik@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Krzysztof Sobota <krzysztof.sobota@nokia.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Martin Wu <wuyan@allwinnertech.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Tero Kristo <t-kristo@ti.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Timothy Myers <timothy.myers@adtran.com>,
        Wang Qing <wangqing@vivo.com>, Woody Lin <woodylin@google.com>,
        Xu Wang <vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, Aug 12, 2020 at 5:38 AM Wim Van Sebroeck <wim@linux-watchdog.org> wrote:
>
> Please pull the watchdog changes for the v5.2 release cycle.

Spot the cut-and-paste from an old email.. I went back and see that
the same thing happened in 5.7 pull request too..

Pulled,

               Linus
