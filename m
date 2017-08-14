Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35444 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752893AbdHNMjt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 08:39:49 -0400
Received: by mail-oi0-f42.google.com with SMTP id e124so82793438oig.2
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Aug 2017 05:39:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170812184318.10144-1-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Aug 2017 14:39:48 +0200
Message-ID: <CACRpkdZPRSsx=M7gjhXBa0rQKOdGRNJj-062B08ZThvh1qAaBA@mail.gmail.com>
Subject: Re: [PATCH 00/11] watchdog: Consolidate FTWDT010 derivatives
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 12, 2017 at 8:43 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The MOXA ART and Aspeed watchdogs are clearly based on the
> Faraday Technology FTWDT010 IP block.

Wim/Guenther: it is perfectly fine to just stop merging the series after
the say top 3 or top 4 ones etc. The do not need to be applied on an
all-or-nothing basis.

Yours,
Linus Walleij
