Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52173 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759651AbbKUBKk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Nov 2015 20:10:40 -0500
Subject: Re: [PATCH v2 6/6] watchdog: w83627hf_wdt: use core reboot notifier
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448056496-2335-7-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564FC48D.2050107@roeck-us.net>
Date: Fri, 20 Nov 2015 17:10:37 -0800
MIME-Version: 1.0
In-Reply-To: <1448056496-2335-7-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/20/2015 01:54 PM, Damien Riegel wrote:
> Get rid of the custom reboot notifier block registration and use the one
> provided by the watchdog core.
>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

