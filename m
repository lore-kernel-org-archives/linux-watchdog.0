Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52819 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753964AbdIZFYL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Sep 2017 01:24:11 -0400
Subject: Re: [PATCH 1/2] watchdog: Fix potential kref imbalance when opening
 watchdog
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1506356222-528-1-git-send-email-linux@roeck-us.net>
From: Oleksij Rempel <ore@pengutronix.de>
Message-ID: <7f1bad2d-0f82-ee66-e9d2-c67fbe38950a@pengutronix.de>
Date: Tue, 26 Sep 2017 07:24:10 +0200
MIME-Version: 1.0
In-Reply-To: <1506356222-528-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 25.09.2017 18:17, Guenter Roeck wrote:
> If a watchdog driver's open function sets WDOG_HW_RUNNING with the
> expectation that the watchdog can not be stopped, but then stops the
> watchdog anyway in its stop function, kref_get() wil not be called in
> watchdog_open(). If the watchdog then stops on close, WDOG_HW_RUNNING
> will be cleared and kref_put() will be called, causing a kref imbalance.
> As result the character device data structure will be released, which in
> turn will cause the system to crash on the next call to watchdog_open().

Ach, ok. I see. So the stop patch should remove it from the start.
