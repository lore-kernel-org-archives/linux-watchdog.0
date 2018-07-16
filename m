Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35196 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbeGPMq2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jul 2018 08:46:28 -0400
From: michele.dionisio@gmail.com
To: wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: watchdog: davinci_wdt: add possibility to configure watchdog period 
Date: Mon, 16 Jul 2018 14:19:08 +0200
Message-Id: <20180716121909.4869-1-michele.dionisio@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Hi all, 
in davinci_wdt it is not possible to configure watchdog period. It is also
impossible to stop the watchdog so it is usefull to configure the watchdog 
before start it the first time. This patch add a module parameter to configure
the starting period before stat the watchdog (default behaviour is not changed).

I think it is a good idea to integrate this patch in mainline.

Many thanks for any comment/review and 
regards
Michele Dionisio

