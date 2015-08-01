Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43775 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbHASwK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 1 Aug 2015 14:52:10 -0400
Message-ID: <55BD1550.708@roeck-us.net>
Date: Sat, 01 Aug 2015 11:52:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>,
	linux-watchdog@vger.kernel.org
CC: wim@iguana.be, ezequiel@vanguardiasur.com.ar,
	linux-arm-kernel@lists.infradead.org, manabian@gmail.com
Subject: Re: [PATCH v5 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
References: <1438454237-22043-1-git-send-email-ariel@vanguardiasur.com.ar> <1438454237-22043-2-git-send-email-ariel@vanguardiasur.com.ar>
In-Reply-To: <1438454237-22043-2-git-send-email-ariel@vanguardiasur.com.ar>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/01/2015 11:37 AM, Ariel D'Alessandro wrote:
> This commit adds support for the watchdog timer found in NXP LPC SoCs
> family, which includes LPC18xx/LPC43xx. Other SoCs in that family may
> share the same watchdog hardware.
>
> Watchdog driver registers a restart handler that will restart the system
> by performing an incorrect feed after ensuring the watchdog is enabled in
> reset mode.
>
> As watchdog cannot be disabled in hardware, driver's stop routine will
> regularly send a keepalive ping using a timer.
>
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

