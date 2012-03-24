Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58115 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752705Ab2CXOcJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 24 Mar 2012 10:32:09 -0400
MIME-Version: 1.0
Date: Sat, 24 Mar 2012 10:32:07 -0400
Message-ID: <CAP=VYLr4MfkBpgg-QeMRw9oDswtrySBEb6ZUKa8_CLOHh+pF2A@mail.gmail.com>
Subject: Commit "watchdog: coh901327_wdt.c: fix timeout" breaks linux-next
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: wim@iguana.be, linus.walleij@stericsson.com
Cc: linux-watchdog@vger.kernel.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

Can you please re-check this commit?  It has two instances of
the typo "timout" and one of them is causing a build failure
in linux-next.

Thanks,
Paul.
--

drivers/watchdog/coh901327_wdt.c:358:15: error: 'struct
watchdog_device' has no member named 'timout'

http://kisskb.ellerman.id.au/kisskb/buildresult/5940810/

commit 884f1a12c8b39721452f0dfedf1f82de3d696cf1
Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Thu Mar 22 20:42:16 2012 +0100

    watchdog: coh901327_wdt.c: fix timeout

    Set the timeout value properly so that we don't get faulty values
    for the WDIOC_GETTIMEOUT iotcl. 'margin' should be an unsigned int.
    Also add a check to see if margin is a valid parameter after it is
    loaded as a module.
