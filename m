Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CF4C7EE24
	for <linux-watchdog@archiver.kernel.org>; Sat,  3 Jun 2023 20:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjFCUOS (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 3 Jun 2023 16:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFCUOR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 3 Jun 2023 16:14:17 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFCF1B4
        for <linux-watchdog@vger.kernel.org>; Sat,  3 Jun 2023 13:14:15 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 34c1601e-024b-11ee-b972-005056bdfda7;
        Sat, 03 Jun 2023 23:14:13 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:14:12 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/43] watchdog: ep93xx: add DT support for Cirrus
 EP93xx
Message-ID: <ZHufFN0USiNO9x5X@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-14-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-14-nikita.shubin@maquefel.me>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Thu, Jun 01, 2023 at 08:34:04AM +0300, Nikita Shubin kirjoitti:
> - Find register range from the device tree.

...

> +#include <linux/of.h>

Wrong header.

-- 
With Best Regards,
Andy Shevchenko


