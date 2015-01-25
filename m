Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53560 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbbAYPq2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 25 Jan 2015 10:46:28 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YFPOP-002gwd-1U
	for linux-watchdog@vger.kernel.org; Sun, 25 Jan 2015 15:46:29 +0000
Message-ID: <54C50FCC.7080102@roeck-us.net>
Date: Sun, 25 Jan 2015 07:46:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH V3] watchdog: bcm47xx_wdt.c: add restart handler support
References: <1422107918-8043-1-git-send-email-zajec5@gmail.com> <1422182457-9876-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1422182457-9876-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/25/2015 02:40 AM, Rafał Miłecki wrote:
> Just like in case of other watchdog drivers, use the new kernel core
> API to provide restart support.
>
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

