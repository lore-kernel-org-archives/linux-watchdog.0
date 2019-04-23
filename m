Return-Path: <SRS0=xPok=SZ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9001CC10F03
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 21:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A4F218DA
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 21:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRBXfJdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfDWV33 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:29:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41427 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWV32 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 Apr 2019 17:29:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so2313073lja.8
        for <linux-watchdog@vger.kernel.org>; Tue, 23 Apr 2019 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjNWOsrikAOM/wqkHxpWheOZnguCN9PHZCzFhN8cUoo=;
        b=xRBXfJdyg1R7nAx9RGWoiFoMOHzy5S7Nq21XHYTusFlAjrWeUhUmn4Xl9/3DYsFWKk
         RMcvmS9QgeoYusqaId8AaHQr/RYSybV5hwpcvNBYrhTS7oTRWc1e0mgd/hiKeQA+OR13
         79mDeXcsySw+db0gZcYmAh+VdhDd9MANUI3IQSWIgD4Xj1WhjcVXdIiT8D1yVGfljt4L
         BQvRNy0diMu+6f/bEv/2T3crR6gUjfVp6fvEiuZAcVS9bGNt3jiKrgRx7Z2YEtH+775N
         Jbexga2z3IDJsvH5pvVOfRnR0QSdOfSuNgeKHceYnUCeVrbzdsykRX2+w13Hwsnqsc/V
         SXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjNWOsrikAOM/wqkHxpWheOZnguCN9PHZCzFhN8cUoo=;
        b=oNdoRumeOsb37ojZfnnEWXaB7td40E6pon00IrIO8DydHgxkGbFWB1aXoaUMinZn/j
         sEIdKFXSac2PSo65sJl+C2ing57e3srRcL/dXNYlJsXpDV3XPtSiioIg4t+jm+hDevjg
         K24iEFBukZj04yLZKIbr7WOlL27tbdPDiOBixh8VjEBXhx0yfzo1CuWLmnAFXvf6/5hN
         0CsCD5D7TnLzApA1uIILAeXSbmZydcRVn9pTS8ENTX6uBA6DH2DBzm7KVXAnSNyq/MW9
         6zb2N8zUSYLJZNumpgWH0C90npKhB6AJhNLST+UyScmnriwebBMBgY3bKOLbCtaFqhRA
         MsEw==
X-Gm-Message-State: APjAAAW/HiAcGVYnoOo/44eiMExsEFYqgvtMnDEFvwQHYc0bhaaCBIqh
        dQ30pu3nAQ6QGeq2jFD6Ec3DievgKQI46+NrsmNyrw==
X-Google-Smtp-Source: APXvYqxtedqB/Tg6y1D+091GgWVPbxpPN7WPXefIYVREnly3B/dZWltLlnz2PuTyQhAl7IsH5G7zUGIk5QxJ/t15CuI=
X-Received: by 2002:a2e:834d:: with SMTP id l13mr15501214ljh.97.1556054966691;
 Tue, 23 Apr 2019 14:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <1556034515-28792-1-git-send-email-paul.gortmaker@windriver.com> <1556034515-28792-6-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1556034515-28792-6-git-send-email-paul.gortmaker@windriver.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 23:29:15 +0200
Message-ID: <CACRpkdYSB6Mb7UHJbNZ_9SmSeYBshMjFdai6+CN5Deiu=zT3RQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] watchdog: coh901327: make it explicitly non-modular
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Tue, Apr 23, 2019 at 5:50 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> The Kconfig currently controlling compilation of this code is:
>
> config COH901327_WATCHDOG
>        bool "ST-Ericsson COH 901 327 watchdog"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
>
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
>
> Also note that MODULE_ALIAS is a no-op for non-modular code.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> We replace module.h with moduleparam.h since the file does actually
> declare some module parameters (i.e. boot args for non-modules).
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for doing this Paul.

Yours,
Linus Walleij
