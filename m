Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:57831 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbaDZPel (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 26 Apr 2014 11:34:41 -0400
Message-ID: <535BD20F.6020103@roeck-us.net>
Date: Sat, 26 Apr 2014 08:34:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Gabor Juhos <juhosg@openwrt.org>, Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ath79_wdt: avoid spurious restarts on AR934x
References: <1397640881-21741-1-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1397640881-21741-1-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/16/2014 02:34 AM, Gabor Juhos wrote:
> On some AR934x based systems, where the frequency of
> the AHB bus is relatively high, the built-in watchdog
> causes a spurious restart when it gets enabled.
>
> The possible cause of these restarts is that the timeout
> value written into the TIMER register does not reaches
> the hardware in time.
>
> Add an explicit delay into the ath79_wdt_enable function
> to avoid the spurious restarts.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

