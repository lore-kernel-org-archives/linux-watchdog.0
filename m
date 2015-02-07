Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59217 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757071AbbBGRLT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 7 Feb 2015 12:11:19 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YK8uc-001EbO-5d
	for linux-watchdog@vger.kernel.org; Sat, 07 Feb 2015 17:11:18 +0000
Message-ID: <54D64723.8010402@roeck-us.net>
Date: Sat, 07 Feb 2015 09:10:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] watchdog: bcm47xx_wdt.c: allow enabling on BCM5301X arch
References: <1423328650-2894-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1423328650-2894-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/07/2015 09:04 AM, Rafał Miłecki wrote:
> BCM5301X (ARCH_BCM_5301X) is a new Broadcom architecture using the same
> SoC bus driver (bcma) as BCM47XX but based on ARM instead of MIPS.
>
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

