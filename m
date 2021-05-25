Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0934C47085
	for <linux-watchdog@archiver.kernel.org>; Tue, 25 May 2021 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D08C61420
	for <linux-watchdog@archiver.kernel.org>; Tue, 25 May 2021 13:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhEYNsP (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 25 May 2021 09:48:15 -0400
Received: from elvis.franken.de ([193.175.24.41]:48744 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233339AbhEYNsO (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 May 2021 09:48:14 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1llXO3-00079x-02; Tue, 25 May 2021 15:46:23 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id EEE8DC1109; Tue, 25 May 2021 15:39:40 +0200 (CEST)
Date:   Tue, 25 May 2021 15:39:40 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: export rt_sysc_membase for rt2880_wdt.c
Message-ID: <20210525133940.GC11166@alpha.franken.de>
References: <20210517005417.18338-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517005417.18338-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Sun, May 16, 2021 at 05:54:17PM -0700, Randy Dunlap wrote:
> rt2880_wdt.c uses (well, attempts to use) rt_sysc_membase. However,
> when this watchdog driver is built as a loadable module, there is a
> build error since the rt_sysc_membase symbol is not exported.
> Export it to quell the build error.
> 
> ERROR: modpost: "rt_sysc_membase" [drivers/watchdog/rt2880_wdt.ko] undefined!
> 
> Fixes: 473cf939ff34 ("watchdog: add ralink watchdog driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: John Crispin <john@phrozen.org>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> ---
> or make the Kconfig symbol RALINK_WDT bool instead of tristate?
> 
>  arch/mips/ralink/of.c |    2 ++
>  1 file changed, 2 insertions(+)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
