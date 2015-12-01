Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47744 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbLAPTp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Dec 2015 10:19:45 -0500
Subject: Re: [PATCH v5] Zodiac Aerospace RAVE Switch Watchdog Processor Driver
To: Martyn Welch <martyn.welch@collabora.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
References: <565C911B.5010400@roeck-us.net>
 <1448964780-2129-1-git-send-email-martyn.welch@collabora.co.uk>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <565DBA8F.2070009@roeck-us.net>
Date: Tue, 1 Dec 2015 07:19:43 -0800
MIME-Version: 1.0
In-Reply-To: <1448964780-2129-1-git-send-email-martyn.welch@collabora.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/01/2015 02:13 AM, Martyn Welch wrote:
> This patch adds a driver for the Zodiac Aerospace RAVE Watchdog Procesor.
> This device implements a watchdog timer, accessible over I2C.
>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>

Hi Martyn,

Nitpick:

Applying: Zodiac Aerospace RAVE Switch Watchdog Processor Driver
/home/groeck/src/linux-staging/.git/rebase-apply/patch:461: new blank line at EOF.

Also, the subject line should start with "watchdog: ".

Other than that,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Please fix and resend with my Reviewed-by:.

Thanks,
Guenter

