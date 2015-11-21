Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52014 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760042AbbKUBKK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Nov 2015 20:10:10 -0500
Subject: Re: [PATCH v2 1/6] watchdog: core: add reboot notifier support
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448056496-2335-2-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564FC46D.2030908@roeck-us.net>
Date: Fri, 20 Nov 2015 17:10:05 -0800
MIME-Version: 1.0
In-Reply-To: <1448056496-2335-2-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/20/2015 01:54 PM, Damien Riegel wrote:
> Many watchdog drivers register a reboot notifier in order to stop the
> watchdog on system reboot. Thus we can factorize this code in the
> watchdog core.
>
> For that purpose, a new notifier block is added in watchdog_device for
> internal use only, as well as a new watchdog_stop_on_reboot helper
> function.
>
> If this helper is called, watchdog core registers the related notifier
> block and will stop the watchdog when SYS_HALT or SYS_DOWN is received.
>
> Since this operation can be critical on some platforms, abort the device
> registration if the reboot notifier registration fails.
>
> Suggested-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Series looks good to me.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I'll apply the series to my watchdog-next branch and run it through a test cycle.

Guenter

