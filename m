Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52241 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759651AbbKUBLF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Nov 2015 20:11:05 -0500
Subject: Re: [PATCH v2 4/6] watchdog: gpio_wdt: use core reboot notifier
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448056496-2335-5-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564FC4A6.3030305@roeck-us.net>
Date: Fri, 20 Nov 2015 17:11:02 -0800
MIME-Version: 1.0
In-Reply-To: <1448056496-2335-5-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/20/2015 01:54 PM, Damien Riegel wrote:
> Get rid of the custom reboot notifier block registration and use the one
> provided by the watchdog core.
>
> Note that this watchdog used to stop unconditionnaly on SYS_HALT and
> SYS_POWER_OFF. The core function now calls ops->stop on SYS_HALT and
> SYS_DOWN. To prevent the watchdog from being stopped on reboot, the
> "always-running" property must be set, otherwise it will now be stopped.
>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

