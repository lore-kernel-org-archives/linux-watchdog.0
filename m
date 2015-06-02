Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40217 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758926AbbFBNoz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Jun 2015 09:44:55 -0400
Message-ID: <556DB350.4000803@roeck-us.net>
Date: Tue, 02 Jun 2015 06:44:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Johannes Thumshirn <jthumshirn@suse.de>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: mena21_wdt: Fix possible NULL pointer dereference
References: <1433240726-7031-1-git-send-email-jthumshirn@suse.de>
In-Reply-To: <1433240726-7031-1-git-send-email-jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/02/2015 03:25 AM, Johannes Thumshirn wrote:
> In a21_wdt_remove() we do a watchdog_unregister_device() on struct
> a21_wdt_drv->wdt but never assign it.
>
> Also move the dev_set_drvdata() call in front of the watchdog_register_device()
> call, so it doesn't look like an error.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Good catch.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

