Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61708 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaDLRow (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 12 Apr 2014 13:44:52 -0400
Message-ID: <53497B90.3010802@roeck-us.net>
Date: Sat, 12 Apr 2014 10:44:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>, linux-watchdog@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org,
	Xiubo Li <Li.Xiubo@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v2] watchdog: imx2_wdt: convert to watchdog core api
References: <1397199434-6551-1-git-send-email-agust@denx.de>
In-Reply-To: <1397199434-6551-1-git-send-email-agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/10/2014 11:57 PM, Anatolij Gustschin wrote:
> Convert the imx2_wdt driver to the new watchdog core api.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
> NOTE: This patch applies on top of the imx2_wdt regmap-mmio support
> patch series http://comments.gmane.org/gmane.linux.kernel/1677735
>
> Changes since first version:
>   - simplify return in imx2_wdt_is_running()
>   - fix "WARNING: quoted string split across lines"
>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

