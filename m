Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32843 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbeEQIdf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 May 2018 04:33:35 -0400
Message-ID: <1526546011.2971.1.camel@pengutronix.de>
Subject: Re: [PATCH v3] watchdog: da9063: Fix setting/changing timeout
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Marco Felsch <m.felsch@pengutronix.de>, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc: kernel@pengutronix.de, support.opensource@diasemi.com,
        fzuuzf@googlemail.com, linux-watchdog@vger.kernel.org
Date: Thu, 17 May 2018 10:33:31 +0200
In-Reply-To: <20180517070354.5318-1-m.felsch@pengutronix.de>
References: <20180517070354.5318-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 2018-05-17 at 09:03 +0200, Marco Felsch wrote:
> If the timeout value is set more than once the DA9063 watchdog triggers
> a reset signal which reset the system.
> 
> To update the timeout value we have to disable the watchdog, clear the
> watchdog counter value and write the new timeout value to the watchdog.
> Clearing the counter value is a feature to be on the safe side because the
> data sheet doesn't describe the behaviour of the watchdog counter value
> after a watchdog disabling-enable-sequence.
> 
> The patch is based on Philipp Zabel's previous patch but doesn't wait
> 150us because the DA9063 doesn't need this delay.

Actually, the delay is back now.

Otherwise,
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
