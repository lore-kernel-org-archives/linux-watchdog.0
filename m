Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39452 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934262AbbKTEPW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Nov 2015 23:15:22 -0500
Subject: Re: [PATCH 3/7] watchdog: cadence_wdt: use core reboot notifier
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447880542-19320-4-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564E9E57.5030306@roeck-us.net>
Date: Thu, 19 Nov 2015 20:15:19 -0800
MIME-Version: 1.0
In-Reply-To: <1447880542-19320-4-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/18/2015 01:02 PM, Damien Riegel wrote:
> Get rid of the custom reboot notifier block registration and use the one
> provided by the watchdog core.
>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

