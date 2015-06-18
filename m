Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39466 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbbFRD6w (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Jun 2015 23:58:52 -0400
Message-ID: <558241F7.6070600@roeck-us.net>
Date: Wed, 17 Jun 2015 20:58:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>,
	linux-watchdog@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: bcm2835: Fix poweroff behaviour
References: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/17/2015 07:04 AM, Noralf Trønnes wrote:
> Currently poweroff/halt results in a reboot on the Raspberry Pi.
> The firmware uses the RSTS register to know which partiton to
> boot from. The partiton value is spread into bits
> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
> the firmware to indicate halt.
>
> The firmware made this change in 19 Aug 2013 and was matched
> by the downstream commit:
> Changes for new NOOBS multi partition booting from gsh
>
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

