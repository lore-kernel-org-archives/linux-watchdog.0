Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34547 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbbFJFlk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Jun 2015 01:41:40 -0400
Message-ID: <5577CE13.4080403@roeck-us.net>
Date: Tue, 09 Jun 2015 22:41:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] gpio_wdt: Add option for early registration
References: <1433868903-20033-1-git-send-email-jtheou@adeneo-embedded.us> <1433868903-20033-2-git-send-email-jtheou@adeneo-embedded.us>
In-Reply-To: <1433868903-20033-2-git-send-email-jtheou@adeneo-embedded.us>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/09/2015 09:55 AM, Jean-Baptiste Theou wrote:
> In some situation, mainly when it's not possible to disable a
> watchdog, you may want the watchdog driver to be started as soon
> as possible.
>
> Adding GPIO_WATCHDOG_ARCH_INITCALL to raise initcall from
> module_init to arch_initcall.
>
> This patch require watchdog registration deferral mechanism
>
> Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
> ---

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

