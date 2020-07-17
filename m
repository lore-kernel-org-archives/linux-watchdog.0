Return-Path: <SRS0=YsN9=A4=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E22C433E4
	for <linux-watchdog@archiver.kernel.org>; Fri, 17 Jul 2020 12:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F92C206BE
	for <linux-watchdog@archiver.kernel.org>; Fri, 17 Jul 2020 12:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJYz7qER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGQMPl (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgGQMPk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Jul 2020 08:15:40 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C214C061755;
        Fri, 17 Jul 2020 05:15:40 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 18so6702176otv.6;
        Fri, 17 Jul 2020 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UfQe2BS0rIAs9l2X3cUyxdouGiITDgXDuTDmJG9ZnE=;
        b=CJYz7qERO+JrQ0074hqAOABKlW/D2IIPxmJcllektshBQP8F8eEHQBg4tQB/0RFKuv
         XuUlUeXLnPPv5pembGO6vnE96T4oBEfjwWDNPvQw5Ewl0cqz3ycn4QazA97sMDCqC/Lu
         KUTP9f/rFZ/+pHAPqBn8grpL0C1zeUfu8jag6d7ptBekS2QFn1eDSPe9WDO8EXH6gcQj
         va7n3gmiG70aIEq08L/65XlxLn0QIvHLJGg7enudp+JLfw+SHduQ9h2ETf4UDqTm9IxQ
         bUQnD47awsgUHJMQ7BeQTtZS8WUjzYA98xQbeKtgQ1LTKY0ulZ1arXEzQveoUlCIISyS
         HwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UfQe2BS0rIAs9l2X3cUyxdouGiITDgXDuTDmJG9ZnE=;
        b=QNTZntyjat22m6sAyygDPmBRR9N6xnahWSiBmBqrNbAtvTd1Ccs3BfKaIEw4vQl5h9
         Kb48BUoZmJNVzkxHLb1ljCLGsSy/P3yDieIrA3tcKG8u0q6w7nUlAf1zimD7vR8Tj5Sh
         S/WggbS0f+WUIg6d7kTIHCbK9Dr9D0/E0W7rXo/ar+lF0JTkOTV0JReOQ7eH2KJXohmE
         Qvu/fQFSKZXTBzdlXbWDAYgTeglW2j42ErGm0efjCPoxsVkIybxoY0L0WB46JTX36GcE
         SukBvdLaovbGsxeQaYnajsj2Mam9pYvD5VhkpfBdiQ7GzIZ7QCMlyXL8/UFA5S0IqvIT
         AW2A==
X-Gm-Message-State: AOAM532zU3Iaw1t2UX71ZZ/0aP8mn/UFSbQTQPXoqPA5EIPvq2hvWSuU
        x91zA65XSypV+2hydei0XwrjyEhVkS608Mti22Y=
X-Google-Smtp-Source: ABdhPJwwDc9s3SXJ2tuMf8tpG8vE++CAe1cFwcMZhsF8v3bJtrQWUbNQCzp8Ew3dfGqS//29NtZDQQ/O1FD5Iv/AozY=
X-Received: by 2002:a9d:7dd3:: with SMTP id k19mr7944070otn.43.1594988139858;
 Fri, 17 Jul 2020 05:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594811350-14066-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200717115915.GD4316@sirena.org.uk>
In-Reply-To: <20200717115915.GD4316@sirena.org.uk>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 17 Jul 2020 13:15:13 +0100
Message-ID: <CA+V-a8sxtan=8NCpEryT9NzOqkPRyQBa-ozYNHvi8goaOJQ24w@mail.gmail.com>
Subject: Re: [PATCH 14/20] dt-bindings: spi: renesas,sh-msiof: Add r8a774e1 support
To:     Mark Brown <broonie@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Niklas <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Magnus Damm <magnus.damm@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi Mark,

On Fri, Jul 17, 2020 at 12:59 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jul 15, 2020 at 12:09:04PM +0100, Lad Prabhakar wrote:
> > Document RZ/G2H (R8A774E1) SoC bindings.
>
> Please in future could you split things like this up into per subsystem
> serieses?  That's a more normal approach and avoids the huge threads and
> CC lists.

Sorry for doing this, In future I shall keep that in mind. (Wanted to
get in most patches for RZ/G2H in V5.9 window)

Cheers,
--Prabhakar
