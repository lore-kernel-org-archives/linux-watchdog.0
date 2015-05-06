Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58341 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbbEFNlf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 May 2015 09:41:35 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YpzZu-0048eB-Ru
	for linux-watchdog@vger.kernel.org; Wed, 06 May 2015 13:41:34 +0000
Message-ID: <554A19E0.20509@roeck-us.net>
Date: Wed, 06 May 2015 06:40:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	linux-watchdog@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	timo.kokkonen@offcode.fi, kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: imx2_wdt: also set wdog->timeout to new_timeout
References: <1430911079-23738-1-git-send-email-m.grzeschik@pengutronix.de>
In-Reply-To: <1430911079-23738-1-git-send-email-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/06/2015 04:17 AM, Michael Grzeschik wrote:
> Commit faad5de0b104 ("watchdog: imx2_wdt: convert to watchdog core api")
> removes the custom ioctl function. The generic ioctl handler is not
> setting the wdog->timeout to the new_timeout but handing this preset
> value back to the userspace. This patch sets the new value in the
> drivers set_timeout function to fix that problem.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

