Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:56204 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab3KQCTR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 16 Nov 2013 21:19:17 -0500
Message-ID: <528827A3.6050108@roeck-us.net>
Date: Sat, 16 Nov 2013 18:19:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: "ivan.khoronzhuk" <ivan.khoronzhuk@ti.com>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>, wim@iguana.be,
	nsekhar@ti.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
CC: grant.likely@linaro.org, rob.herring@calxeda.com,
	pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org,
	galak@kernel.crashing.org, ijc+devicetree@hellion.org.uk,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Fwd: [PATCH 2/8] watchdog: davinci: use davinci_wdt_device structure
 to hold device data
References: <1383680783-12114-3-git-send-email-ivan.khoronzhuk@ti.com> <527A2888.5030604@ti.com>
In-Reply-To: <527A2888.5030604@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/06/2013 03:31 AM, ivan.khoronzhuk wrote:
> Some SoCs, like Keystone 2, can support more than one WDT and each
> watchdog device has to use it's own base address, clock source,
> wdd device, so add new davinci_wdt_device structure to hold device
> data.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Reviewed-by: Guenter roeck <linux@roeck-us.net>

