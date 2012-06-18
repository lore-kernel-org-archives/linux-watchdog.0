Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60424 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629Ab2FRSAT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jun 2012 14:00:19 -0400
Received: by pbbrp8 with SMTP id rp8so8526559pbb.19
        for <linux-watchdog@vger.kernel.org>; Mon, 18 Jun 2012 11:00:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1339521541-30183-1-git-send-email-linus.walleij@stericsson.com>
References: <1339521541-30183-1-git-send-email-linus.walleij@stericsson.com>
Date: Mon, 18 Jun 2012 23:30:17 +0530
Message-ID: <CADTbHxqkWxjp9L-qyai=N7b4_NRaYDOw8Z-mKoFp4BqyTMZZTQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: coh901327_wdt: use clk_prepare/unprepare
From: Pankaj Jangra <jangra.pankaj9@gmail.com>
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Tue, Jun 12, 2012 at 10:49 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Make sure we prepare/unprepare the COH901327 watchdog timer
> as is required by the clk API especially if you use common
> clock.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by : Pankaj Jangra <jangra.pankaj9@gmail.com>

Regards,
Pankaj Jangra
